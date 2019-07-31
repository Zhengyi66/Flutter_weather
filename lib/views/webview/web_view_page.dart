import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget{

  final String url;
  final String title;

  WebViewPage(this.url,this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }
}

class _PageState extends State<WebViewPage>{
  @override
  Widget build(BuildContext context) {
    print("WebViewPage  url:" + widget.url + "  title:" + widget.title);
    // TODO: implement build
    return new WebviewScaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff333333),
          title: Text(widget.title),
        ),
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
        initialChild: Center(child: Text("初始化"),),
      );
  }

}