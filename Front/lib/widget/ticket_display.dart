// ignore_for_file: prefer_const_constructors

import 'package:justinairlines/widget/ticket.dart';
import 'package:justinairlines/provider/air_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apiModels/flights.dart';

class TicketDisplay extends StatefulWidget {
  const TicketDisplay({Key? key}) : super(key: key);

  @override
  State<TicketDisplay> createState() => _TicketDisplayState();
}

class _TicketDisplayState extends State<TicketDisplay> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AirProvider>(
      builder: (context, provider, _) {
        final List<Flights?> flightsList = provider.flightsList;

        return ListView.builder(
          itemCount: flightsList.length,
          itemBuilder: (context, index) {
            final flight = flightsList[index];

            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Flight Details',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Departure: ${flight.departurs}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Destination: ${flight.destination}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Arrival Date: ${flight.dateArrival}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Departure Date: ${flight.departureDate}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Price: ${flight.price}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              child: Text(
                                'Close',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Ticket(
                id: flight!.id,
                departurs: flight.departurs,
                destination: flight.destination,
                dateArrival: flight.dateArrival,
                departureDate: flight.departureDate,
                price: flight.price,
                isBooked: false,
                isCancelled: false,
                index: index,
              ),
            );
          },
        );
      },
    );
  }
}
