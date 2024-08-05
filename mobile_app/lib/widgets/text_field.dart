import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hint;

  const InputField({
    Key? key,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: TextField(
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
