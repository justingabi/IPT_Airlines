from rest_framework import serializers
from .models import Users,Flights,Bookedflights

class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = '__all__'


class FlightsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Flights
        fields = '__all__'

    def create(self, validated_data):
        return Flights.objects.create(**validated_data)


class BookedflightsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bookedflights
        fields = '__all__'