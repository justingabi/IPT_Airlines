import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:justinairlines/apiModels/booked_flights.dart';

class UserBookingsPage extends StatelessWidget {
  Future<List<BookedFlights>> fetchBookedFlightsAll() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/bookedflights/'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<BookedFlights> bookedFlights =
          responseData.map((data) => BookedFlights.fromJson(data)).toList();
      return bookedFlights;
    } else {
      throw Exception('Failed to load booked flights');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 32, 44),
        title: Text('User Bookings'),
      ),
      body: Container(
        color: Color.fromARGB(255, 25, 32, 44),
        child: FutureBuilder<List<BookedFlights>>(
          future: fetchBookedFlightsAll(),
          builder: (BuildContext context,
              AsyncSnapshot<List<BookedFlights>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<BookedFlights> bookedFlights = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Total Flights being Booked: ${bookedFlights.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bookedFlights.length,
                      itemBuilder: (BuildContext context, int index) {
                        final BookedFlights bookedFlight = bookedFlights[index];
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 56, 78, 119),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: Color.fromARGB(255, 56, 78, 119),
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              'Booking ID: ${bookedFlight.id}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  'Flight ID: ${bookedFlight.flight}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 182, 210, 233),
                                  ),
                                ),
                                Text(
                                  'User ID: ${bookedFlight.user}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 182, 210, 233),
                                  ),
                                ),
                                Text(
                                  'Cancelled: ${bookedFlight.isCancelled ? 'Yes' : 'No'}',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 182, 210, 233),
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
