import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/widgets/large_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectRaspberry extends StatefulWidget {
  const ConnectRaspberry({super.key});

  @override
  State<ConnectRaspberry> createState() => _ConnectRaspberryState();
}

class _ConnectRaspberryState extends State<ConnectRaspberry> {
  Future<void> backLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool('isConnected', false);
    sharedPreferences.remove('jwt');
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Stack(
          children: <Widget>[
            LargeHeader(),
            Positioned(
              top: 30,
              left: 0,
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => backLogin()),
            ),
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Connecter le boitier",
                              style: Theme.of(context).textTheme.titleLarge),
                          Text(
                            "Executez le script \"configUsr.sh\" à la racine de la machine puis cliquez sur valider.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Icon(
                            Icons.article_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Valider"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white),
                              ))
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
              top: 145,
              left: 0,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ));
  }
}
