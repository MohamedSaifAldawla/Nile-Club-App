import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Controllers/blogs_controller.dart';
import 'package:nile_club/Controllers/trans_controller.dart';
import 'package:nile_club/Models/user.dart';

import '../Globals/globals.dart';
import '../Services/api.dart';
import '../theme.dart';
import 'base_controller.dart';

class AuthController extends GetxController with BaseController {
  TransController transController = Get.find<TransController>();
  BlogsController blogController = Get.find<BlogsController>();

  final user = User().obs;
  var isLoggedIn = false.obs;
  var passLength = 8;
  var otpPhone = "";

  @override
  void onInit() async {
    //CheckToken2();
    //getUsers();
    super.onInit();
  }

//--------------------- Login --------------------------//

  Future<void> login({required Map<String, dynamic> loginData}) async {
    print(loginData);
    showLoading();
    var response = await Api.login(loginData: loginData);
    final res = json.decode(response.data);
    user.value = User.fromJson(res);
    print(res);
    //print(user.value.name);
    if (res['statuscode'] == 3) {
      hideLoading();
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    } else if (res['statuscode'] == 0) {
      await SaveUserData(user);
      isLoggedIn.value = true;
      hideLoading();
      Get.offAllNamed("homepage");
      await profileController.getMembershipsInfo();
    }
  } //end of login

  //--------------------- Register --------------------------//

  Future<void> register({required Map<String, dynamic> registerData}) async {
    showLoading();
    var response = await Api.register(registerData: registerData);
    final res = json.decode(response.data);
    user.value = User.fromJson(res);
    print(res);
    if (res['statuscode'] == 3) {
      hideLoading();
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    } else if (res['statuscode'] == 0) {
      await SaveUserData(user);
      isLoggedIn.value = true;
      hideLoading();
      SnackBar(
          "Success".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
      Get.offAllNamed("homepage");
    }
  } //end of register

  //--------------------- Account tUpdate --------------------------//

  Future<void> AccountUpdate({required Map<String, dynamic> updateData}) async {
    print(updateData);
    showLoading();
    var response = await Api.AccountUpdate(
      name: updateData['name'],
      password: updateData['password'],
    );
    hideLoading();
    final res = json.decode(response.data);
    print(res);
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
    } else if (res['statuscode'] == 0) {
      Get.back();
      SnackBar(
          "Success".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
    }

    //print(checkOut);
  } //end of Account Update

  //--------------------- Reset Password --------------------------//

  Future<void> ResetPassword({required Map<String, dynamic> resetData}) async {
    print(resetData);
    showLoading();
    var response = await Api.ResetPassword(
      phone: resetData['phone'],
    );
    final res = json.decode(response.data);
    print(res);
    if (res['statuscode'] == 3) {
      hideLoading();
      SnackBar(
          "Error".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    } else if (res['statuscode'] == 0) {
      hideLoading();
      SnackBar(
          "Success".tr,
          "New password sent to your phone number".tr,
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
    }

    hideLoading();

    //print(checkOut);
  } //end of Reset Password

  //--------------------- Redeem Account --------------------------//

  Future<void> RedeemAccount({required Map<String, dynamic> resetData}) async {
    print(resetData);
    otpPhone = resetData['phone'];
    showLoading();
    var response = await Api.RedeemAccount(
      phone: resetData['phone'],
    );
    hideLoading();
    final res = json.decode(response.data);
    print(res);
    if (res['statuscode'] == 3) {
      SnackBar(
          "Error".tr,
          res['msg'],
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    } else if (res['statuscode'] == 0) {
      Get.toNamed("otp");
      SnackBar(
          "Success".tr,
          res['msg'],
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
    }
  } //end of Redeem Account
  //--------------------- Verification --------------------------//

  Future<void> Verification({required String otpCode}) async {
    print(otpCode);
    showLoading();
    var response = await Api.Verification(
      otp: otpCode,
      phone: otpPhone,
    );
    hideLoading();
    final res = json.decode(response.data);
    print(res);
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
    } else if (res['statuscode'] == 0) {
      Get.toNamed("login");
      SnackBar(
          "Success".tr,
          res['msg'],
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
    }
  } //end of Verification

//--------------------- Check Token --------------------------//

  Future<void> CheckToken2() async {
    if (await GetStorage().read('login_token') == null) {
      print("No Token");
    } else if (await GetStorage().read('login_token') != null) {
      var response = await Api.ValidToken(uid: GetStorage().read("id"));
      print("Token : $response");
      final res = json.decode(response.data);
      if (res['message'] == 'invalid token') {
        await GetStorage().remove('login_token');
      }
    }
  }

//--------------------- LogOut --------------------------//
  Future<void> logout() async {
    local_auth.autoLogin = false;
    Future.wait([
      GetStorage().remove('id'),
      GetStorage().remove('login_token'),
      GetStorage().remove('account_id'),
      GetStorage().remove('name'),
      GetStorage().remove('account_id'),
      GetStorage().remove('serial'),
      GetStorage().remove('membership'),
      GetStorage().remove('ex_date'),
      GetStorage().remove('img'),
    ]);
    isLoggedIn.value = false;
    await init();
    Get.offAllNamed("login");
    print("Token : $token");
  } //end of logout

//--------------------- User Local Storage Saving --------------------------//

  SaveUserData(Rx<User> user) async {
    Future.wait([
      GetStorage().write('id', user.value.id),
      GetStorage().write('name', user.value.name),
      GetStorage().write('phone', user.value.phone),
      GetStorage().write('isMember', user.value.isMember),
      GetStorage().write('login_token', user.value.token),
      GetStorage().write('account_id', user.value.account_id),
      GetStorage().write('formid', user.value.formid),
      GetStorage().write('serial', user.value.serial),
      GetStorage().write('balance', user.value.balance),
      GetStorage().write('membership', user.value.membership),
      GetStorage().write('ex_date', user.value.exDate),
      GetStorage().write('img', user.value.img),
      GetStorage().write('text', user.value.text),
      GetStorage().write('text2', user.value.text2),
    ]);

    //------------------- Token Decode -------------------------------//
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var parsedtocken = await GetStorage().read('login_token');
    token = stringToBase64.decode(parsedtocken);
    await GetStorage().write('login_token', token);
    await init();
    if (await token != null) {
      print("Token : $token");
      await servicesController.getHomeOffers();
      await blogController.getBlogs();
      await profileController.getMembershipsList();
    }
  }

//--------------------- Snack Bar --------------------------//
  SnackbarController SnackBar(String title, String message, Widget icon,
      Color backgroundColor, SnackPosition? snackPosition) {
    return Get.snackbar(
      title,
      message,
      icon: icon,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
