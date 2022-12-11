import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Globals/globals.dart';
import '../Widgets/loader.dart';
import '../theme.dart';

mixin BaseController {
  void showLoading() {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 150),
        child: Container(
          height: 90,
          width: 10,
          child: Loader(),
        ),
      ),
      barrierDismissible: false,
    );
  } //end of showLoading

  void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  } //end of closeLoading
}

 //end of controller
