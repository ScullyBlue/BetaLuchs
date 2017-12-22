from django.http import HttpResponse
from betaluchs.models import Project


def projects(request):
    return HttpResponse(Project.objects.all())
