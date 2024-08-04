import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return const MaterialApp(
      title: 'My Greenhouse',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
