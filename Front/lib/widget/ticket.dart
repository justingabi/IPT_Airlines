// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:justinairlines/apiModels/flights.dart';
import 'package:justinairlines/provider/air_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../apiModels/booked_flights.dart';
import '../apiModels/user.dart';

class Ticket extends StatelessWidget {
  final String id;
  final String departurs;
  final String destination;
  final DateTime? dateArrival;
  final DateTime? departureDate;
  final int price;
  final bool isBooked;
  final bool isCancelled;
  final int index;

  const Ticket({
    Key? key,
    required this.id,
    required this.departurs,
    required this.destination,
    this.dateArrival,
    this.departureDate,
    required this.price,
    required this.isBooked,
    required this.isCancelled,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final airProvider = Provider.of<AirProvider>(context);
    List<Users?> usersList = airProvider.usersList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 56, 78, 119),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$departurs → $destination",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color.fromARGB(255, 182, 210, 233),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Flight code: $id",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 182, 210, 233),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: isBooked
                    ? null
                    : Container(
                        height: 80,
                        width: 80,
                        child: IconButton(
                          onPressed: () async {
                            const uuid = Uuid();
                            final yourId = uuid.v4();
                            final userId = usersList[0]!.userId;
                            final flightId = id;

                            BookedFlights newBookedFlight = BookedFlights(
                              id: yourId,
                              user: userId,
                              flight: flightId,
                              isCancelled: false,
                            );

                            final bool isSuc = await createBookedFlight(
                              newBookedFlight,
                              userId,
                              flightId,
                            );

                            if (isSuc) {
                              Flights bookedFlight = Flights(
                                id: id,
                                departurs: departurs,
                                departureDate: departureDate,
                                destination: destination,
                                dateArrival: dateArrival,
                                price: price,
                              );

                              context
                                  .read<AirProvider>()
                                  .addBookedFlightSS(bookedFlight);
                              context.read<AirProvider>().removeflight(index);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Ticket booked',
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 120, 240, 124),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Booking Failed'),
                                  backgroundColor:
                                      Color.fromARGB(255, 241, 93, 83),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            Icons.airplane_ticket,
                            color: Colors.green,
                            size: 50,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
