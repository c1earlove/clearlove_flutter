import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              "https://www.itying.com/images/flutter/p1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad联想ThinkPad",
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdaper.fontSize(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text("特价"),
                      Text(
                        "￥28",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenAdaper.fontSize(46),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("原价"),
                      Text(
                        "￥50",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreenAdaper.fontSize(28),
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: ScreenAdaper.height(80),
            child: Row(
              children: [
                Text(
                  "已选",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("115 黑色"),
              ],
            ),
          ),
          Divider(),
          Container(
            height: ScreenAdaper.height(80),
            child: Row(
              children: [
                Text(
                  "运费",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("免运费"),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
