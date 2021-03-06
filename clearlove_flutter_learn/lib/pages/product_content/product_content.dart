import 'package:clearlove_flutter_learn/pages/product_content/product_%20evaluate.dart';
import 'package:clearlove_flutter_learn/pages/product_content/product_product.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/widget/jd_button.dart';
import 'package:flutter/material.dart';
import 'package:clearlove_flutter_learn/pages/product_content/product_detail.dart';
import 'package:clearlove_flutter_learn/config/config.dart';
import 'package:dio/dio.dart';
import 'package:clearlove_flutter_learn/model/product_content_model.dart';
import 'package:clearlove_flutter_learn/widget/loading_widget.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  List _productContentList = [];
  @override
  void initState() {
    super.initState();
    // print(this._productContentData.sId);

    this._getContentData();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';

    print(api);
    var result = await Dio().get(api);
    var productContent = new ProductContentModel.fromJson(result.data);
    print(productContent.result.pic);

    print(productContent.result.title);

    setState(() {
      this._productContentList.add(productContent.result);
    });
  }

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
        body: this._productContentList.length > 0
            ? Stack(
                children: [
                  TabBarView(
                    children: [
                      ProductPage(_productContentList),
                      ProcuctDetailPage(),
                      ProductEvaluatePage(),
                    ],
                  ),
                  Positioned(
                    width: ScreenAdaper.width(750),
                    height: ScreenAdaper.height(80),
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black54, width: 1),
                        ),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: ScreenAdaper.height(10)),
                            width: 100,
                            height: ScreenAdaper.height(88),
                            child: Column(
                              children: [
                                Icon(Icons.shopping_cart, size: 15),
                                Text("购物车"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: JDButton(
                              color: Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () {
                                print("加入购物车");
                              },
                            ),
                          ),
                          Expanded(
                            child: JDButton(
                              color: Color.fromRGBO(255, 165, 0, 0.9),
                              text: "立即购物",
                              cb: () {
                                print("立即购物");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : LoadingWidget(),
      ),
    );
  }
}
