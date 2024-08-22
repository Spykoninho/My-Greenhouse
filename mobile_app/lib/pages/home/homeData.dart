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
  var weather;
  String greenhouseName = "";
  String temperature = "";
  String humidity = "";
  String soilHumidity = "";
  Map<int, String> weatherConditions = {
    0: "Soleil",
    1: "Peu nuageux",
    2: "Ciel voilé",
    3: "Nuageux",
    4: "Très nuageux",
    5: "Couvert",
    6: "Brouillard",
    7: "Brouillard givrant",
    10: "Pluie faible",
    11: "Pluie modérée",
    12: "Pluie forte",
    13: "Pluie faible verglaçante",
    14: "Pluie modérée verglaçante",
    15: "Pluie forte verglaçante",
    16: "Bruine",
    20: "Neige faible",
    21: "Neige modérée",
    22: "Neige forte",
    30: "Pluie et neige mêlées faibles",
    31: "Pluie et neige mêlées modérées",
    32: "Pluie et neige mêlées fortes",
    40: "Averses de pluie locales et faibles",
    41: "Averses de pluie locales",
    42: "Averses locales et fortes",
    43: "Averses de pluie faibles",
    44: "Averses de pluie",
    45: "Averses de pluie fortes",
    46: "Averses de pluie faibles et fréquentes",
    47: "Averses de pluie fréquentes",
    48: "Averses de pluie fortes et fréquentes",
    60: "Averses de neige localisées et faibles",
    61: "Averses de neige localisées",
    62: "Averses de neige localisées et fortes",
    63: "Averses de neige faibles",
    64: "Averses de neige",
    65: "Averses de neige fortes",
    66: "Averses de neige faibles et fréquentes",
    67: "Averses de neige fréquentes",
    68: "Averses de neige fortes et fréquentes",
    70: "Averses de pluie et neige mêlées localisées et faibles",
    71: "Averses de pluie et neige mêlées localisées",
    72: "Averses de pluie et neige mêlées localisées et fortes",
    73: "Averses de pluie et neige mêlées faibles",
    74: "Averses de pluie et neige mêlées",
    75: "Averses de pluie et neige mêlées fortes",
    76: "Averses de pluie et neige mêlées faibles et nombreuses",
    77: "Averses de pluie et neige mêlées fréquentes",
    78: "Averses de pluie et neige mêlées fortes et fréquentes",
    100: "Orages faibles et locaux",
    101: "Orages locaux",
    102: "Orages fort et locaux",
    103: "Orages faibles",
    104: "Orages",
    105: "Orages forts",
    106: "Orages faibles et fréquents",
    107: "Orages fréquents",
    108: "Orages forts et fréquents",
    120: "Orages faibles et locaux de neige ou grésil",
    121: "Orages locaux de neige ou grésil",
    122: "Orages locaux de neige ou grésil",
    123: "Orages faibles de neige ou grésil",
    124: "Orages de neige ou grésil",
    125: "Orages de neige ou grésil",
    126: "Orages faibles et fréquents de neige ou grésil",
    127: "Orages fréquents de neige ou grésil",
    128: "Orages fréquents de neige ou grésil",
    130: "Orages faibles et locaux de pluie et neige mêlées ou grésil",
    131: "Orages locaux de pluie et neige mêlées ou grésil",
    132: "Orages fort et locaux de pluie et neige mêlées ou grésil",
    133: "Orages faibles de pluie et neige mêlées ou grésil",
    134: "Orages de pluie et neige mêlées ou grésil",
    135: "Orages forts de pluie et neige mêlées ou grésil",
    136: "Orages faibles et fréquents de pluie et neige mêlées ou grésil",
    137: "Orages fréquents de pluie et neige mêlées ou grésil",
    138: "Orages forts et fréquents de pluie et neige mêlées ou grésil",
    140: "Pluies orageuses",
    141: "Pluie et neige mêlées à caractère orageux",
    142: "Neige à caractère orageux",
    210: "Pluie faible intermittente",
    211: "Pluie modérée intermittente",
    212: "Pluie forte intermittente",
    220: "Neige faible intermittente",
    221: "Neige modérée intermittente",
    222: "Neige forte intermittente",
    230: "Pluie et neige mêlées",
    231: "Pluie et neige mêlées",
    232: "Pluie et neige mêlées",
    235: "Averses de grêle",
  };

  @override
  void initState() {
    super.initState();
    getTodayWeather();
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
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      var spVar = sp.getString(name) ?? "";
      return spVar;
    } catch (e) {
      print("Error : " + e.toString());
      return "";
    }
  }

  Future<void> fetchSharedVars() async {
    try {
      greenhouseName = await getSharedVar("greenhouse_name");
      temperature = await getSharedVar("temperature");
      humidity = await getSharedVar("humidity");
      soilHumidity = await getSharedVar("soil_humidity");

      setState(() {});
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<String> getInseeCode() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      var apiUrl = dotenv.env['API_HTTPS_URL'] ?? "";
      var jwt = sp.getString("jwt") ?? "";
      var route = Uri.https(apiUrl, "/api/getMyInfos");
      var apiRes = await http.get(route, headers: {'Authorization': jwt});
      var parsed = jsonDecode(apiRes.body);
      if (apiRes.statusCode == 200) {
        var userInfos = parsed['userInfos'];
        return userInfos["insee_code"];
      } else {
        return "";
      }
    } catch (e) {
      print("Error : " + e.toString());
      return "";
    }
  }

  Future<void> getTodayWeather() async {
    try {
      var inseeCode = await getInseeCode();
      var weatherToken = 'Bearer ' + (dotenv.env['WEATHER_TOKEN'] ?? "");
      var url = Uri.https("api.meteo-concept.com", "/api/forecast/daily/0",
          {'insee': inseeCode});
      var apiRes =
          await http.get(url, headers: {'Authorization': weatherToken});
      if (apiRes.statusCode == 200) {
        weather = jsonDecode(apiRes.body);
      }
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<void> getAllGreenhouses() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Météo du jour",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: weather != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Temps global : "),
                                Text(weatherConditions[weather['forecast']
                                        ['weather']]
                                    .toString())
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.thermostat,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Temperature :"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "${weather['forecast']['tmin']}-${weather['forecast']['tmax']}°C")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.wb_sunny_outlined,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Durée d'ensoleillement :"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${weather['forecast']['sun_hours']}h")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.shower,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Pluie tombée :"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${weather['forecast']['rr1']}mm")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.severe_cold,
                                  color: Colors.lightBlueAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("% chance de gel :"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${weather['forecast']['probafrost']}%")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.air,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("% chance vents violents :"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("${weather['forecast']['probawind70']}%")
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
