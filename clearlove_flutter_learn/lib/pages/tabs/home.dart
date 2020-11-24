/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 11:39:01
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-24 17:09:46
 */

import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/utils/clearlove_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图
  Widget _swiperWidget() {
    List<Map> imageList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (context, index) {
            return Image.network(
              imageList[index]["url"],
              fit: BoxFit.fill,
            );
          },
          itemCount: imageList.length,
          pagination: SwiperPagination(),
          control: SwiperControl(),
          autoplay: true,
        ),
      ),
    );
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
    return Container(
      height: ScreenAdaper.height(240),
      padding: EdgeInsets.all(ScreenAdaper.width(10)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                height: ScreenAdaper.height(140),
                width: ScreenAdaper.width(140),
                margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                child: Image.network(
                  "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                height: ScreenAdaper.height(44),
                child: Text("第${index}条"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _recProductItemListWidget() {
    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
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
                "https://www.itying.com/images/flutter/list1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
            child: Text(
              "2019秋季大促2019秋季大促2019秋季大促2019秋季大促2019秋季大促2019秋季大促",
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
                  child: clearlove_text("￥123.0", color: Colors.red, size: 16),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: clearlove_text("￥189.0",
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
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
              _recProductItemListWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
