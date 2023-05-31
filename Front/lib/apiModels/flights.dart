// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Flights {
  final String id;
  final String departurs;
  final String destination;
  final DateTime? dateArrival;
  final DateTime? departureDate;
  final int price;

  Flights({
    required this.id,
    this.departurs = "Philippines",
    required this.destination,
    this.dateArrival,
    this.departureDate,
    required this.price,
  });

  factory Flights.fromJson(Map<String, dynamic> json) {
    return Flights(
      id: json['id'],
      departurs: json['departurs'],
      destination: json['destination'],
      dateArrival: json['dateArrival'] != null
          ? DateTime.parse(json['dateArrival'])
          : null,
      departureDate: json['departureDate'] != null
          ? DateTime.parse(json['departureDate'])
          : null,
      price: json['price'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'departurs': departurs,
      'destination': destination,
      'dateArrival':
          dateArrival != null ? dateFormat.format(dateArrival!) : null,
      'departureDate':
          departureDate != null ? dateFormat.format(departureDate!) : null,
      'price': price,
    };
  }
}

Future<List<Flights>> getFlights() async {
  final response = await http.get(Uri.parse('http://localhost:8000/flights/'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((item) => Flights.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch flights');
  }
}

Future<List<Flights>> fetchUserBookedFlights(String userId) async {
  final url = 'http://localhost:8000/users/$userId/booked-flights/';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((item) => Flights.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch booked flights');
  }
}

Future<List<Flights>> fetchUserBookedFlightsCancelled(String userId) async {
  final url = 'http://localhost:8000/users/$userId/booked-flights-cancelled/';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((item) => Flights.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch booked flights');
  }
}

Future<Flights> addFlight(Flights flight) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/addflight/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(flight.toJson()),
  );

  if (response.statusCode == 201) {
    return Flights.fromJson(jsonDecode(response.body));
  } else {
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    throw Exception('Failed to add flight');
  }
}
