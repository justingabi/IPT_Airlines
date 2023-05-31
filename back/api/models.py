
from django.db import models
from django.core.validators import MinValueValidator

class Users(models.Model):
    userId = models.CharField(primary_key=True, max_length=100)
    email = models.EmailField(max_length=100, blank=True, null=True)
    password = models.CharField(max_length=100, blank=True, null=True)
    firstname = models.CharField(max_length=100)
    lastname = models.CharField(max_length=100)

    def __str__(self):
        return self.userId

class Admin(models.Model):
    email = models.EmailField(max_length=100, blank=True, null=True)
    password = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.email

class Flights(models.Model):
    id = models.CharField(primary_key=True, max_length=100)
    departurs = models.CharField(max_length=100, default = "Philippines")
    destination = models.CharField(max_length=100)
    dateArrival = models.DateField(blank=True, null=True)
    departureDate = models.DateField(blank=True, null=True)
    price = models.IntegerField(validators=[MinValueValidator(1)])

    def __str__(self):
        return self.id


class Bookedflights(models.Model):
    id = models.CharField(primary_key=True, max_length=100)
    user = models.ForeignKey(Users, on_delete=models.CASCADE, related_name='booked_flights')
    flight = models.ForeignKey(Flights, on_delete=models.CASCADE, related_name='booked_flights')
    is_cancelled = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user.email} - {self.flight.destination}"



