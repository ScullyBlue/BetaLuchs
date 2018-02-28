from django.conf import settings
from django.db import models
from django.contrib.auth.models import (AbstractBaseUser, BaseUserManager)
from django.utils import timezone


class BetaluchsUserManager(BaseUserManager):
    # UserCreationFunction (
    def create_user(self, username, email, date_of_birth, password=None):
        """
        Creates and saves a User with given
        username, email and date of birth
        and a password.
        """
        if not email:
            raise ValueError('Users must have an email address')

        user = self.model(
            email=self.normalize_email(email),
            date_of_birth=date_of_birth,
            username=username,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, date_of_birth, password):
        """
        Creates and saves a Superuser with given
        username, email and date of birth
        and a password.
        """
        user = self.create_user(
            username=username,
            email=email,
            password=password,
            date_of_birth=date_of_birth,
        )
        user.is_admin = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser):
    username = models.CharField(max_length=40, unique=True)
    password = models.CharField(max_length=128)
    date_of_birth = models.DateField()
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(default=timezone.now)
    email = models.EmailField(verbose_name='E-Mail Adresse', max_length=255, unique=True)
    is_superuser = models.BooleanField(default='False')
    is_staff = models.BooleanField(default='False')
    is_active = models.BooleanField(default='True')
    is_admin = models.BooleanField(default='False')
    display_email = models.BooleanField(default='False')
    display_age = models.CharField(
        max_length=5,
        choices=(
            ('N', 'Not'),
            ('R', 'Range'),
            ('Y', 'Year')
        ),
        default='N'
    ),
    pgppublic = models.CharField(max_length=255, null=True)

    objects = BetaluchsUserManager()

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['date_of_birth', 'email', 'password']

    def __str__(self):
        return self.username + ' (' + self.email + ')'

    def has_perm(self, perm, obj=None):
        # Muss noch genauer definiert werden ...
        return True

    def has_module_perms(self, betaluchs):
        return True

    @property
    def is_staff(self):
        return self.is_admin

    def user_directory_path(instance, filename):
        return 'user_{0}/{1}.format(instance.user.id, filename)'


class Textsort(models.Model):
    textsort = models.CharField(max_length=25)
    sortdefinition = models.CharField(max_length=500)

    def __str__(self):
        return self.textsort


class Genre(models.Model):
    textsortID = models.ForeignKey(Textsort, on_delete=models.CASCADE)
    genre = models.CharField(max_length=25)
    genredefinition = models.CharField(max_length=500)

    def __str__(self):
        return self.genre


class Theme(models.Model):
    theme = models.CharField(max_length=30)
    themedefinition = models.CharField(max_length=500)
    themeparent = models.PositiveIntegerField(null=True)

    def __str__(self):
        return self.theme


class Level(models.Model):
    level = models.CharField(max_length=10)
    leveldefinition = models.TextField()

    def __str__(self):
        return self.level + ' (' + self.leveldefinition + ')'


class Priority(models.Model):
    priority = models.CharField(max_length=10)
    prioritydefinition = models.CharField(max_length=300)


class Focus(models.Model):
    focus = models.CharField(max_length=25)
    focusdefinition = models.TextField()
    focusparent = models.PositiveIntegerField()

    def __str__(self):
        return self.focus


class Language(models.Model):
    language = models.CharField(max_length=30)
    language_code = models.CharField(max_length=3)

    def __str__(self):
        return self.language + ' (' + self.language_code + ')'


class LanguageDialect(models.Model):
    dialect = models.CharField(max_length=50)
    language = models.ForeignKey(Language, on_delete=models.CASCADE)


class Facts(models.Model):
    fact = models.CharField(max_length=30)
    factdefinition = models.TextField()
    factparent = models.PositiveIntegerField()
    propose_date = models.DateTimeField()
    status = models.CharField(max_length=8)

    def __str__(self):
        return self.fact + ' (' + self.status + ')'


