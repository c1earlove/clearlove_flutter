/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 11:39:01
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-26 14:35:15
 */

import 'package:clearlove_flutter_learn/config/config.dart';
import 'package:clearlove_flutter_learn/model/focus_model.dart';
import 'package:clearlove_flutter_learn/model/product_model.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/services/search_service.dart';
import 'package:clearlove_flutter_learn/utils/clearlove_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();

    SearchService.setHistoryData("aaa");
  }

// 获取轮播图数据
  _getFocusData() async {
    var api = "${Config.domain}api/focus";
    print(api);
    var result = await Dio().get(api);
    print("----------- result = $result");
    var focusList = FocusModel.fromJson(result.data);
    print("----------- focusList = ${focusList.result}");

    focusList.result.forEach((element) {
      print(element.title);
      print(element.pic);
    });
    setState(() {
      _focusData = focusList.result;
    });
  }

  // 获取猜你喜欢的数据
  _getHotProductData() async {
    var api = "${Config.domain}api/plist?is_hot=1";
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      _hotProductList = hotProductList.result;
    });
  }

  // 获取热门推荐数据
  _getBestProductData() async {
    var api = "${Config.domain}api/plist?is_best=1";
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      _bestProductList = bestProductList.result;
    });
  }

  // 轮播图
  Widget _swiperWidget() {
    // List<Map> imageList = [
    //   {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    // ];
    if (_focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (context, index) {
              String pic = _focusData[index].pic;
              pic = Config.domain + pic.replaceAll("\\", "/");
              return Image.network(
                pic,
                fit: BoxFit.fill,
              );
            },
            itemCount: _focusData.length,
            pagination: SwiperPagination(),
            control: SwiperControl(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text("加载中...");
    }
  }

  // 分组标题
  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(46),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdaper.width(10),
          ),
        ),
      ),
      child: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  // 热门商品
  Widget _hotProductListWidget() {
    if (_hotProductList.length > 0) {
      return Container(
        height: ScreenAdaper.height(240),
        padding: EdgeInsets.all(ScreenAdaper.width(10)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _hotProductList.length,
          itemBuilder: (BuildContext context, int index) {
            String sPic = _hotProductList[index].pic;
            sPic = Config.domain + sPic.replaceAll("\\", "/");
            return Column(
              children: [
                Container(
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                  child: Image.network(
                    sPic,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  height: ScreenAdaper.height(44),
                  child: Text(
                    "￥${_hotProductList[index].price}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Text("暂无热门推荐数据");
    }
  }

  Widget _recProductItemListWidget() {
    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: _bestProductList.map((element) {
          String sPic = element.pic;
          sPic = Config.domain + sPic.replaceAll("\\", "/");
          return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(20)),
            width: itemWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Column(
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      sPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  child: Text(
                    "${element.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: clearlove_text("￥${element.price}",
                            color: Colors.red, size: 16),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: clearlove_text("￥${element.oldPrice}",
                            color: Colors.black54,
                            size: 16,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    // ScreenUtil.init(context, designSize: Size(750, 1334));
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(
          height: 10,
        ),
        _titleWidget("猜你喜欢"),
        _hotProductListWidget(),
        SizedBox(
          height: 10,
        ),
        _titleWidget("热门推荐"),
        _recProductItemListWidget(),
      ],
    );
  }
}
