// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class BookedFlights {
  final String id;
  final String user;
  final String flight;
  late final bool isCancelled;

  BookedFlights({
    required this.id,
    required this.user,
    required this.flight,
    required this.isCancelled,
  });

  factory BookedFlights.fromJson(Map<String, dynamic> json) {
    return BookedFlights(
      id: json["id"],
      user: json['user'],
      flight: json['flight'],
      isCancelled: json['is_cancelled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'flight': flight,
      'is_cancelled': isCancelled,
    };
  }
}

Future<bool> createBookedFlight(
    BookedFlights bookedFlights, String userId, String flightId) async {
  var url = Uri.parse('http://127.0.0.1:8000/savedbookflights/');
  var requestBody = json.encode(bookedFlights.toJson());

  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: requestBody,
  );

  if (response.statusCode == 201) {
    print('Booked flight created successfully');
    return true;
  } else {
    print('Failed to create booked flight. Error: ${response.statusCode}');
    return false;
  }
}

Future<List<BookedFlights>> fetchBookedFlights(String userId) async {
  final url = Uri.parse('http://127.0.0.1:8000/bookedflights/$userId');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((data) => BookedFlights.fromJson(data)).toList();
  } else {
    throw Exception('Failed to fetch booked flights');
  }
}

Future<bool> cancelBookedFlight(String userId, String flightId) async {
  final url =
      'http://127.0.0.1:8000/users/$userId/bookedflights/$flightId/cancel/';

  try {
    final response = await http.put(Uri.parse(url));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Error cancelling booked flight: $error');
  }
  return false;
}

Future<bool> reBookedFlight(String userId, String flightId) async {
  final url =
      'http://127.0.0.1:8000/users/$userId/bookedflights/$flightId/rebooked/';

  try {
    final response = await http.put(Uri.parse(url));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Error cancelling booked flight: $error');
  }
  return true;
}
