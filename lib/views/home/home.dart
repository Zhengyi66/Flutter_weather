
import 'package:flutter/material.dart';

import 'package:flutter_weather/views/news/news_page.dart';
import 'package:flutter_weather/views/home/home_page_view.dart';
import 'package:flutter_weather/views/my/my.dart';

class AppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<AppHome> {
  int _currentIndex = 0;
  List<Widget> _widgets = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _widgets
      ..add(HomePageView())
      ..add(NewsPage())
      ..add(MyPage());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _widgets,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny), title: Text("天气")),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text("今日热点")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我")),
        ],
        currentIndex: _currentIndex,
        onTap: _itemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff212121),
        selectedItemColor: Color(0xff3d93ee),
        unselectedItemColor: Color(0xff8e8e8e),
        iconSize: 25,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

