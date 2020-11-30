/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-09-25 10:50:20
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-30 15:44:11
 */
import 'package:clearlove_flutter_learn/routes/router.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/search',
      onGenerateRoute: onGenerateRoute,
      builder: EasyLoading.init(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}
