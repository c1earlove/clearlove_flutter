import 'dart:math';

import 'package:clearlove_flutter_learn/config/config.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/widget/jd_button.dart';
import 'package:flutter/material.dart';
import 'package:clearlove_flutter_learn/model/product_content_model.dart';

class ProductPage extends StatefulWidget {
  final List _productContentList;
  ProductPage(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductContentitem _productContent;

  List _attr = [];

  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContentList[0];

    this._attr = this._productContent.attr;

    print(this._attr);
    //[{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]
  }

  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: Chip(
          label: Text("$item"),
          padding: EdgeInsets.all(10),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdaper.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: ScreenAdaper.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    });

    return attrList;
  }

  _attBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              return false;
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenAdaper.width(20)),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Wrap(
                            children: [
                              Container(
                                width: ScreenAdaper.width(10),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdaper.height(35)),
                                  child: Text(
                                    "颜色",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: ScreenAdaper.width(610),
                                child: Wrap(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Chip(
                                        label: Text("白色"),
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: ScreenAdaper.width(750),
                  height: ScreenAdaper.height(76),
                  child: Row(
                    children: [
                      Container(
                        width: ScreenAdaper.width(750),
                        height: ScreenAdaper.height(76),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: JDButton(
                                  color: Color.fromRGBO(253, 1, 0, 0.9),
                                  text: "加入购物车",
                                  cb: () {
                                    print("加入购物车");
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: JDButton(
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  text: "立即购物",
                                  cb: () {
                                    print("立即购物");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //处理图片
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network(
              pic,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.title}",
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdaper.fontSize(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${this._productContent.subTitle}",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdaper.fontSize(28)),
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
                        "¥${this._productContent.price}",
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
                        "¥${this._productContent.oldPrice}",
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
            child: InkWell(
              onTap: () {
                _attBottomSheet();
              },
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
