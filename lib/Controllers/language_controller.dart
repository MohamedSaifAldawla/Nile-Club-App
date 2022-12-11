import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Controllers/blogs_controller.dart';
import 'package:nile_club/Controllers/services_controller.dart';
import 'package:nile_club/Controllers/trans_controller.dart';
import 'package:nile_club/Controllers/wallet_controller.dart';

class LanguageController extends GetxController {
  BlogsController blogController = Get.put(BlogsController());
  TransController transController = Get.put(TransController());
  WalletController walletController = Get.put(WalletController());
  ServicesController servicesController = Get.put(ServicesController());
  Locale? language;
  //ThemeData appTheme = theme(fontFamily: "");
  //ThemeData appTheme = theme(fontFamily: "");

  changeLang(String code) async {
    Locale locale = Locale(code);
    GetStorage().write("lang", code);
    Get.updateLocale(locale);
  }

  @override
  void onInit() async {
    String? lang = GetStorage().read("lang");
    bool? isDark = GetStorage().read("isDark");
    print(lang);
    print("isDark:${isDark}");
    if (lang == "ar") {
      language = const Locale("ar");
    } else if (lang == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      Get.changeThemeMode(ThemeMode.light);
    }

    super.onInit();
  }
}



    // // appTheme = code == "ar" ? themeAr() : theme();
    // //Get.changeTheme(appTheme);
    // Get.changeTheme(theme(fontFamily: code == "ar" ? "Cairo" : "Roboto_Slab"));

          //Get.changeTheme(theme(fontFamily: "Roboto_Slab"));

      //ThemeData(fontFamily: "Roboto_Slab");
      //appTheme = theme();
      //Get.changeTheme(appTheme);
            // if (await ThemeMode.light == true) {
      //   Get.changeTheme(theme(fontFamily: "Roboto_Slab"));
      // }
      // if (await ThemeMode.dark == true) {
      //   Get.changeTheme(themeDark(fontFamily: "Roboto_Slab"));
      // }
            // appTheme = themeAr();
      //Get.changeTheme(theme(fontFamily: "Cairo"));