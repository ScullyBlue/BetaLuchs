# Generated by Django 2.0 on 2018-01-04 13:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('betaluchs', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='betajob',
            name='Jobstatus',
            field=models.CharField(choices=[('1', 'Wartend'), ('2', 'In Arbeit'), ('3', 'Pausiert'), ('4', 'Abgebrochen'), ('5', 'Korrigiert'), ('6', 'Abgenommen'), ('7', 'Abgelehnt'), ('9', 'Problem')], default='Wartend', max_length=10),
        ),
    ]
