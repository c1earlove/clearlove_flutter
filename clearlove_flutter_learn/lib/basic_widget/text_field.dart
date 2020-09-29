import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFieldPage extends StatefulWidget {
  @override
  _MyTextFieldPageState createState() => _MyTextFieldPageState();
}

class _MyTextFieldPageState extends State<MyTextFieldPage> {
  TextEditingController _tfController;
  FocusNode _focusNode;
  String _errorText;
  // 是否显示明文
  bool isShow = false;
  @override
  void initState() {
    super.initState();
    _tfController = TextEditingController(text: "");
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      print("has Focus:${_focusNode.hasFocus}");
    });
  }

  void initTextField() {}

  // 给予焦点
  void _getFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
    print(_tfController.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TextFiled"),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: _tfController,
                  focusNode: _focusNode,
                  // 自动获取正确单词
                  autocorrect: false,
                  // 光标颜色
                  cursorColor: Colors.orange,
                  // 是否自动获取焦点
                  autofocus: true,
                  // 是否显示明文
                  obscureText: isShow,
                  keyboardType: TextInputType.number,
                  // 大小写
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    icon: Icon(Icons.title),
                    // labelText: "用户名",
                    helperText: "底部描述内容",
                    errorText: _errorText,
                    hintText: "请输入用户名",
                    // 填充颜色，只有filled 为true的时候 这个颜色才有效
                    fillColor: Colors.red,
                    filled: true,
                    // 前缀 始终显示，获取焦点后变换颜色
                    prefixIcon: Icon(Icons.bookmark),
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.remove_red_eye),
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                          print(isShow);
                        });
                      },
                    ),
                    // 错误时边框
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    // 不可编辑时边框
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    // 获取到焦点时的颜色
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  inputFormatters: [
                    // LengthLimitingTextInputFormatter(10),
                    // // FilteringTextInputFormatter.deny
                    // // 黑名单，正则
                    // FilteringTextInputFormatter.deny(RegExp('[A-G]'))
                  ],
                  onChanged: (String content) {
                    if (content.contains(RegExp('a'))) {
                      setState(() {
                        _errorText = "不能包含a";
                      });
                    } else {
                      if (_errorText.isNotEmpty) {
                        setState(() {
                          _errorText = null;
                        });
                      }
                    }
                    print("nei荣Wie：$content");
                  },
                  onSubmitted: (value) => print(value),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
