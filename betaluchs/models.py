from django.db import models


class Project(models.Model):
    title = models.CharField(max_length=200)
    description = models.CharField(max_length=240)

    def __str__(self):
        return self.title + ' - ' + self.description