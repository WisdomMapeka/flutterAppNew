# Generated by Django 5.1.7 on 2025-03-08 07:43

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='farmtype',
            old_name='farmer_name',
            new_name='farm_type',
        ),
    ]
