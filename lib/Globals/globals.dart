import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Controllers/auth_controller.dart';
import '../Controllers/blogs_controller.dart';
import '../Controllers/local_auth_controller.dart';
import '../Controllers/profile_controller.dart';
import '../Controllers/services_controller.dart';
import '../Controllers/trans_controller.dart';
import '../Controllers/wallet_controller.dart';
import '../size_config.dart';
import '../theme.dart';

//-------------------------- Controllers -------------------//
AuthController authController = Get.find<AuthController>();
LocalAuthController local_auth = Get.find<LocalAuthController>();
WalletController walletController = Get.find<WalletController>();
TransController transController = Get.find<TransController>();
BlogsController blogsController = Get.find<BlogsController>();
ServicesController servicesController = Get.find<ServicesController>();
ProfileController profileController = Get.find<ProfileController>();

//-------------------------- Variables -------------------//
var app_version = 1.4;
var uid;
var balance;
var name;
var phone;
var token;
var accountId;
var isMember;
var serial;
var membership;
var exDate;
var img;
String appName = '';
String version = '';
var lang = GetStorage().read("lang");
var isDark = GetStorage().read('isDark');
var isLive = GetStorage().read("Live");

Future<void> init() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appName = packageInfo.appName;
  version = packageInfo.version;

  uid = await GetStorage().read('id');
  balance = await GetStorage().read("balance");
  name = await GetStorage().read("name");
  phone = await GetStorage().read('phone');
  token = await GetStorage().read('login_token');
  accountId = await GetStorage().read('account_id');
  isMember = await GetStorage().read('isMember');
  serial = await GetStorage().read('serial');
  membership = await GetStorage().read('membership');
  exDate = await GetStorage().read('ex_date');
  img = await GetStorage().read('img');
  isLive = GetStorage().read("Live");
}

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  ),
);
