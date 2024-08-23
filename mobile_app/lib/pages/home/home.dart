import 'dart:async';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/pages/allGreenhouse/allGreenhouse.dart';
import 'package:mobile_app/pages/home/homeData.dart';
import 'package:mobile_app/pages/weather/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;

  static const List<Widget> pageList = [
    HomeData(),
    AllGreenhouse(),
    Weather(),
  ];

  Future<void> deleteShared() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('globalWeather');
    sp.remove('weatherTemperatureMax');
    sp.remove('weatherTemperatureMin ');
    sp.remove('weatherSun');
    sp.remove('weatherRain');
    sp.remove('weatherFrost');
    sp.remove('weatherWind');
  }

  void leaveApp() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Êtes vous sur ?'),
        content: new Text('Voulez-vous vraiment quitter l\'application ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text("Non")),
          TextButton(
              onPressed: () => {deleteShared(), exit(0)},
              child: new Text("Oui"))
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
          appBar: AppBar(
            actions: [
              Icon(Icons.settings),
              SizedBox(
                width: 20,
              )
            ],
            leading: Image.asset(
              'assets/images/greenLogoBgRemoveNoText.png',
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.secondary,
            centerTitle: true,
            title: Text(
              "My Greenhouse",
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).colorScheme.secondary,
            child: pageList[_page],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            animationCurve: Curves.fastEaseInToSlowEaseOut,
            color: Theme.of(context).colorScheme.primary,
            letIndexChange: (index) => true,
            onTap: (value) {
              setState(() {
                _page = value;
              });
            },
            items: [
              Icon(
                Icons.home,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Icon(
                Icons.grass,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Icon(
                Icons.sunny,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ));
  }
}
