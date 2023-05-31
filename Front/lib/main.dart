// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'provider/air_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AirProvider(),
      child: MaterialApp(
        title: "Justinwapo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          body: const Login(),
        ),
      ),
    );
  }
}
