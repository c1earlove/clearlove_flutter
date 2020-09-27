import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Text clearlove_text(
  String text, {
  double size = 14.0,
  Color color = Colors.red,
}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size),
  );
}
