import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../theme.dart';
import 'base_controller.dart';

class LocalAuthController extends GetxController with BaseController {
  final _auth = LocalAuthentication();
  bool autoLogin = false;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) {
      SnackBar(
        "Error".tr,
        "Fingerprint not supported".tr,
        SvgPicture.asset(
          "assets/icons/Close.svg",
          color: Colors.white,
        ),
        error,
        SnackPosition.TOP,
        5,
      );
      return false;
    }

    try {
      return await _auth.authenticate(
        localizedReason: ' ',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
      SnackBar(
        "Error".tr,
        "Please enable fingerprint".tr,
        SvgPicture.asset(
          "assets/icons/Close.svg",
          color: Colors.white,
        ),
        error,
        SnackPosition.TOP,
        5,
      );
      return false;
    }
  }

  //--------------------- Snack Bar --------------------------//
  SnackbarController SnackBar(String title, String message, Widget icon,
      Color backgroundColor, SnackPosition? snackPosition, int duration) {
    return Get.snackbar(
      title,
      message,
      icon: icon,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      borderRadius: 20,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
} //end of controller




  // Future<List<BiometricType>> getBiometrics() async {
  //   try {
  //     return await _auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     print(e);
  //     return <BiometricType>[];
  //   }
  // }