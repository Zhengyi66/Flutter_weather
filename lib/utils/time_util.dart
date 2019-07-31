class TimeUtil{

  static String getNewsTime(String time){
    DateTime now = DateTime.now();
    DateTime news = DateTime.parse(time);

    int df = now.millisecondsSinceEpoch - news.millisecondsSinceEpoch;
    int ms = 3600 * 1000;
    if(df > ( ms * 24)){
      return time;
    }else{
      if(df~/ms == 0){
        int m = 60 * 1000;
        if(df~/m == 0){
          return "刚刚";
        }else{
          return (df~/m).toString()+"分钟前";
        }
      }else{
        return (df~/ms).toString()+"小时前";
      }
    }
  }

  //获得天气的日期  07/20
  static String getWeatherDate(String date){
    //2019-07-26
    date = date.replaceAll("-", "/");
    return date.substring(date.indexOf("/")+1);
  }
  
}