// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import
import 'package:justinairlines/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justinairlines/pages/cancelled_page.dart';
import 'package:justinairlines/pages/home_page.dart';
import 'package:justinairlines/provider/air_provider.dart';
import '../widget/booked_tickets.dart';

class BookedTickets extends StatelessWidget {
  const BookedTickets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            color: Color.fromARGB(255, 25, 32, 44),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.airplanemode_active_rounded,
                    color: Colors.blue,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Booked Flights",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Consumer<AirProvider>(
                        builder: (context, provider, _) {
                          final int totalBookedFlights =
                              provider.getTotalBookedFlights();
                          return Text(
                            'Total Flights Booked: $totalBookedFlights',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 11, 14, 19),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: BookedTicketDisplay(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CancelledBookedTickets(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
