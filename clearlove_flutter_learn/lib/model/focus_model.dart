/*
 * @Description: 
 * @Autor: clearlove
 * @Date: 2020-11-24 17:18:18
 * @LastEditors: clearlove
 * @LastEditTime: 2020-11-24 17:36:25
 */
class FocusModel {
  List<FocusItemModel> result;
  FocusModel({this.result});
  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json["result"] != null) {
      result = List<FocusItemModel>();
      List jsonResult = json["result"];
      jsonResult.forEach((element) {
        result.add(FocusItemModel.fromJson(element));
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

class FocusItemModel {
  String sId;
  String title;
  String status;
  String pic;
  String url;
  FocusItemModel(this.sId, this.title, this.pic, this.url);
  FocusItemModel.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    title = json["title"];
    status = json["status"];
    pic = json["pic"];
    url = json["url"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["_id"] = this.sId;
    data["title"] = this.title;
    data["status"] = this.status;
    data["pic"] = this.pic;
    data["url"] = this.url;
    return data;
  }
}
