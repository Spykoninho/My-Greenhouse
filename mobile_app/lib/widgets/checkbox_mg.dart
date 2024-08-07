import 'package:flutter/material.dart';

class CheckboxMg extends StatefulWidget {
  const CheckboxMg({super.key});

  @override
  State<CheckboxMg> createState() => _CheckboxMgState();
}

class _CheckboxMgState extends State<CheckboxMg> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isChecked,
      title: Text("Rester connecté"),
      onChanged: (bool? value) => {
        setState(() {
          isChecked = value!;
        })
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
