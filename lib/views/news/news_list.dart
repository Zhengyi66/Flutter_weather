import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather/routers/application.dart';
import 'package:flutter_weather/routers/routers.dart';

import 'package:flutter_weather/api/api.dart';
import 'package:flutter_weather/model/news_bean.dart';
import 'package:flutter_weather/model/news_item.dart';
import 'package:flutter_weather/model/news_result.dart';
import 'package:flutter_weather/utils/time_util.dart';
import 'package:flutter_weather/widget/progress_widget.dart';

//新闻listview
class NewListPage extends StatefulWidget {
  NewListPage({Key key, this.type}) : super(key: key);
  //类型
  final String type;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState(type);
  }
}

class _PageState extends State<NewListPage> {
  _PageState(this.type);
  ScrollController _scrollController = new ScrollController();

  String type;

  List<NewsItem> list = [null];
  int start = 0;//开始位置

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((){
      //滑到最底部
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //加载更多
        print("滑动到底部");
        start = list.length - 1;
        loadData();
      }else{

      }
    });
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new RefreshIndicator(
        child: buildListView(),
        onRefresh: _handlerRefresh,
    );
  }

  //listview
  Widget buildListView(){
    return new ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, position) {
          if(list[position] == null){
            //显示加载更多
            return Container(
              alignment: Alignment.center,
              height: 40,child:SizedBox(height : 30,width :30 ,
              child: CircularProgressIndicator(strokeWidth: 2,),));
          }else{
            return getRow(position);
          }
        },
        controller: _scrollController,
        );
  }

  //listview的item
  Widget getRow(int index) {
    NewsItem item = list[index];
    return GestureDetector(
        child: Container(
        margin: EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //文字
                new Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 5,),
                        Text(item.src + "  " + TimeUtil.getNewsTime(item.time),
                          style: TextStyle(color: Colors.grey,fontSize: 12),),
                      ],
                    )),
                //图片
                Image.network(
                  item.pic,
                  height: 65,
                  width: 95,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            //分割线
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: SizedBox(height: 1, child: Container(color: Color(0xffE8E8E8),)),
            )
          ],
        ),
      ),
      onTap: (){
        Application.router.navigateTo(context,
            '${Routes.webViewPage}?title=${Uri.encodeComponent(item.title)}&url=${Uri.encodeComponent(item.url)}');
      },
    );
  }

  //加载数据
  loadData() async {
    final response = await http.post(Api.NEWS_LIST_JS+"?channel=$type&appkey=${Api.APPKEY_JS}&start=$start}",);
    //刷新
    setState(() {
      print("response list:" + response.body);
      NewsBean newsBean = NewsBean.fromJson(json.decode(response.body));
      if(newsBean.status == "0"){
        //表示刷新
        if(start == 0 && list.length > 0){
          list.clear();
          list.add(null);
        }
        NewResult result = newsBean.result;
        list.insertAll(list.length-1,result.list);
      }
    });
  }

  //刷新
  Future<Null> _handlerRefresh() async{
    start = 0;
    loadData();
    return null;
  }


}
