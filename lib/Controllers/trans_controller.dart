import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/theme.dart';
import '../Models/transactions.dart';
import '../Services/api.dart';
import 'base_controller.dart';

class TransController extends GetxController with BaseController {
  //List<Transaction> trans = <Transaction>[].obs;
  List<Transaction> trans = <Transaction>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    //GetHistory();
    super.onInit();
  }

//--------------------- Get History  --------------------------//

  Future<void> GetHistory() async {
    isLoading.value = true;
    var response = await Api.GetHistory();
    final res = json.decode(response.data);
    //print("Transaction :$res");
    if (res['statuscode'] == 3) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    }
    if (res['statuscode'] == 414) {
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      await authController.logout();
    } else {
      TransList transreponse = TransList.fromJson(res);
      trans.clear();
      trans.addAll(transreponse.trans);
      isLoading.value = false;
      print("Transaction :$trans");
    }
  } //end of Get History

//--------------------- Snack Bar --------------------------//
  SnackbarController SnackBar(String title, String message, Widget icon,
      Color backgroundColor, SnackPosition? snackPosition) {
    return Get.snackbar(
      title,
      message,
      icon: icon,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      borderRadius: 20,
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
} //end of controller
