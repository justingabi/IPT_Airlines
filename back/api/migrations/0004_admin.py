# Generated by Django 4.2 on 2023-05-28 13:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("api", "0003_bookedflights_is_cancelled"),
    ]

    operations = [
        migrations.CreateModel(
            name="Admin",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("email", models.EmailField(blank=True, max_length=100, null=True)),
                ("password", models.CharField(blank=True, max_length=100, null=True)),
            ],
        ),
    ]
