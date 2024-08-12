import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void leaveApp() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Êtes vous sur ?'),
        content: new Text('Voulez-vous vraiment quitter l\'application ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text("Non")),
          TextButton(onPressed: () => exit(0), child: new Text("Oui"))
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => leaveApp(),
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.amber,
          ),
        ));
  }
}
