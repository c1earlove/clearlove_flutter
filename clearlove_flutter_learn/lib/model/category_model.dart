/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-26 10:08:54
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-26 11:14:57
 */

class CateItemModel {
  String sId;
  String title;
  String status;
  String pic;
  String pid;
  String sort;
  CateItemModel(
      {this.sId, this.title, this.status, this.pic, this.pid, this.sort});
  CateItemModel.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    title = json["title"];
    status = json["status"].toString();
    pic = json["pic"];
    pid = json["pid"];
    sort = json["sort"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["_id"] = this.sId;
    data["title"] = this.title;
    data["status"] = this.status;
    data["pic"] = this.pic;
    data["sort"] = this.sort;
    data["pid"] = this.pid;
    return data;
  }
}

class CateModel {
  List<CateItemModel> result;
  CateModel({this.result});

  CateModel.fromJson(Map<String, dynamic> json) {
    if (json["result"] != null) {
      result = List<CateItemModel>();
      List jsonResult = json["result"];
      jsonResult.forEach((element) {
        result.add(CateItemModel.fromJson(element));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    if (this.result != null) {
      data["result"] = this.result.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
