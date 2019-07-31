import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_weather/api/api.dart';
import 'package:flutter_weather/views/home/first_page_view.dart';
import 'package:flutter_weather/views/home/second_page_view.dart';
import 'package:flutter_weather/model/weather_bean.dart';
import 'package:flutter_weather/model/page_event.dart';
import 'package:flutter_weather/routers/application.dart';
import 'package:flutter_weather/routers/routers.dart';
import 'package:flutter_weather/widget/progress_widget.dart';
import 'package:flutter_weather/utils/SpUtil.dart';


class HomePageView extends StatefulWidget{

  HomePageView();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }

}

class _PageState extends State<HomePageView>{

  String city = "";
  String weatherJson = "";
  WeatherResult weatherResult;
  int loadState = 2;//0加载失败，1加载成功 2正在加载

  PageController _pageController = new PageController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    loadWeatherAssets();

    loadWeatherData();
   _pageController.addListener((){
      if( _pageController.position.pixels == _pageController.position.extentInside){
        eventBus.fire(PageEvent());
      }
   });
  }

  @override
  Widget build(BuildContext context) {

    if(weatherJson.isNotEmpty){
      WeatherBean weatherBean = WeatherBean.fromJson(json.decode(weatherJson));
      if(weatherBean.succeed()){
        loadState = 1;
        weatherResult = weatherBean.result;
      }else{
        loadState = 0;
      }
    }

    return Material(
      child: Column(
        children: <Widget>[
          //头
          buildBar(context),
          //pageview
          Expanded(child: _buildPageView(),
          )
        ],
      ),
    );
  }

  //从assets中加载天气信息
  loadWeatherAssets() async {
    Future<String> future = DefaultAssetBundle.of(context).loadString("assets/json/weather.json");
    future.then((value){
      setState(() {
        weatherJson = value;
      });
    });
  }

  loadWeatherData() async {
    if(city.isEmpty){
      await SpUtil.instance.then((sp){
        city = sp.get("city");
      });
    }
    if(city == null) city = "杭州";

    final response = await http.get(Api.WEATHER_QUERY + city);
    setState(() {
      weatherJson = response.body;
    });
  }

  Widget _buildPageView(){
    if(loadState == 2){
      return new ProgressView();
    }else if(loadState == 1){
      return new PageView(
        scrollDirection: Axis.vertical,
        //            pageSnapping: false,
        controller: _pageController,
        children: <Widget>[
          FirstPageView(weatherResult),
          SecondPageView(weatherResult)
        ],
      );
    }else{
      return Center(
        child: Column(
          children: <Widget>[
            Image(image: AssetImage("assets/images/load_failed.png"),height: 60,),
            SizedBox(height: 10,),
            Text("加载失败",style: TextStyle(fontSize: 16,color: Color(0xff8a8a8a)),)
          ],
        ),
      );
    }
  }


  Widget buildBar(BuildContext context){
    return  Container(
        padding: EdgeInsets.only(left:10, top: MediaQuery.of(context).padding.top),
        height: MediaQuery.of(context).padding.top + 40,
        color: Color(0xff022780),
        child:  GestureDetector(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.add,color: Colors.white,size: 25,),
              SizedBox(width: 10,),
              Text(city,style: TextStyle(fontSize: 16,color: Colors.white),),
              SizedBox(width: 10,),
              Icon(Icons.location_on,color: Colors.white,size: 20,)
            ],
          ),
          onTap: (){
            Future future = Application.router.navigateTo(context, Routes.cityPage);
            //接收回调信息
            future.then((value){
              if(value != null){
                setState(() {
                  loadState = 2;
                });
                city = value.toString();
                loadWeatherData();
                SpUtil.instance.then((sp){
                  sp.putString("city", value.toString());
                });
              }
            });
          },
        )
    );
  }
}

