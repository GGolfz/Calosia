import 'package:flutter/material.dart';

class SourceButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Function onTap;
  SourceButton(
      {required this.text,
      required this.textColor,
      required this.color,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 45,
          width: 320,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ));
  }
}
