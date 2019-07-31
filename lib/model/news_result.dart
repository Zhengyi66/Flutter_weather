import 'package:flutter_weather/model/news_item.dart';

class NewResult {
  final String channel;
  final int num;
  final List<NewsItem> list;

  NewResult({this.channel, this.num, this.list});

  factory NewResult.fromJson(Map<String, dynamic> json) {
    var tempList = json['list'] as List;
    List<NewsItem> items = tempList.map((i) => NewsItem.fromJson(i)).toList();

    return new NewResult(
        channel: json['channel'],
        num: json['num'],
        list: items);
  }

}
