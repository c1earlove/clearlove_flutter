/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-09-25 17:10:51
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-26 17:09:22
 */
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Text clearlove_text(
  String text, {
  double size = 14.0,
  Color color = Colors.red,
  TextDecoration decoration,
  TextAlign textAlign = TextAlign.center,
}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, decoration: decoration),
    textAlign: textAlign,
  );
}
