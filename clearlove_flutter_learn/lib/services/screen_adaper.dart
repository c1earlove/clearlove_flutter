/*
 * @Description: 封装适配库以及实现左右滑动listView
 * @Autor: clearlove
 * @Date: 2020-11-24 15:41:58
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-24 16:01:21
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdaper {
  static init(context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }
}
