import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Controllers/profile_controller.dart';

class LoginMiddleWare extends GetMiddleware {
  ProfileController profileController = Get.find<ProfileController>();
  @override
  int? priority = 2;

  @override
  // ignore: body_might_complete_normally_nullable
  RouteSettings? redirect(String? route) {
    if (GetStorage().read('login_token') != null) {
      return RouteSettings(name: "homepage");
      //profileController.CheckToken2();
    }
  }
}
