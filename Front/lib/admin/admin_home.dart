// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, sort_child_properties_last, unused_import

import 'package:justinairlines/widget/ticket_display.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:justinairlines/admin/admin_booked.dart';
import 'package:justinairlines/apiModels/flights.dart';
import 'package:justinairlines/provider/air_provider.dart';
import '../widget/ticket.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
                    Icons.person,
                    color: Colors.white,
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
                        "Welcome, Admin!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Here are the flights",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<AirProvider>().logout();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyApp(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
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
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TicketDisplay(),
                ),
                Positioned(
                  bottom: 20,
                  left: (MediaQuery.of(context).size.width - 60) / 2,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserBookingsPage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddFlightDialog();
                            },
                          );
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddFlightDialog extends StatefulWidget {
  @override
  _AddFlightDialogState createState() => _AddFlightDialogState();
}

class _AddFlightDialogState extends State<AddFlightDialog> {
  late TextEditingController _idController;
  late TextEditingController _destinationController;
  late TextEditingController _dateArrivalController;
  late TextEditingController _departureDateController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _destinationController = TextEditingController();
    _dateArrivalController = TextEditingController();
    _departureDateController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    _destinationController.dispose();
    _dateArrivalController.dispose();
    _departureDateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Flight'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField(_idController, 'ID'),
            SizedBox(height: 16),
            _buildTextField(_destinationController, 'Destination'),
            SizedBox(height: 16),
            _buildTextField(_dateArrivalController, 'Date Arrival'),
            SizedBox(height: 16),
            _buildTextField(_departureDateController, 'Departure Date'),
            SizedBox(height: 16),
            _buildTextField(_priceController, 'Price'),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Add'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () async {
            try {
              var newFlight = Flights(
                id: _idController.text,
                departurs: "Philippines", // Assumed "Philippines"
                destination: _destinationController.text,
                dateArrival: DateTime.parse(_dateArrivalController.text),
                departureDate: DateTime.parse(_departureDateController.text),
                price: int.parse(_priceController.text),
              );
              await context.read<AirProvider>().addNewFlight(newFlight);
              print('Flight added successfully');
              Navigator.of(context).pop();
            } catch (error) {
              print('Error adding flight: $error');
            }
          },
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
