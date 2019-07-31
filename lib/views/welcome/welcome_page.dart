import 'package:flutter/material.dart';
import 'package:flutter_weather/views/home/home.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AppHome()),
      (route)=>route == null);
    });
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Image(image: AssetImage("assets/images/welcome.jpg")),
            Column(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(child: Text("Flutter  Weather",style: TextStyle(fontSize: 26,color: Colors.blue,fontStyle: FontStyle.italic)),
                        bottom: 0,
                        )
                      ],
                    )
                ),
                Expanded(
                    flex: 6,
                    child: Text("")),
              ],
            )
          ],
        )
      ),
    );
  }
}
