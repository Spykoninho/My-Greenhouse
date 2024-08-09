import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/large_header.dart';
import 'package:mobile_app/widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ));
  }
}
