/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 14:18:55
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-24 14:30:38
 */

import 'package:clearlove_flutter_learn/services/screen_adaper.dart';
import 'package:clearlove_flutter_learn/services/search_service.dart';
import 'package:clearlove_flutter_learn/utils/clearlove_util.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;
  List _historyListData = [];
  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  _getHistoryData() async {
    var _historyListData = await SearchService.getHistoryList();
    print("-------- $_historyListData");
    setState(() {
      this._historyListData = _historyListData;
      print("-------- $_historyListData");
    });
  }

  Widget _historyListWidget() {
    if (_historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "历史记录",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((e) {
              return Column(
                children: [
                  ListTile(
                    title: Text("$e"),
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  SearchService.removeHistoryList();
                  this._getHistoryData();
                },
                child: Container(
                  width: ScreenAdaper.width(400),
                  height: ScreenAdaper.height(64),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      Text("清空历史记录"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Text("");
    }
  }

  List<Widget> boxs() => List.generate(10, (index) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: clearlove_text("女装$index"),
        );
      });

  List<Widget> listTileArr() => List.generate(4, (index) {
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.alarm),
              title: clearlove_text("记录$index"),
            ),
            Divider(),
          ],
        );
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              this._keywords = value;
            },
          ),
          height: ScreenAdaper.height(68),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              height: ScreenAdaper.height(48),
              width: ScreenAdaper.width(80),
              child: Row(
                children: [
                  clearlove_text("搜索"),
                ],
              ),
            ),
            onTap: () {
              SearchService.setHistoryData(this._keywords);
              Navigator.pushReplacementNamed(context, "/productList",
                  arguments: {"keywords": this._keywords});
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: Text(
                "热搜",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Divider(),
            Wrap(
              children: boxs(),
            ),
            SizedBox(
              height: 10,
            ),
            // 历史记录
            _historyListWidget(),
          ],
        ),
      ),
    );
  }
}
