import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './router_handler.dart';

class Routes{
  static String root = '/';
  static String home = "/home";
  static String webViewPage = "/web-view-page";
  static String searchPage = "/search-page";
  static String cityPage = "/city";
  static String myPage = "/my";

  static void configurRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      }
    );

    router.define(home, handler: homeHandler);
    router.define(webViewPage, handler: webViewPageHandler);
    router.define(searchPage, handler: searchPageHandler);
    router.define(cityPage, handler: cityHandler);
    router.define(myPage, handler: myHandler);
  }
}