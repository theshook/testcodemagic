import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final Function(String) validator;
  final TextEditingController controller;

  const RoundedInput(
      {Key key,
      this.hint,
      this.obscureText = false,
      this.validator,
      this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo, width: 1.0),
              borderRadius: BorderRadius.circular(25.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        controller: controller,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
