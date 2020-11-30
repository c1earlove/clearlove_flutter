/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 11:39:43
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-26 16:26:10
 */

import 'package:clearlove_flutter_learn/config/config.dart';
import 'package:clearlove_flutter_learn/model/category_model.dart';
import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/utils/clearlove_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  // 获取左侧数据
  _getLeftCateData() async {
    var api = "${Config.domain}api/pcate";
    var result = await Dio().get(api);
    print("===== result = $result");
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  // 获取右侧数据
  _getRightCateData(String pid) async {
    var api = "${Config.domain}api/pcate?pid=$pid";
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    print("6666");
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

  // 左侧组件
  Widget _leftCateWidget(double leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                //
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      _getRightCateData(_leftCateList[index].sId);
                    });
                    print(_selectIndex);
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdaper.height(80),
                    alignment: Alignment.center,
                    // padding: EdgeInsets.only(top: ScreenAdaper.height(24)),
                    child: Text(
                      "${_leftCateList[index].title}",
                      textAlign: TextAlign.center,
                    ),
                    color: _selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  // 右侧组件
  Widget _rightCateWidget(double rightItemWidth, double rightItemHeight) {
    if (_rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth / rightItemHeight,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _rightCateList.length,
            itemBuilder: (context, index) {
              String pic = _rightCateList[index].pic;
              pic = Config.domain + pic.replaceAll("\\", "/");
              return InkWell(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: ScreenAdaper.height(32),
                        child: clearlove_text("${_rightCateList[index].title}"),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/productList",
                      arguments: {"cid": _rightCateList[index].sId});
                },
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: clearlove_text("加载中..."),
        ),
        flex: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    // 计算右侧GridView宽高比
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    var rightItemWidth =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(32);
    return Row(
      children: [
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight),
      ],
    );
  }
}
