import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather/model/city.dart';

class CityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff343434),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back,color: Colors.white,),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text("选择城市",style: TextStyle(fontSize: 16,color: Colors.white),),
      ),
      body: _HomePage(),
    );
  }

}

class _HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }

}

class _PageState extends State<_HomePage>{

  List<City> citys = [];
  List<City> searchCitys = [];
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCitys();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _buildSearch(),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return _getItem(searchCitys[index].city);
            },
            itemCount: searchCitys.length,
          )
        ],
      ),
    );
  }

  //加载城市信息
  loadCitys() async {
    Future<String> future = DefaultAssetBundle.of(context).loadString("assets/json/city.json");
    future.then((value){
        CityBean cityBean = CityBean.fromJson(json.decode(value));
        citys.addAll(cityBean.result);
    });
  }

  Widget _buildSearch(){
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
              child:Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xfff3f3f3),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入城市名称',
                        hintStyle: TextStyle(
                          color: Color(0xffaeaeb0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            child:  Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Color(0xff02a8f1),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
              ),
              child: Icon(Icons.search,size: 30,color: Colors.white,),
            ),
            onTap: (){
              searchData(_controller.text);
            },
          ),

        ],
      ),
    );
  }

  Widget _getItem(String city){
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.only(left: 20),
          color: Color(0xffE8E8E8),
          alignment: Alignment.centerLeft,
          height: 40,
          child:Text(city,style: TextStyle(fontSize: 18,color: Colors.black))
      ),
      onTap: (){
        //传递city
        Navigator.of(context).pop(city);
      },
    );
  }

  void searchData(String text) async {
    if(text.isEmpty){
      setState(() {
        searchCitys.clear();
      });
    }else{
      searchCitys.clear();
      for(City city in citys){
        if(city.city.contains(text)){
          searchCitys.add(city);
        }
      }
      setState(() {

      });
    }

  }

}

