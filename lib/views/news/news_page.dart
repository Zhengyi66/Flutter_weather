import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather/views/news/news_list.dart';
import 'package:flutter_weather/routers/application.dart';
import 'package:flutter_weather/routers/routers.dart';
import 'package:flutter_weather/widget/progress_widget.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageHome();
  }
}

class _PageHome extends State<NewsPage> {
  List tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
//    return null;
    // TODO: implement build
    return _buildTabController();
  }

  Widget _buildTabController(){
    if(tabs.length == 0){
      return ProgressView();
    }else {
      return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: buildSearch(context),
              bottom: TabBar(
                isScrollable: true,
                tabs: tabs.map<Widget>((dynamic title) {
                  return Tab(
                    text: title.toString(),
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
                children: tabs.map<Widget>((dynamic title) {
                  return Container(
                      child: new NewListPage(type: title.toString(),));
                }).toList()),
          ));
    }
  }

  //搜索框
  Widget buildSearch(BuildContext context) {
    return  GestureDetector(
      onTap: (){
          Application.router.navigateTo(context, Routes.searchPage);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(8),
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: Text("搜你想要的",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black54))),
            Text(
              "热搜",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  //加载tabbar数据
  loadData() async {
//    final response =
//        await http.post(Api.NEWS_TITLE_JS, body: {'appkey': Api.APPKEY_JS});
  String data = '{"status":0,"msg":"ok","result":["头条","新闻","国内","国际","政治","财经","体育","娱乐","军事","教育","科技","NBA","股票","星座","女性","健康","育儿"]}';
//    print("======response:" + response.body);
    Map map = json.decode(data);
    var list = map['result'];
    setState(() {
      tabs.addAll(list);
    });
  }
}

