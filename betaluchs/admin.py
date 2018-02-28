from django import forms
from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.forms import ReadOnlyPasswordHashField


from .models import Project
from .models import Textsort
from .models import Genre
from .models import Theme
from .models import Facts
from .models import Document
from .models import Language
from .models import Level
from .models import Priority
from .models import Focus
from .models import User
from .models import Betareader


class UserCreationForm(forms.ModelForm):
    """"
    A form for creating new users.
    Include all the required fields,
    plus a repeated password.
    """

    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Password confirmation', widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ('username', 'email', 'date_of_birth')

    def clean_password2(self):
        # Chat that the two password entries match
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValifationError("Passwords don't match!")
        return password2

    def safe(self, commit=True):
        # Safe the provided password in hashed format
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user


class UserChangeForm(forms.ModelForm):
    """ A Form for updating users. Includes all the fields on
    the user, but replaces the password field with admin'a
    password hash display field."""

    password = ReadOnlyPasswordHashField()

    class Meta:
        model = User
        fields = (
            'username',
            'email',
            'password',
            'date_of_birth',
            'is_active',
            'is_admin'
        )

        def clean_password(self):
            # Regardless of what the user provides, return the initial value.
            # This is done here, rather than on the field, because the
            # field does not have access to the initial value
            return self.initial["password"]


class UserAdmin(BaseUserAdmin):
    # The forms to add an chance user instances
    form = UserChangeForm
    add_form = UserCreationForm

    # The fields to be used in displaying the User model.
    # These override the definitions on the base UserAdmin
    # that reference specific fields on auth.User.
    list_display = ('username', 'email', 'date_of_birth', 'is_admin')
    list_filter = ('is_admin', )
    fieldsets = (
        (None, {'fields': ('username', 'email', 'password')}),
        ('Personal info', {'fields': ('date_of_birth', )}),
        ('Permissions', {'fields': ('is_admin', )}),
    )
    # add_fieldsets is not a standard ModelAdmin attribute.
    # UserAdmin overrides get_fieldsets to use this attribute when creating a user.

    add_fieldsets = (
        (None, {
            'classes': ('wide', ),
            'fields': ('username', 'email', 'date_of_birth', 'password1', 'password2')
        }),
    )
    search_fields = ('username', 'email')
    ordering = ('username', 'date_joined')
    filter_horizontal = ()


admin.site.register(Project)
admin.site.register(Textsort)
admin.site.register(Theme)
admin.site.register(Genre)
admin.site.register(Facts)
admin.site.register(Betareader)
admin.site.register(Document)
admin.site.register(Language)
admin.site.register(Level)
admin.site.register(Priority)
admin.site.register(Focus)

admin.site.register(User, UserAdmin)
admin.site.unregister(Group)
