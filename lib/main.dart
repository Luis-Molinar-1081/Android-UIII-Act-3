import 'package:flutter/material.dart';
import 'form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Vuelos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlightForm(),
    );
  }
}