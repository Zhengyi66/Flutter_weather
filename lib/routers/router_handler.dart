import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/views/news/search_page.dart';
import 'package:flutter_weather/views/webview/web_view_page.dart';
import 'package:flutter_weather/views/home/city_manager.dart';
import 'package:flutter_weather/views/my/my.dart';
import 'package:flutter_weather/views/home/home.dart';

//app主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return AppHome();
});

var webViewPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  String url = params['url']?.first;
  print("handler:  title = " + title + "  url:" + url);
  return new WebViewPage(url, title);
});

var searchPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return new SearchPage();
});

var cityHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return new CityPage();
  }
);

var myHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters){
    return new MyPage();
  }
);

