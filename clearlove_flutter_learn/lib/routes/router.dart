/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 14:16:16
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-26 16:31:28
 */

import 'package:clearlove_flutter_learn/pages/product_content/product_content.dart';
import 'package:clearlove_flutter_learn/pages/product_list.dart';
import 'package:clearlove_flutter_learn/pages/search.dart';
import 'package:clearlove_flutter_learn/pages/tabs/tabs.dart';
import 'package:flutter/material.dart';

// 配置路由的地方
final routes = {
  '/': (context) => Tabs(),
  // '/search': (context) => SearchPage(),
  '/productList': (context, {arguments}) => ProductListPage(
        arguments: arguments,
      ),
  '/productContent': (context, {arguments}) => ProductContentPage(
        arguments: arguments,
      ),
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
};
