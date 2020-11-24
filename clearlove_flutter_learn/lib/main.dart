/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-09-25 10:50:20
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-24 15:41:24
 */
import 'package:clearlove_flutter_learn/routes/router.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
