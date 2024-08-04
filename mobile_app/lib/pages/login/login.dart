import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/large_header.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1EFE4),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text("Connexion")],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x55000000),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                    ),
                  ],
                ),
              ),
              top: 0,
              left: 0,
            ),
            Container(
              color: Colors.red,
              width: 10,
              height: 10,
            )
          ],
        ));
  }
}
