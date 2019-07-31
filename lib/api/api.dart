///http://v.juhe.cn/toutiao/index?type=top&key=APPKEY
///应用APPKEY
///类型,top(头条，默认),shehui(社会),guonei(国内),guoji(国际),
///yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
class Api{

  //数据智慧
//  static const String NEWS_URL = "http://v.juhe.cn/toutiao/index";
//  static const String NEWS_TITLE = "http://api.shujuzhihui.cn/api/news/categories";
//  static const String APPKEY = "53aaabb7f1a04b2bb741466c8e82305b";

  //急速数据
  //获取新闻分类
  static const String NEWS_TITLE_JS = "https://api.jisuapi.com/news/channel";
  //获取新闻列表
  static const String NEWS_LIST_JS = "https://api.jisuapi.com/news/get";
  //搜索
  static const String NEWS_SEARCH_JS = "https://api.jisuapi.com/news/search";


  //天气查询
  static const String WEATHER_QUERY ="https://api.jisuapi.com/weather/query?appkey=ee48e79b65875ab3&city=";


  static const String APPKEY_JS = "ee48e79b65875ab3";



}