from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.login_view),
    path('users/', views.users_list),
    path('users/<str:email>', views.get_user_by_email),
    path('flights/', views.get_flights),
    path('addflight/', views.add_flight),
    path('allflights/', views.get_all_flights, name='all_flights'),
    path('bookedflights/', views.getBookedFlights),
    path('bookedflights/<str:user_id>', views.getUserBookedFlights),
    path('savedbookflights/', views.create_booked_flight),
    path('users/<str:user_id>/booked-flights/', views.get_user_booked_flights, name='user_booked_flights'),
    path('users/<str:user_id>/booked-flights-cancelled/', views.get_cancelled_flights, name='user_booked_flights'),
    path('users/<str:user_id>/bookedflights/<str:flight_id>/cancel/', views.cancel_booked_flight, name='cancel_booked_flight'),
    path('users/<str:user_id>/bookedflights/<str:flight_id>/rebooked/', views.rebooked_flight, name='rebooked_flight'),
    path('register/', views.register_user),
    ]