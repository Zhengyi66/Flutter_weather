
class CityBean{
  final List<City> result;

  CityBean({this.result});

  factory CityBean.fromJson(Map<String, dynamic> json){
    var tempList = json['result'] as List;
    List<City> items = tempList.map((i) => City.fromJson(i)).toList();
    return CityBean(
      result: items
    );
  }

}

class City{

  final int cityid;
  final String city;

  City({this.cityid,this.city});

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      cityid: json['cityid'],
      city: json['city']
    );
  }

}