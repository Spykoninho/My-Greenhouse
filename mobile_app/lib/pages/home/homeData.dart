import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeData extends StatefulWidget {
  const HomeData({super.key});

  @override
  State<HomeData> createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> {
  Timer? timer;
  String greenhouseName = "";
  String temperature = "";
  String humidity = "";
  String soilHumidity = "";

  @override
  void initState() {
    super.initState();
    getAllGreenhouses();
    fetchSharedVars();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetchSharedVars();

      setState(() {
        getAllGreenhouses();
      });
    });
  }

  Future<String> getSharedVar(name) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var spVar = sp.getString(name) ?? "";
    return spVar;
  }

  Future<void> fetchSharedVars() async {
    greenhouseName = await getSharedVar("greenhouse_name");
    temperature = await getSharedVar("temperature");
    humidity = await getSharedVar("humidity");
    soilHumidity = await getSharedVar("soil_humidity");

    setState(() {});
  }

  Future<void> getAllGreenhouses() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      var api_url = dotenv.env['API_HTTPS_URL'] ?? "";
      var jwt = sp.getString("jwt") ?? "";
      var url = Uri.https(api_url, '/api/getMyGreenhouses');
      var apiRes = await http.get(url, headers: {'Authorization': jwt});
      var parsed = jsonDecode(apiRes.body);
      if (apiRes.statusCode == 200) {
        var greenhouses = parsed["greenhouses"];
        sp.setString(
            "greenhouse_name", greenhouses[0]['greenhouse_name'].toString());
        sp.setString("temperature", greenhouses[0]['temperature'].toString());
        sp.setString("humidity", greenhouses[0]['humidity'].toString());
        sp.setString(
            "soil_humidity", greenhouses[0]['soil_humidity'].toString());
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Mes serres",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text("${greenhouseName} :",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              )),
                        ],
                      ),
                      if (greenhouseName != "")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Text(
                                "${temperature}°C",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                ),
                              ),
                              Icon(
                                Icons.device_thermostat,
                                color: Colors.red,
                              ),
                            ]),
                            Row(
                              children: [
                                Text(
                                  "${humidity}%",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                  ),
                                ),
                                Icon(
                                  Icons.air,
                                  color: Colors.blueGrey,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${soilHumidity}%",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                  ),
                                ),
                                Icon(
                                  Icons.water_drop,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "voir plus",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
