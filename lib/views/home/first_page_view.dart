import 'package:flutter/material.dart';

import 'package:flutter_weather/model/weather_bean.dart';

class FirstPageView extends StatefulWidget{

  final WeatherResult weatherResult;

  FirstPageView(this.weatherResult);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }
}

class _PageState extends State<FirstPageView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,//充满
      children: <Widget>[
        Image(image: AssetImage("assets/images/first.png"),fit: BoxFit.cover,),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            buildTopTem(widget.weatherResult),
            Expanded(child: Container()),
            buildBottomTem(widget.weatherResult)
          ],
        )
      ],
    );
  }

}

//上面天气信息
Widget buildTopTem(WeatherResult result){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      //左边天气信息
      Column(
        children: <Widget>[
          //左边温度信息
          Container(width: 200,height: 90,
            child:  Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  child:  Text(result.temp,style: TextStyle(color:Colors.white,fontSize: 90,fontWeight: FontWeight.w200),),
                  left: 10,
                ),
                Positioned(
                  child: Text("℃",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),),
                  left: 110,
                  top: 5,
                ),
                Positioned(child: Text(result.weather,style: TextStyle(color: Colors.white,fontSize: 18),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  bottom: 5,
                  left: 110,
                )
              ],
            ),
          ),

          //风力,湿度
          Container(
            decoration: BoxDecoration(color: Color(0x4fffffff),
                borderRadius: BorderRadius.circular(2)
            ),
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.only(top: 20),
            child: Text("${result.winddirect} ${result.windpower}    湿度 ${result.humidity}%",
              style: TextStyle(fontSize: 16,color: Colors.white),),
          ),
        ],
      ),

      //填充剩余空间
      Expanded(child: Container()),

      //右边空气质量
      Container(
        width: 70,
        height: 30,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(color: Color(0x4fffffff),
            borderRadius: BorderRadius.circular(2)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Container(
            width: 2,
            height: 15,
            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(1)),
          ),
          Text(" ${result.aqi.quality} ${result.aqi.aqi}",style: TextStyle(color: Colors.white,fontSize: 16),)
        ],),
      ),

    ],
  );
}

//底部天气
Widget buildBottomTem(WeatherResult weatherResult){
  return Row(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      bottomItem("今天",weatherResult.dailys[0]),
      bottomItem("明天",weatherResult.dailys[1])
    ],
  );
}

Widget bottomItem(String day,WeatherDaily daily){
  final textStyle = TextStyle(color: Colors.white,fontSize: 14);
  return Expanded(
      child: Container(
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          alignment:Alignment.center,
          children: <Widget>[

            Positioned(child: Text(day,style: textStyle,),left: 10,top: 12,),

            Positioned(left: 10, child: Text("${daily.day.temphigh}/${daily.night.templow}℃",style: textStyle,),),

            Positioned(child: Text(daily.day.weather,style: textStyle,),left: 10,bottom: 15,),

            Positioned(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("良",style: textStyle,),
                  SizedBox(width: 10,),
                  Container(
                    width: 2,
                    height: 15,
                    decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(1)),
                  ),
                ],
              ),
              right: 10,top: 12,
            ),

            Positioned(
              child: Image(
                image: AssetImage("assets/images/0.png"),
                 width: 30,
                 fit: BoxFit.cover,
              ),
              right: 10,
              bottom: 12,
            )

          ],
        ),
      )
  );
}