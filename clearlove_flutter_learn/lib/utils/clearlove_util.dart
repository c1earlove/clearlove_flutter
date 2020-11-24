/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-09-25 17:10:51
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-24 17:04:15
 */
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Text clearlove_text(
  String text, {
  double size = 14.0,
  Color color = Colors.red,
  TextDecoration decoration,
}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, decoration: decoration),
  );
}
