import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final String? hint;

  const PasswordInput({
    Key? key,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2)),
              hintText: this.hint,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey)),
        ));
  }
}
