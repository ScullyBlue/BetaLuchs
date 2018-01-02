from django.http import HttpResponse, HttpResponseRedirect

from betaluchs.forms.new_project_form import NewProjectForm
from betaluchs.models import Project
from django.shortcuts import render, get_object_or_404

def projects(request):
    return HttpResponse(Project.objects.all())


def index(request):
    project_list = Project.objects.all()[:5]
    context = {
        'project_list': project_list,
    }
    return render(request, 'betaluchs/index.html', context)


def project_detail(request, project_id):
    project = get_object_or_404(Project, pk=project_id)
    return render(request, 'betaluchs/project_detail.html', {'project': project})


def project_new(request):
    if request.method == 'POST':
        form = NewProjectForm(request.POST)
        if form.is_valid():
            project = Project(title=form.cleaned_data['title'], description=form.cleaned_data['description'])
            project.save()
            return HttpResponseRedirect('/')
    else:
        form = NewProjectForm()
    return render(request, 'betaluchs/project_new.html', {'form': form})