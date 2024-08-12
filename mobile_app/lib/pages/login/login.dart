import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/widgets/large_header.dart';
import 'package:mobile_app/pages/login/login_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.primary,
        systemNavigationBarIconBrightness: Brightness.light));

    return PopScope(
        onPopInvoked: (didPop) => leaveApp(),
        canPop: false,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Stack(
            children: <Widget>[
              LargeHeader(),
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 1,
                            ),
                            Text("Connexion",
                                style: Theme.of(context).textTheme.titleLarge),
                            LoginForm(),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x25000000),
                                  spreadRadius: 5,
                                  blurRadius: 4,
                                  offset: Offset(0, 4))
                            ]),
                      ),
                    ],
                  ),
                ),
                top: 0,
                left: 0,
              ),
              Positioned(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/greenLogoBgRemoveNoText.png',
                      width: 100,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                top: 70,
                left: 0,
                width: MediaQuery.of(context).size.width,
              )
            ],
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).colorScheme.primary,
            width: MediaQuery.of(context).size.width,
            height: 64 + 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Déjà inscrit ?",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Se connecter",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white),
                )
              ],
            ),
          ),
        ));
  }
}
