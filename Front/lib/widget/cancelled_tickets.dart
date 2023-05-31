// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:justinairlines/widget/ticket.dart';
import 'package:justinairlines/apiModels/booked_flights.dart';
import 'package:justinairlines/provider/air_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apiModels/flights.dart';

class CancelledBookedTicketDisplay extends StatefulWidget {
  const CancelledBookedTicketDisplay({super.key});

  @override
  State<CancelledBookedTicketDisplay> createState() =>
      _CancelledBookedTicketDisplay();
}

class _CancelledBookedTicketDisplay
    extends State<CancelledBookedTicketDisplay> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AirProvider>(
      builder: (context, provider, _) {
        final List<Flights?> bookedFlights = provider.bookedFlightscancelled;

        return ListView.builder(
          itemCount: bookedFlights.length,
          itemBuilder: (context, index) {
            final flight = bookedFlights[index];

            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) async {
                final user = provider.usersList;
                final userId = user[0]!.userId;
                final flightId = flight.id;

                final bool response = await reBookedFlight(userId, flightId);

                if (response) {
                  context.read<AirProvider>().rebooked(flight);
                  context
                      .read<AirProvider>()
                      .removeBookedFlightCancelled(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Flight Rebooked"),
                      backgroundColor: Color.fromARGB(255, 120, 240, 124),
                    ),
                  );
                }
              },
              background: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
              child: Ticket(
                id: flight!.id,
                departurs: flight.departurs,
                destination: flight.destination,
                dateArrival: flight.dateArrival,
                departureDate: flight.departureDate,
                price: flight.price,
                isBooked: true,
                isCancelled: true,
                index: index,
              ),
            );
          },
        );
      },
    );
  }
}
