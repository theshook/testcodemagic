import 'package:flutter/material.dart';

class RoundedElevatedbutton extends StatelessWidget {
  final Function onPress;
  final String text;

  const RoundedElevatedbutton({Key key, this.onPress, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50),
          elevation: 10,
          shadowColor: Colors.indigo,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          textStyle: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
