/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 11:40:03
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-30 16:12:20
 */

import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/utils/clearlove_util.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'cart.dart';
import 'user.dart';
import 'category.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      child: Scaffold(
        appBar: _currentIndex != 3
            ? AppBar(
                title: InkWell(
                  child: Container(
                    height: ScreenAdaper.height(56),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        clearlove_text("笔记本", size: ScreenAdaper.fontSize(28)),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.center_focus_weak,
                    size: 28,
                    color: Colors.black87,
                  ),
                  onPressed: null,
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.message,
                        size: 28,
                        color: Colors.black87,
                      ),
                      onPressed: null)
                ],
              )
            : AppBar(
                title: Text("用户中心"),
              ),
        // 保持页面状态的第一种方法
        // body: IndexedStack(
        //   index: _currentIndex,
        //   children: _pageList,
        // ),
        body: PageView(
          controller: _pageController,
          children: _pageList,
          onPageChanged: (value) {
            setState(() {
              this._currentIndex = value;
            });
          },
        ),
        // 不保持页面状态
        // body: _pageList[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int value) {
            setState(() {
              _currentIndex = value;
              _pageController.jumpToPage(_currentIndex);
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "分类",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "购物车",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "我的",
            ),
          ],
        ),
      ),
    );
  }
}
