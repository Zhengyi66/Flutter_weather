import 'package:flutter/material.dart';

class MyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String msg = "Flutter Weather是一个flutter的练习项目，通过该项目算是对flutter有个基本的认知，当然也仅仅局限于基本。"
        "因为目前公司用不到，当做一个储备技能。需要的时候能够很快进入状态";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff343434),
        leading: Icon(Icons.person,color: Colors.white,),
        title: Text("关于我",style: TextStyle(fontSize: 18,color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(msg,style: TextStyle(color: Color(0xff555555),fontSize: 14)),
            SizedBox(height: 20,),
            Text("项目地址:",style: TextStyle(fontSize: 18,color: Color(0xff333333)),)
          ],
        ),
      )
    );
  }

}