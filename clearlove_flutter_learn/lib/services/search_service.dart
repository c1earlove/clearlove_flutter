import 'dart:convert';

import 'package:clearlove_flutter_learn/services/storage.dart';
import 'package:clearlove_flutter_learn/utils/storage_key.dart';

class SearchService {
  static setHistoryData(String keywords) async {
    /**
     * 1.获取本地存储里面的数据。(searchList)
     * 2.判断本地存储是否有数据
     * 2.1如果有数据：
     *  1.读取本地存储的数据。
     * 2.判断本地存储中有没有当前数据；
     * 3.如果有不做操作
     * 如果没有当前数据，本地存储的数据和当前数据拼接后重新写入。
     * 2.2如果没有数据：
     * 直接把当前数据放在数组中写入到本地存储。
     * 
     * 
     *  */
    try {
      List searchListData = json.decode(await Storage.getString(kSearchList));
      var hasData = searchListData.any((element) {
        return element == keywords;
      });
      if (!hasData) {
        searchListData.add(keywords);
        await Storage.setString(kSearchList, json.encode(searchListData));
      }
    } catch (e) {
      List tempList = List();
      tempList.add(keywords);
      await Storage.setString(kSearchList, json.encode(tempList));
    }
  }

  static getHistoryList() async {
    try {
      List searchListData = json.decode(await Storage.getString(kSearchList));
      return searchListData;
    } catch (e) {
      return [];
    }
  }

  static removeHistoryList() async {
    await Storage.remove(kSearchList);
  }
}
