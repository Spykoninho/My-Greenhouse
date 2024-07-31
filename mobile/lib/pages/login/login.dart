import 'package:flutter/material.dart';
import 'package:my_greenhouse/widgets/large_header.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1EFE4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Largeheader(),
        ],
      ),
    );
  }
}
