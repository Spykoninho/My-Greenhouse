import 'package:flutter/material.dart';
import 'package:my_greenhouse/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Greenhouse',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
