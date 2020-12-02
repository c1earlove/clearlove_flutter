import 'package:clearlove_flutter_learn/pages/product_content/product_%20evaluate.dart';
import 'package:clearlove_flutter_learn/pages/product_content/product_product.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:flutter/material.dart';
import 'package:clearlove_flutter_learn/pages/product_content/product_detail.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenAdaper.width(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      child: Text("商品"),
                    ),
                    Tab(
                      child: Text("详情"),
                    ),
                    Tab(
                      child: Text("评价"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    ScreenAdaper.width(600),
                    76,
                    10,
                    0,
                  ),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.home),
                          Text("首页"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.home),
                          Text("搜索"),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                ProductPage(),
                ProcuctDetailPage(),
                ProductEvaluatePage(),
              ],
            ),
            Positioned(
              width: ScreenAdaper.width(750),
              height: ScreenAdaper.height(80),
              bottom: 0,
              child: Container(
                color: Colors.red,
                child: Text("底部"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}