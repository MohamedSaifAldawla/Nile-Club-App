import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Globals/globals.dart';

class MiddleWare extends GetMiddleware {
  @override
  int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    if (isLive == true) {
      if (GetStorage().read("intro") == "1") {
        if (GetStorage().read("fingerAuth") == true) {
          return RouteSettings(name: "auth");
        }
        return RouteSettings(name: "login");
        // return RouteSettings(name: 'maintenance');
      }
    } else if (isLive == false) {
      return RouteSettings(name: 'maintenance');
    } else if (isLive == null) {
      return RouteSettings(name: 'connection');
    }
  }
}
