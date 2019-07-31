import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_weather/api/api.dart';
import 'package:flutter_weather/model/news_bean.dart';
import 'package:flutter_weather/model/news_item.dart';
import 'package:flutter_weather/routers/application.dart';
import 'package:flutter_weather/routers/routers.dart';
import 'package:flutter_weather/widget/progress_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }
}

class _PageState extends State<SearchPage> {
  TextEditingController _controller = new TextEditingController();
  List<NewsItem> list = [];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  //搜索数据
  serchData(String data) async {
    if (data.isEmpty) return;
    setState(() {
      list.clear();
      loading = true;
    });
    final response = await http
        .get(Api.NEWS_SEARCH_JS + "?keyword=$data&appkey=${Api.APPKEY_JS}");
    print("搜索结果：" + response.body);

    setState(() {
      loading = false;
      NewsBean newsBean = NewsBean.fromJson(json.decode(response.body));
      list.addAll(newsBean.result.list);
    });
  }

  //body
  Widget buildBody(){
    if(loading){
      return ProgressView();
    }else{
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return getItem(index);
          });
    }
  }

  //AppBar
  Widget buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black54,
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff3f4f6),
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '搜你想要的',
                      hintStyle: TextStyle(
                        color: Color(0xffaeaeb0),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    //键盘搜索事件
                    onEditingComplete: () {
                      serchData(_controller.text);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  serchData(_controller.text);
                },
                child: Text(
                  "搜索",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              )
            ],
          ),
        ));
  }

  //listview的item
  Widget getItem(int index) {
    NewsItem item = list[index];
    return GestureDetector(
      onTap: () {
        Application.router.navigateTo(context,
            '${Routes.webViewPage}?title=${Uri.encodeComponent(item.title)}&url=${Uri.encodeComponent(item.url)}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff333333),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: 1,
            child: Container(
              color: Color(0xffE8E8E8),
            ),
          )
        ],
      ),
    );
  }
}
