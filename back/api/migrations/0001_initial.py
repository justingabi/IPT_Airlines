# Generated by Django 4.1.7 on 2023-05-17 06:28

import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Flights',
            fields=[
                ('id', models.CharField(max_length=100, primary_key=True, serialize=False)),
                ('departurs', models.CharField(default='Philippines', max_length=100)),
                ('destination', models.CharField(max_length=100)),
                ('dateArrival', models.DateField(blank=True, null=True)),
                ('departureDate', models.CharField(blank=True, max_length=100, null=True)),
                ('price', models.IntegerField(validators=[django.core.validators.MinValueValidator(1)])),
            ],
        ),
        migrations.CreateModel(
            name='Users',
            fields=[
                ('userId', models.CharField(max_length=100, primary_key=True, serialize=False)),
                ('email', models.EmailField(blank=True, max_length=100, null=True)),
                ('password', models.CharField(blank=True, max_length=100, null=True)),
                ('firstname', models.CharField(max_length=100)),
                ('lastname', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Bookedflights',
            fields=[
                ('id', models.CharField(max_length=100, primary_key=True, serialize=False)),
                ('flight', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='booked_flights', to='api.flights')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='booked_flights', to='api.users')),
            ],
        ),
    ]