class Project(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(max_length=240)
    textsort = models.ForeignKey(Textsort, on_delete=models.PROTECT, default=0)
    genre = models.ForeignKey(Genre, on_delete=models.PROTECT, default=0)
    themes = models.ManyToManyField(Theme)
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE,default=0)

    def __str__(self):
        return self.title + ' - ' + self.description


class Document(models.Model):
    document = models.FileField(upload_to='user_directory_path')
    title = models.CharField(max_length=50)
    type = models.CharField(
        max_length=4,
        choices=(
            ('DOCX', 'docx'),
            ('DOC', 'doc'),
            ('ODT', 'odt'),
            ('PDF', 'pdf')
        ),
    )


class Betareader(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    capacity = models.IntegerField(default=0)
    genrePriority = models.ManyToManyField(
        Genre,
        through='BetaGenre',
        through_fields=('betareader', 'genre'),
    )
    themePriority = models.ManyToManyField(
        Theme,
        through='BetaTheme',
        through_fields=('betareader', 'theme'),
    )
    textsortPriotiry = models.ManyToManyField(
        Textsort,
        through='BetaTextsort',
        through_fields=('betareader', 'textsort'),
    )
    factKnowlege = models.ManyToManyField(
        Facts,
        through='BetaFacts',
        through_fields=('betareader', 'fact'),
    )
    languageKnowlege = models.ManyToManyField(
        Language,
        through='BetaLanguage',
        through_fields=('betareader', 'language')
    )
    projects = models.ManyToManyField(
        Project,
        through='Cooperation',
        through_fields=('betareader', 'project')
    )

    def __str__(self):
        return self.user


class BetaGenre(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    genre = models.ForeignKey(Genre, on_delete=models.CASCADE)
    priority = models.ForeignKey(Priority, on_delete=models.PROTECT)


class BetaTextsort(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    textsort = models.ForeignKey(Textsort, on_delete=models.CASCADE)
    priority = models.ForeignKey(Priority, on_delete=models.PROTECT)


class BetaTheme(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    theme = models.ForeignKey(Theme, on_delete=models.CASCADE)
    priority = models.ForeignKey(Priority, on_delete=models.PROTECT)


class Cooperation(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)


class BetaFacts(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    fact = models.ForeignKey(Facts, on_delete=models.PROTECT)
    level = models.ForeignKey(Level, on_delete=models.SET_DEFAULT, default=1)
    comment = models.CharField(max_length=500, null=True)
    verification = models.DateTimeField()


class BetaLanguage(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    language = models.ForeignKey(Language, on_delete=models.CASCADE)
    levelid = models.ForeignKey(Level, on_delete=models.SET_DEFAULT, default=1)
    colloguial = models.BooleanField(default=False)
    formal = models.BooleanField(default=False)
    antiquated = models.BooleanField(default=False)


class Betajob(models.Model):
    betareader = models.ForeignKey(Betareader, on_delete=models.CASCADE)
    document = models.ForeignKey(Document, on_delete=models.CASCADE)
    startDate = models.DateField()
    Jobstatus = models.CharField(
        max_length=10,
        choices=(
            ('1', 'Wartend'),
            ('2', 'In Arbeit'),
            ('3', 'Pausiert'),
            ('4', 'Abgebrochen'),
            ('5', 'Korrigiert'),
            ('6', 'Abgenommen'),
            ('7', 'Abgelehnt'),
            ('9', 'Problem'),
        ),
        default='Wartend',
    )
    stopReason = models.CharField(max_length=255, null=True)
    endDate = models.DateField(null=True)
    deadline = models.DateField()


class Communication(models.Model):
    commSender = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="Sender",
    )
    commReceiver = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="Reveiver",
    )
    message = models.CharField(max_length=2000)
    cooperation = models.ForeignKey(Cooperation, null=True, on_delete=models.CASCADE)
