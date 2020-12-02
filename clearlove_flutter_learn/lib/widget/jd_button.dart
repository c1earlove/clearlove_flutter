import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:flutter/material.dart';

class JDButton extends StatelessWidget {
  final Color color;
  final String text;
  final Object cb;
  JDButton({Key key, this.color = Colors.black, this.text = "按钮", this.cb})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.cb,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: ScreenAdaper.height(68),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
