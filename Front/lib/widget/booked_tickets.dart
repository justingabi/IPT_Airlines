// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:justinairlines/widget/ticket.dart';
import 'package:justinairlines/provider/air_provider.dart';
import 'package:provider/provider.dart';

import '../apiModels/booked_flights.dart';
import '../apiModels/flights.dart';

class BookedTicketDisplay extends StatefulWidget {
  const BookedTicketDisplay({Key? key}) : super(key: key);

  @override
  State<BookedTicketDisplay> createState() => _TicketDisplayState();
}

class _TicketDisplayState extends State<BookedTicketDisplay> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AirProvider>(
      builder: (context, provider, _) {
        final List<Flights?> bookedFlights = provider.bookedFlights;

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

                final bool response =
                    await cancelBookedFlight(userId, flightId);

                if (response) {
                  context.read<AirProvider>().lBookedFlightCancelled(flight);
                  context.read<AirProvider>().removedBookedFlightSS(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Flight cancelled"),
                      backgroundColor: Color.fromARGB(255, 241, 93, 83),
                    ),
                  );
                }
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.delete,
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
