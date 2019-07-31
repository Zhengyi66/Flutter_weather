import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'routers/application.dart';
import 'routers/routers.dart';
import 'views/home/home.dart';
import 'views/welcome/welcome_page.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp(){
    final router = new Router();

    Routes.configurRoutes(router);

    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //欢迎页
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Flutter_Warther",
      theme:  new ThemeData(
        backgroundColor: Color(0xffffffff),
        textTheme: TextTheme(
          body1: TextStyle(color: Color(0xff333333))
        )
      ),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
    );
  }

}
