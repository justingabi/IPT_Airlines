// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justinairlines/admin/admin_home.dart';
import 'package:justinairlines/pages/home_page.dart';
import 'package:justinairlines/pages/register_page.dart';
import 'package:justinairlines/apiModels/booked_flights.dart';
import 'package:justinairlines/provider/air_provider.dart';

import '../apiModels/flights.dart';
import '../apiModels/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool?> loginUser(String email, String password) async {
    if (email == "admin@email.com" && password == "123") {
      return true;
    }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login/'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];

      if (token.startsWith('A-')) {
        return true;
      } else if (token.startsWith('U-')) {
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error! Failed to Login')),
      );
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 14, 19),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.airplanemode_active,
                  size: 300,
                  color: Color.fromARGB(255, 55, 91, 145),
                ),
                SizedBox(height: 20),
                Text(
                  "Book a flight now!",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(
                  height: 120,
                ),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 34, 70, 100)),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 34, 70, 100)),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    suffixIcon: Icon(Icons.remove_red_eye, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Register()));
                      },
                      child: const Text(
                        "Register Account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 53,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 34, 70, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    minimumSize: Size(200, 60),
                  ),
                  onPressed: () async {
                    final bool? istrue = await loginUser(
                        emailController.text, passwordController.text);

                    if (istrue == true) {
                      final Users users =
                          await fetchUsersByEmail(emailController.text);
                      print(users.userId);
                      context.read<AirProvider>().addUser(users);
                      final List<Flights> list = await getFlights();
                      context.read<AirProvider>().addFlights(list);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminPage(),
                        ),
                      );
                    } else if (istrue == false) {
                      final Users users =
                          await fetchUsersByEmail(emailController.text);
                      print(users.userId);
                      context.read<AirProvider>().addUser(users);
                      final List<Flights> list = await getFlights();
                      context.read<AirProvider>().addFlights(list);

                      final List<BookedFlights> bookedflights =
                          await fetchBookedFlights(users.userId);
                      context
                          .read<AirProvider>()
                          .addAllBookedFlight(bookedflights);

                      final List<Flights?> bookedlist =
                          await fetchUserBookedFlights(users.userId);
                      context.read<AirProvider>().flightsBooked(bookedlist);
                      final List<Flights?> bookedlistC =
                          await fetchUserBookedFlightsCancelled(users.userId);
                      context
                          .read<AirProvider>()
                          .addAllBookedFlightCancelled(bookedlistC);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
