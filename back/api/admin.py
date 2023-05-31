from django.contrib import admin
from .models import Users,Flights,Bookedflights,Admin

# Register your models here.

admin.site.register(Users)
admin.site.register(Flights)
admin.site.register(Bookedflights)
admin.site.register(Admin)