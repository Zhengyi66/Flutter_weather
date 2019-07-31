class WeatherBean{

  final int status;
  final String msg;
  final WeatherResult result;

  WeatherBean({this.status,this.msg,this.result});

  bool succeed(){
    return status == 0;
  }

  factory WeatherBean.fromJson(Map<String,dynamic> json){
    return WeatherBean(
      status: json['status'],
      msg: json['msg'],
      result: json['status'] == 0 ? WeatherResult.fromJson(json['result']):null
    );
  }
}

class WeatherResult{
  final String city;      //城市
  final String citycode;  //城市code (int)
  final String date;      //日期
  final String week;      //星期
  final String weather;   //天气
  final String temp;      //当前气温
  final String temphigh;  //最高温度
  final String templow;   //最低温度
  final String img;       //图片
  final String humidity;  //湿度
  final String pressure;  //气压
  final String windspeed; //风速
  final String winddirect;//风向
  final String windpower; //风级
  final String updatetime;//更新时间
  final Aqi  aqi;
  final List<WeatherIndex> indexs; //生活指数
  final List<WeatherDaily> dailys; //一周天气
  final List<WeatherHourly> hours; //24小时天气

  WeatherResult({this.city,this.citycode,this.date,this.weather,this.temp,this.temphigh,this.templow,this.img,this.humidity,
    this.pressure,this.windspeed,this.winddirect,this.windpower,this.updatetime,this.week,this.aqi,this.indexs,this.dailys,this.hours});


  factory WeatherResult.fromJson(Map<String,dynamic> json){
    var temIndexs = json['index'] as List;
    List<WeatherIndex> indexList = temIndexs.map((i)=>WeatherIndex.fromJson(i)).toList();

    var temDailys = json['daily'] as List;
    List<WeatherDaily> dailyList = temDailys.map((i)=>WeatherDaily.fromJson(i)).toList();

    var temHours = json['hourly'] as List;
    List<WeatherHourly> hoursList = temHours.map((i)=>WeatherHourly.fromJson(i)).toList();

    return WeatherResult(
      city: json['city'],
      citycode: json['citycode'].toString(),
      date: json['date'],
      week: json['week'],
      weather: json['weather'],
      temp: json['temp'],
      temphigh: json['temphigh'],
      templow: json['templow'],
      img: json['img'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      windspeed: json['windspeed'],
      winddirect: json['winddirect'],
      windpower: json['windpower'],
      updatetime: json['updatetime'],
      aqi: Aqi.fromJson(json['aqi']),
      indexs: indexList,
      dailys: dailyList,
      hours: hoursList
    );
  }

}

//生活指数
class WeatherIndex{
  final String iname;   //指数名
  final String ivalue;  //指数值
  final String detail;  //指数描述

  WeatherIndex({this.iname,this.ivalue,this.detail});

  factory WeatherIndex.fromJson(Map<String,dynamic> json){
    return new WeatherIndex(
      iname: json['iname'],
      ivalue: json['ivalue'],
      detail: json['detail']
    );
  }
}

//每天天气
class WeatherDaily{
  final String date;  //日期
  final String week;  //星期
  final String sunrise; //日出
  final String sunset;  //日落
  final DayNight night; //夜间天气
  final DayNight day;   //白天天气

  WeatherDaily({this.date,this.week,this.sunrise,this.sunset,this.night,this.day});

  factory WeatherDaily.fromJson(Map<String,dynamic> json){
    return WeatherDaily(
      date: json['date'],
      week: json['week'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      night: json['night'] != null ? DayNight.fromJson(json['night']): null,
      day: json['day'] != null ? DayNight.fromJson(json['day']) : null,
    );
  }

}

//白天夜间天气
class DayNight{
  final String weather; //天气
  final String temphigh;//白天最高温度
  final String templow; //夜间最低温度
  final String img;
  final String winddirect;//风速
  final String windpower; //风力

  DayNight({this.weather,this.temphigh,this.templow,this.img,this.winddirect,this.windpower});

  factory DayNight.fromJson(Map<String,dynamic> json){
    return DayNight(
      weather: json['weather'],
      temphigh: json['temphigh'],
      templow: json['templow'],
      img: json['img'],
      winddirect: json['winddirect'],
      windpower: json['windpower']
    );
  }
}

//小时的天气
class WeatherHourly{
  final String time; //时间
  final String weather;//天气
  final String temp;  //温度
  final String img;

  WeatherHourly({this.time,this.weather,this.temp,this.img});

  factory WeatherHourly.fromJson(Map<String,dynamic> json){
    return new WeatherHourly(
      time: json['time'],
      weather: json['weather'],
      temp: json['temp'],
      img: json['img']
    );
  }
}

//AQI 指数
class Aqi{
  final String aqi;
  final String quality;
  final AqiInfo aqiinfo;

  Aqi({this.aqi,this.quality,this.aqiinfo});

  factory Aqi.fromJson(Map<String,dynamic> json){
    return Aqi(
      aqi: json['aqi'],
      quality: json['quality'],
      aqiinfo: AqiInfo.fromJson(json['aqiinfo'])
    );
  }

}

//AQI描述
class AqiInfo{
  final String level;
  final String color;
  final String affect;
  final String measure;

  AqiInfo({this.level,this.color,this.affect,this.measure});

  factory AqiInfo.fromJson(Map<String,dynamic> json){
    return AqiInfo(
      level: json['level'],
      color: json['color'],
      affect: json['affect'],
      measure: json['measure']
    );
  }

}