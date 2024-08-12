import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final pwdController = TextEditingController();
  bool? isChecked = false;
  bool _passwordVisible = true;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    pwdController.dispose();
  }

  Future<void> _login(username, pwd, stayConnected) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      var api_url = dotenv.env['API_HTTPS_URL'] ?? "";
      var url = Uri.https(api_url, '/api/login');
      var response =
          await http.post(url, body: {'username': username, 'password': pwd});
      var parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jwt = parsed['jwt'];
        await sharedPreferences.setString('jwt', jwt);
        await sharedPreferences.setBool('isConnected', stayConnected);
        Navigator.of(context).pushNamed('ConnectRaspberry');
      } else {
        var error = parsed['error'];
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Erreur"),
                content: Text(error),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      usernameController.clear();
                      pwdController.clear();
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              );
            });
      }
    } catch (e) {
      print('Error : ${e}');
      AlertDialog(
        title: Text("Erreur"),
        content: Text(e.toString()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              usernameController.clear();
              pwdController.clear();
            },
            icon: Icon(Icons.close),
          )
        ],
      );
    }
  }

  Future<void> isLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("isConnected") == true) {
      Navigator.of(context).pushNamed('ConnectRaspberry');
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogin();
    return Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2)),
                          hintText: "email@gmail.com",
                          labelText: "Email ou nom d'utilisateur",
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey)),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Merci de renseigner le champs ci-dessus';
                        return null;
                      },
                      controller: usernameController,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextFormField(
                      obscureText: _passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2)),
                          hintText: "********",
                          labelText: "Mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () => setState(() {
                              _passwordVisible = !_passwordVisible;
                            }),
                          ),
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey)),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Merci de renseigner le champs ci-dessus';
                        return null;
                      },
                      controller: pwdController,
                    ))
              ],
            ),
            CheckboxListTile(
              value: isChecked,
              title: Text("Rester connecter"),
              onChanged: (bool? value) => {
                setState(() {
                  isChecked = value!;
                })
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final username = usernameController.text;
                            final pwd = pwdController.text;
                            _login(username, pwd, isChecked);
                          }
                        },
                        child: const Text("Se connecter"))),
                Text(
                  "Mot de passe oublié ?",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            )
          ],
        ));
  }
}
