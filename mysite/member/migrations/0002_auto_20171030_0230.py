# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-10-30 02:30
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('member', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='img_profile',
            field=models.ImageField(blank=True, upload_to='user'),
        ),
    ]