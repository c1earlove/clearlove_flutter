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
  // 是否有搜索数据
  bool _hasSearchData = true;
  // 一级导航数据
  /* 
  价格升序 sort=price_1
  价格降序 sort=price_-1
  销量升序 sort=salecount_1
  销量降序 sort=salecount_-1
   */

  List _subHeaderList = [
    {"id": 1, "title": "综合", "field": "all", "sort": -1},
    {"id": 2, "title": "销量", "field": "salecount", "sort": -1},
    {"id": 3, "title": "价格", "field": "price", "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  int _selectHeaderID = 1;
  // 配置search搜索框的值
  var _initKeywordsController = TextEditingController();
  // cid
  var _cid;
  var _keywords;

  @override
  void initState() {
    super.initState();
    this._cid = widget.arguments["cid"];
    this._keywords = widget.arguments["keywords"];
    // 给search框复制
    this._initKeywordsController.text = this._keywords;
    widget.arguments["kewwords"] == null
        ? this._initKeywordsController.text = ""
        : this._initKeywordsController.text = widget.arguments["keywords"];
    _getProductListData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          _getProductListData();
        }
      }
    });
  }

  _getProductListData() async {
    setState(() {
      this.flag = false;
    });
    print(";;;;;;;;;;;${this._keywords}");
    var api =
        "${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    if (this._keywords == null) {
      api =
          "${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    } else {
      api =
          "${Config.domain}api/plist?search=${this._keywords}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    }

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
    if (productList.result.length == 0) {
      setState(() {
        this._hasSearchData = false;
      });
    } else {
      setState(() {
        this._hasSearchData = true;
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

  // 导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState.openDrawer();
    }
    setState(() {
      this._selectHeaderID = id;
      this._sort =
          "${this._subHeaderList[id - 1]["field"]}_${this._subHeaderList[id - 1]["sort"]}";
      // 重置分页
      this._page = 1;
      // 重置数据
      this._productList = [];
      this._subHeaderList[id - 1]["sort"] =
          this._subHeaderList[id - 1]["sort"] * -1;
      // 回到顶部
      _scrollController.jumpTo(0);
      // 重置_hasMore = true;
      this._hasMore = true;
      // 重新请求数据
      this._getProductListData();
    });
  }

  // 显示header icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down);
      } else {
        return Icon(Icons.arrow_drop_up);
      }
    } else {
      return Text("");
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
          children: this._subHeaderList.map((e) {
            return Expanded(
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    ScreenAdaper.height(20),
                    0,
                    ScreenAdaper.height(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${e["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: (this._selectHeaderID == e["id"])
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      _showIcon(e["id"]),
                    ],
                  ),
                ),
                onTap: () {
                  _subHeaderChange(e["id"]);
                },
              ),
            );
          }).toList(),
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
        title: Container(
          child: TextField(
            controller: this._initKeywordsController,
            autofocus: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              setState(() {
                this._keywords = value;
              });
            },
          ),
          height: ScreenAdaper.height(68),
          decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, 0.8)),
        ),
        actions: [
          InkWell(
            child: Container(
              height: ScreenAdaper.height(68),
              width: ScreenAdaper.width(80),
              child: Row(
                children: [
                  Text("搜索"),
                ],
              ),
            ),
            onTap: () {
              this._subHeaderChange(1);
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          child: clearlove_text("实现筛选功能"),
        ),
      ),
      body: _hasSearchData
          ? Stack(
              children: [
                _productListWidget(),
                _subHeaderWidget(),
              ],
            )
          : Center(
              child: Text("没有您要浏览的数据"),
            ),
    );
  }
}
