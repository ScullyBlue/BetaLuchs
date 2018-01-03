from django.db import models


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
        return Textsort.textsort + '>' + self.genre


class Theme(models.Model):
    theme = models.CharField(max_length=30)
    themedefinition = models.CharField(max_length=500)
    themeparent = models.PositiveIntegerField()

    def __str__(self):
        return self.theme


class Level(models.Model):
    level = models.CharField(max_length=10)
    leveldefinition = models.TextField()

    def __str__(self):
        return self.level + ' (' + self.leveldefinition + ')'


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
    textsortID = models.ForeignKey(Textsort, on_delete=models.PROTECT)
    genreID = models.ForeignKey(Genre, on_delete=models.PROTECT)
    themes = models.ManyToManyField(Theme)

    def __str__(self):
        return self.title + ' - ' + self.description