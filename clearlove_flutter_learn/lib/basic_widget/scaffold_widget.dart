import 'package:flutter/material.dart';
import '../utils/clearlove_util.dart';

class MyScaffoldWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        endDrawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          // 不添加这一行，title会偏左
          centerTitle: true,
          title:
              clearlove_text("Scaffold Widget", color: Colors.yellow, size: 24),
          leading: IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              print("点击了左按钮");
              Scaffold.of(context).openDrawer();
            },
          ),
          // actions: [
          //   IconButton(
          //       icon: Icon(
          //         Icons.access_time,
          //         color: Colors.white,
          //       ),
          //       onPressed: null),
          //   IconButton(
          //       icon: Icon(
          //         Icons.calendar_today,
          //         color: Colors.white,
          //       ),
          //       onPressed: null),
          // ],
        ),
        body: Container(
          // double 类型  在Dart 2.1之后 Int可以根据实际情况转为double
          width: 200,
          height: 200,
          color: Colors.yellow,
          child: Center(
            child: Text(
              "这是一个中间的文本",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.red,
            child: Row(
              children: [
                Expanded(
                  child: IconButton(icon: Icon(Icons.phone), onPressed: null),
                ),
                Expanded(
                  child: IconButton(icon: Icon(Icons.phone), onPressed: null),
                ),
                Expanded(
                  child: IconButton(icon: Icon(Icons.phone), onPressed: null),
                ),
                Expanded(
                  child: IconButton(icon: Icon(Icons.phone), onPressed: null),
                ),
              ],
            )),
      ),
    );
  }
}
