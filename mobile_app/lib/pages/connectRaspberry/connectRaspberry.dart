import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectRaspberry extends StatefulWidget {
  const ConnectRaspberry({super.key});

  @override
  State<ConnectRaspberry> createState() => _ConnectRaspberryState();
}

class _ConnectRaspberryState extends State<ConnectRaspberry> {
  Future<void> clearPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool('isConnected', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: IconButton(
            icon: Icon(Icons.clear), onPressed: () => clearPreferences()),
      ),
    );
  }
}
