import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      obscureText: true,
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
                            print('$username et $pwd et $isChecked');
                            // FAIRE LA REQUETE HTTP --> VOIR POUR TOUT METTRE EN HTTPS
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
