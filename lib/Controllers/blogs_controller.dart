import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Models/blogs.dart';
import 'package:nile_club/theme.dart';
import '../Globals/globals.dart';
import '../Services/api.dart';
import 'base_controller.dart';

class BlogsController extends GetxController with BaseController {
  List<Blogs> blogs = <Blogs>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    // if (await GetStorage().read('login_token') != null) {
    //   await getBlogs();
    // }
    super.onInit();
  }

//--------------------- Get Blogs --------------------------//

  Future<void> getBlogs() async {
    isLoading.value = true;
    var response = await Api.Blogs();
    final res = json.decode(response.data);
    //print("Blogs $res");

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
      authController.logout();
    } else {
      BlogsList blogsreponse = BlogsList.fromJson(res);
      blogs.clear();
      blogs.addAll(blogsreponse.blogs);
      isLoading.value = false;
      print("Blogs $blogs");
    }
    //hideLoading();
  }
} //end of Get Blogs

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
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
} //end of controller
