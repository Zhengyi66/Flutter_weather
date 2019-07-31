
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_bean.dart';
import 'package:flutter_weather/utils/weather_util.dart';
import 'package:flutter_weather/utils/time_util.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class WeatherLineWidget extends StatelessWidget {
  WeatherLineWidget(this.dailys,this.dayIcons,this.nightIcons);

  final List<WeatherDaily> dailys;
  final List<ui.Image> dayIcons;
  final List<ui.Image> nightIcons;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: _customPainter(dailys,dayIcons,nightIcons),
      size: Size(420, 310),
    );
  }
}

class _customPainter extends CustomPainter {
  _customPainter(this.dailys,this.dayImages,this.nightIcons);

  List<WeatherDaily> dailys;
  List<ui.Image> dayImages;
  List<ui.Image> nightIcons;
  final double itemWidth = 60; //每个item的宽度
//  final double itemHeight = 200; //每个item的高度
  final double textHeight = 120; //显示文字的高度
  final double temHeight = 80; //温度区域的高度
  int maxTem, minTem; //最高/低温度

  @override
  void paint(Canvas canvas, Size size) async{
    setMinMax();

    print("======= night:" + nightIcons.length.toString() + "  day:" + dayImages.length.toString());

    var maxPaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xffeceea6)
      ..isAntiAlias = true
      ..strokeWidth = 2;

    var minPaint = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Color(0xffa3f4fe)
      ..isAntiAlias = true
      ..strokeWidth = 2;

    var pointPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 8;

    var linePaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    var maxPath = new Path();
    var minPath = new Path();

    List<Offset> maxPoints = [];
    List<Offset> minPoints = [];
    double oneTemHeight = temHeight / (maxTem - minTem); //每个温度的高度
    for(int i=0; i<dailys.length; i++){
      var daily = dailys[i];
      var dx = itemWidth/2 + itemWidth * i;
      var maxDy = textHeight + (maxTem - int.parse(daily.day.temphigh)) * oneTemHeight;
      var minDy = textHeight + (maxTem - int.parse(daily.night.templow)) * oneTemHeight;
      var maxOffset = new Offset(dx, maxDy);
      var minOffset = new Offset(dx, minDy);

      if(i == 0){
        maxPath.moveTo(dx, maxDy);
        minPath.moveTo(dx, minDy);
      }else {
        maxPath.lineTo(dx, maxDy);
        minPath.lineTo(dx, minDy);
      }
      maxPoints.add(maxOffset);
      minPoints.add(minOffset);

      if(i != 0){
        //竖线
        canvas.drawLine(Offset(itemWidth * i ,0), Offset(itemWidth * i,  textHeight*2 + textHeight), linePaint);

      }

      var date;
      if(i == 0){
        date = daily.week + "\n" +  "今天";
      }else if(i == 1){
        date =  daily.week + "\n" + "明天";
      }else{
        date = daily.week + "\n" + TimeUtil.getWeatherDate(daily.date);
      }
      //绘制日期
      drawText(canvas, i, date ,10);
      //绘制白天天气图片 src原始矩阵 dst输出矩阵
      canvas.drawImageRect(dayImages[i],Rect.fromLTWH(0, 0, dayImages[i].width.toDouble(),  dayImages[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, 50,30,30),linePaint);
      //绘制白天天气
      drawText(canvas, i, daily.day.weather, 90);
      //绘制夜间天气图片
      canvas.drawImageRect(nightIcons[i],Rect.fromLTWH(0, 0, nightIcons[i].width.toDouble(),  nightIcons[i].height.toDouble()),
          Rect.fromLTWH(itemWidth/4 + itemWidth*i, textHeight + temHeight + 10,30,30),new Paint());
      //绘制夜间天气信息
      drawText(canvas, i, daily.night.weather, textHeight+temHeight + 45);
      //绘制风向和风力
      drawText(canvas, i, daily.night.winddirect + "\n" + daily.night.windpower, textHeight+temHeight + 70,frontSize: 10);
    }
    //最高温度折线
    canvas.drawPath(maxPath, maxPaint);
    //最低温度折线
    canvas.drawPath(minPath, minPaint);
    //最高温度点
    canvas.drawPoints(ui.PointMode.points, maxPoints, pointPaint);
    //最低温度点
    canvas.drawPoints(ui.PointMode.points, minPoints, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  //设置最高温度，最低温度
  setMinMax(){
    minTem = maxTem = int.parse(dailys[0].day.temphigh);
    for(WeatherDaily daily in dailys){
      if(int.parse(daily.day.temphigh) > maxTem){
        maxTem = int.parse(daily.day.temphigh);
      }
      if(int.parse(daily.night.templow) < minTem){
        minTem = int.parse(daily.night.templow);
      }
    }
  }

  //绘制文字
  drawText(Canvas canvas, int i,String text,double height,{double frontSize}) {
    var pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,//居中
      fontSize: frontSize == null ?14:frontSize,//大小
    ));
    //添加文字
    pb.addText(text);
    //文字颜色
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    //文本宽度
    var paragraph = pb.build()..layout(ui.ParagraphConstraints(width: itemWidth));
    //绘制文字
    canvas.drawParagraph(paragraph, Offset(itemWidth*i, height));
  }


}


