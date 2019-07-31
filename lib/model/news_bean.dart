import 'package:flutter_weather/model/news_result.dart';

class NewsBean{
  final String status;
  final String msg;
  final NewResult result;

  NewsBean({this.status, this.msg, this.result});

  factory NewsBean.fromJson(Map<String,dynamic> json){
    return new NewsBean(
      status: json['status'].toString(),
      msg: json['msg'],
      result:json['status'].toString() =="0"?NewResult.fromJson(json['result']):null
    );
  }

}