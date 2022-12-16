import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:nile_club/Controllers/trans_controller.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Models/Memberships.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/TransMemberships.dart';
import '../Models/services.dart';
import '../Services/api.dart';
import '../theme.dart';
import 'base_controller.dart';

class ProfileController extends GetxController with BaseController {
  final transController = Get.find<TransController>();
  String? scannedQR;

  List<Services> services = <Services>[].obs;
  List<Memberships> memberships = <Memberships>[].obs;
  List<TransMemberships> transMemberships = <TransMemberships>[].obs;
  var membershipType;
  var membershipReserve = {};
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupController = TextEditingController();
  final TextEditingController membershipIdController = TextEditingController();

  bool darkMode = false;
  bool fingerAuth = false;

  @override
  void onInit() async {
    getMembershipsList();
    bool? isDark = await GetStorage().read("isDark");
    bool? fAuth = await GetStorage().read("fingerAuth");
    if (isDark == true) {
      darkMode = true;
    }
    if (isDark == false) {
      darkMode = false;
    }
    if (fAuth == true) {
      fingerAuth = true;
    }
    if (fAuth == false) {
      fingerAuth = false;
    }
    super.onInit();
  }

  //--------------------- Get Memberships List --------------------------//
  Future<void> getMembershipsList() async {
    //showLoading();
    var response = await Api.GetMembershipsList();
    final res = json.decode(response.data);
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
    } else {
      MembershipList membershipreponse = MembershipList.fromJson(res);
      memberships.clear();
      memberships.addAll(membershipreponse.memberships);
      print(memberships);
    }
    //hideLoading();
    //Get.toNamed('membershiplist');
  }

  //--------------------- Get Memberships --------------------------//
  Future<void> getMemberships({required String catId}) async {
    showLoading();
    var response = await Api.Services(catId: catId);
    final res = json.decode(response.data);
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
    } else {
      ServiceList servicereponse = ServiceList.fromJson(res);
      services.clear();
      services.addAll(servicereponse.services);
      print(services);
      hideLoading();
      Get.toNamed('membership');
    }
  }

  Future<void> getTransMemberships() async {
    showLoading();
    var response = await Api.GetMemberships();
    hideLoading();
    final res = json.decode(response.data);
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
    } else {
      TransMembershipList transMembershipsreponse =
          TransMembershipList.fromJson(res);
      transMemberships.clear();
      transMemberships.addAll(transMembershipsreponse.memberships);
      print(transMemberships);
      Get.toNamed('transmembership');
    }
  }

  //--------------------- Subscribe --------------------------//
  Future<void> Subscribe({required Map<String, dynamic> subscribeData}) async {
    print(subscribeData);
    showLoading();
    var response = await Api.Subscribe(subscribeData: subscribeData);
    final res = json.decode(response.data);
    //print(res);
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
    }
    if (res['statuscode'] == 0) {
      hideLoading();
      membershipReserve.clear();
      membershipReserve = json.decode(response.data);
      membershipReserve.addAll(membershipReserve);
      print(membershipReserve);
      await GetStorage().write('formid', res['formid']);
      await init();
      Get.toNamed('membershipconfirm');
      // await GetStorage().write('formid', res['formid']);
    }
  }

  //--------------------- AddFamily --------------------------//
  Future<void> AddFamily({required Map<String, dynamic> familyData}) async {
    print(familyData);
    showLoading();
    var response = await Api.AddFamily(familyData: familyData);
    final res = json.decode(response.data);
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
    }
    if (res['statuscode'] == 0) {
      hideLoading();
      SnackBar(
          "Success".tr,
          "Your application is under processing".tr,
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
      Get.toNamed("membership");
    }
    print(res);
  }

  //--------------------- Activate --------------------------//
  Future<void> Activate({required String? serial, required accountID}) async {
    //print(serial);
    showLoading();
    var response = await Api.Activate(serial: serial, accountID: accountID);
    final res = json.decode(response.data);
    hideLoading();
    print("Activate : $res");
    if (res['statuscode'] == 0) {
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
    if (res['statuscode'] == 3) {
      Get.back();
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
  }

  //--------------------- Delete Account --------------------------//
  Future<void> DeleteAccount() async {
    showLoading();
    var response = await Api.DeleteAccount();
    final res = json.decode(response.data);
    print(res);
    hideLoading();
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
      SnackBar(
          "Success".tr,
          res['message'],
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
      authController.logout();
    }
  } //end of Delete Account

  //--------------------- launchInBrowser --------------------------//
  Future<void> launchInBrowser(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInPhone(String phone) async {
    var uri = Uri.parse(phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $phone';
    }
  }

//--------------------- CheckToken --------------------------//

  Future<void> CheckToken() async {
    showLoading();
    var response = await Api.ValidToken(uid: uid);
    print(response);
    final res = json.decode(response.data);
    hideLoading();

    if (res['message'] == 'valid token') {
      Get.toNamed('wallet');
    } else {
      SnackBar(
          "Error".tr,
          "Sorry ,your previous session expired try login again".tr,
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      Get.offAllNamed('login');
    }
  }

  Future<void> CheckToken2() async {
    showLoading();
    var response = await Api.ValidToken(uid: uid);
    print(response);
    final res = json.decode(response.data);
    hideLoading();

    if (res['message'] == 'valid token') {
      Get.offAllNamed('homepage');
      //RouteSettings(name: "homepage");
    } else {
      SnackBar(
          "Error".tr,
          "Sorry ,your previous session expired try login again".tr,
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
      Get.offAllNamed('login');
    }
  }

//--------------------- Init Variables --------------------------//
  void Init() {
    fullnameController.text = '';
    addressController.text = '';
    emailController.text = '';
    phoneController.text = '';
    occupController.text = '';
  }

//--------------------- Save Image --------------------------//
  Future<void> saveImage(Uint8List image) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(image, name: name);
    if (result['isSuccess'] == true) {
      print(result);
      authController.SnackBar(
          "Success".tr,
          "Saved successfully".tr,
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP);
    } else {
      SnackBar(
          "Error".tr,
          '$result',
          SvgPicture.asset(
            "assets/icons/Close.svg",
            color: Colors.white,
          ),
          error,
          SnackPosition.TOP);
    }
  }

//--------------------- Change Theme --------------------------//
  void ChangeTheme(value) {
    if (value == true) {
      darkMode = true;
      Get.changeThemeMode(ThemeMode.dark);
      GetStorage().write("isDark", true);
    } else if (value == false) {
      darkMode = false;
      Get.changeThemeMode(ThemeMode.light);
      GetStorage().write("isDark", false);
    }
    update();
  }

//--------------------- Change Auth --------------------------//
  void ChangeAuth(value) async {
    final isAvailable = await local_auth.hasBiometrics();
    if (value == true) {
      if (isAvailable) {
        local_auth.SnackBar(
          "Success".tr,
          "Fingerprint activated successfully".tr,
          SvgPicture.asset(
            "assets/icons/Success2.svg",
            color: Colors.white,
          ),
          success,
          SnackPosition.TOP,
          3,
        );
        fingerAuth = true;
        await GetStorage().write("fingerAuth", true);
      }
      if (!isAvailable) {
        local_auth.SnackBar(
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
        fingerAuth = false;
        await GetStorage().write("fingerAuth", false);
      }
    } else if (value == false) {
      fingerAuth = false;
      await GetStorage().write("fingerAuth", false);
    }
    update();
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
      duration: Duration(seconds: 15),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
} //end of controller
