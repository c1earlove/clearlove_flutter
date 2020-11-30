/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-26 15:14:45
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-30 15:36:25
 */

import 'package:clearlove_flutter_learn/config/config.dart';
import 'package:clearlove_flutter_learn/model/product_model.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/utils/clearlove_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductListPage extends StatefulWidget {
  final Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // 通过事件打开侧边栏，需要全局声明一下
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // 配置下拉加载更多
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  // 一页10条
  int _pageSize = 10;
  // 分页
  List _productList = [];
  // 排序
  String _sort = "";
  // 解决重复请求的问题
  bool flag = true;
  // 是否有数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _getProductListData();
  }

  _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    var api =
        "${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    print("000000--- api = $api");
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);
    print(productList.result);
    if (productList.result.length < this._pageSize) {
      setState(() {
        this._productList.addAll(productList.result);
        this._hasMore = false;
        this.flag = true;
        EasyLoading.dismiss();
      });
    } else {
      setState(() {
        this._productList.addAll(productList.result);
        this._page++;
        this.flag = true;
        EasyLoading.dismiss();
      });
    }
  }

  // Widget _showMore(index) {
  //   if (this._hasMore) {
  //     return (index == this._productList.length - 1)
  //         ? EasyLoading.show(status: "加载中...")
  //         : Text("");
  //   } else {
  //     return (index == this._productList.length - 1)
  //         ? Text("---暂无其他数据了---")
  //         : Text("");
  //   }
  // }

  // 商品列表
  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: ListView.builder(
          itemCount: this._productList.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            String picUrl = this._productList[index].pic;
            picUrl = Config.domain + picUrl.replaceAll("\\", "/");
            String title = this._productList[index].title;
            String price = "￥ ${this._productList[index].price}";
            // 获得每一个元素
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network(
                        picUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: ScreenAdaper.height(180),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text("4G"),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text("16G"),
                                ),
                              ],
                            ),
                            Text(
                              price,
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                ),
                // this._showMore(index),
              ],
            );
          },
        ),
      );
    } else {
      return clearlove_text("暂无数据", color: Colors.red);
    }
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.getScreenWidth(),
      child: Container(
        height: ScreenAdaper.height(80),
        width: ScreenAdaper.getScreenWidth(),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(233, 233, 233, 0.9),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.height(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: clearlove_text(
                    "综合",
                    color: Colors.red,
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.height(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: clearlove_text(
                    "销量",
                    color: Colors.red,
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.height(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: clearlove_text(
                    "价格",
                    color: Colors.red,
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.height(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: clearlove_text(
                    "筛选",
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: clearlove_text(
          "商品列表",
          size: 20,
          color: Colors.white,
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          child: clearlove_text("实现筛选功能"),
        ),
      ),
      body: Stack(
        children: [
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}
