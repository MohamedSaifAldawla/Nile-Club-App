import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Controllers/language_controller.dart';
import 'package:nile_club/Controllers/profile_controller.dart';
import 'package:nile_club/Widgets/intro.dart';
import 'package:nile_club/size_config.dart';
import 'package:nile_club/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:restart_app/restart_app.dart';

import '../../Animations/FadeAnimation.dart';
import '../../Controllers/auth_controller.dart';
import '../../Globals/globals.dart';
import '../../Widgets/profile_card.dart';

class ProfileScreen extends GetView<LanguageController> {
  ProfileScreen({Key? key}) : super(key: key);
  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".tr),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(horizontalPadding),
              vertical: getProportionateScreenWidth(10)),
          child: Column(
            children: [
              FadeAnimation(
                1,
                Container(
                  width: double.infinity,
                  height: getProportionateScreenWidth(140),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? kPrimaryLightColor
                        : kPrimaryDark3Color,
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.light
                            ? shadow
                            : shadow2,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(100),
                          height: getProportionateScreenWidth(100),
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? kPrimaryLightColor
                                    : kPrimaryDark3Color,
                            backgroundImage:
                                AssetImage("assets/images/User.png"),
                          ),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text:
                                  "${GetStorage().read("name")}".toUpperCase(),
                              weight: FontWeight.bold,
                            ),
                            const Gap(5),
                            BodyText(
                              text: "${GetStorage().read("phone")}",
                              color: kSecondaryColor,
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(15)),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: getProportionateScreenWidth(270),
                                  color: kPrimaryLightColor,
                                  child: Center(
                                    child: QrImage(
                                      data: accountId,
                                      backgroundColor: kPrimaryLightColor,
                                      version: QrVersions.auto,
                                      size: getProportionateScreenWidth(200),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: QrImage(
                            data: accountId,
                            backgroundColor: kPrimaryLightColor,
                            version: QrVersions.auto,
                            size: getProportionateScreenWidth(70),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              FadeAnimation2(
                1.2,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenWidth(60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? kPrimaryLightColor
                          : kPrimaryDark3Color,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? shadow
                                  : shadow2,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      //padding: const EdgeInsets.all(15),
                      padding: EdgeInsets.only(
                          top: getProportionateScreenWidth(12),
                          bottom: getProportionateScreenWidth(12),
                          left: getProportionateScreenWidth(15),
                          right: getProportionateScreenWidth(15)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Translation.svg",
                            color: kPrimaryColor,
                            width: getProportionateScreenWidth(25),
                            height: getProportionateScreenWidth(25),
                          ),
                          const Gap(20),
                          BodyText(text: "Language".tr),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              controller.changeLang("en");
                              Future.delayed(const Duration(seconds: 2),
                                  () => Restart.restartApp());
                            },
                            child: Image.asset(
                              "assets/images/english.png",
                              height: getProportionateScreenWidth(30),
                              width: getProportionateScreenWidth(30),
                            ),
                          ),
                          const Gap(10),
                          GestureDetector(
                            onTap: () async {
                              await controller.changeLang("ar");
                              Future.delayed(const Duration(seconds: 2),
                                  () => Restart.restartApp());
                            },
                            child: Image.asset(
                              "assets/images/saudi.png",
                              height: getProportionateScreenWidth(30),
                              width: getProportionateScreenWidth(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              FadeAnimation2(
                1.3,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenWidth(60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? kPrimaryLightColor
                          : kPrimaryDark3Color,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? shadow
                                  : shadow2,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      //padding: const EdgeInsets.all(15),
                      padding: EdgeInsets.only(
                          top: getProportionateScreenWidth(12),
                          bottom: getProportionateScreenWidth(12),
                          left: getProportionateScreenWidth(15),
                          right: getProportionateScreenWidth(15)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Moon.svg",
                            color: gold,
                            width: getProportionateScreenWidth(25),
                            height: getProportionateScreenWidth(25),
                          ),
                          const Gap(20),
                          BodyText(text: "Dark Mode".tr),
                          Spacer(),
                          GetBuilder<ProfileController>(
                            builder: (_) {
                              return Switch(
                                activeColor: yellow,
                                activeTrackColor: yellow,
                                inactiveTrackColor:
                                    Color.fromARGB(255, 203, 201, 201),
                                activeThumbImage: const AssetImage(
                                    'assets/images/DarkMoon.png'),
                                inactiveThumbImage: const AssetImage(
                                    'assets/images/DarkSummer.png'),
                                value: profileController.darkMode,
                                onChanged: (value) {
                                  profileController.ChangeTheme(value);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              FadeAnimation2(
                1.3,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: getProportionateScreenWidth(60),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? kPrimaryLightColor
                          : kPrimaryDark3Color,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? shadow
                                  : shadow2,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenWidth(12),
                          bottom: getProportionateScreenWidth(12),
                          left: getProportionateScreenWidth(15),
                          right: getProportionateScreenWidth(15)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Fingerprint.svg",
                            color: Color(0xffF32613),
                            width: getProportionateScreenWidth(25),
                            height: getProportionateScreenWidth(25),
                          ),
                          const Gap(20),
                          BodyText(text: "Finger Authorization".tr),
                          Spacer(),
                          GetBuilder<ProfileController>(
                            builder: (_) {
                              return Switch(
                                activeColor: Color(0xffF32613),
                                activeTrackColor: Color(0xffF32613),
                                inactiveTrackColor:
                                    Color.fromARGB(255, 203, 201, 201),
                                activeThumbImage: const AssetImage(
                                    'assets/images/Fingerprint2.png'),
                                inactiveThumbImage: const AssetImage(
                                    'assets/images/Fingerprint.png'),
                                value: profileController.fingerAuth,
                                onChanged: (value) {
                                  profileController.ChangeAuth(value);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              FadeAnimation2(
                1.4,
                ProfileCard(
                  firstIcon: "assets/icons/Male.svg",
                  title: "My Account".tr,
                  color: orange,
                  onTap: () {
                    Get.toNamed('account');
                  },
                ),
              ),
              const Gap(15),
              FadeAnimation2(
                1.5,
                ProfileCard(
                  firstIcon: "assets/icons/Questionmark.svg",
                  title: "Help Center".tr,
                  color: success,
                  onTap: () {
                    Get.toNamed('contact');
                  },
                ),
              ),
              const Gap(15),
              FadeAnimation2(
                1.6,
                ProfileCard(
                  firstIcon: "assets/icons/Close.svg",
                  title: "Delete account".tr,
                  color: purple,
                  onTap: () {
                    GetDialog(
                      context: context,
                      icon: "assets/icons/Close.svg",
                      title: "Confirm Deleting".tr,
                      onTap: () {
                        profileController.DeleteAccount();
                      },
                    );
                  },
                ),
              ),
              const Gap(15),
              FadeAnimation2(
                1.7,
                ProfileCard(
                  firstIcon: "assets/icons/Export.svg",
                  title: "Log Out".tr,
                  color: error,
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(15)),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenWidth(25),
                              left: getProportionateScreenWidth(16),
                              right: getProportionateScreenWidth(16)),
                          width: double.infinity,
                          height: getProportionateScreenWidth(270),
                          child: Column(
                            children: [
                              Container(
                                width: getProportionateScreenWidth(70),
                                height: getProportionateScreenWidth(75),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kSecondaryColor,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(100)),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/Export.svg",
                                    width: getProportionateScreenWidth(40),
                                    height: getProportionateScreenWidth(40),
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ),
                              Gap(15),
                              BodyText(
                                text: "Confirm Logout".tr,
                                fontSize: getProportionateScreenWidth(16),
                                weight: FontWeight.bold,
                              ),
                              Gap(40),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        width: getProportionateScreenWidth(30),
                                        height: getProportionateScreenWidth(50),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: kTextColor),
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? kPrimaryLightColor
                                              : kPrimaryDarkColor,
                                          borderRadius: BorderRadius.circular(
                                              getProportionateScreenWidth(20)),
                                        ),
                                        child: Center(
                                          child: BodyText(
                                            text: "No".tr,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        AuthController().logout();
                                      },
                                      child: Container(
                                        width: getProportionateScreenWidth(30),
                                        height: getProportionateScreenWidth(50),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: kPrimaryColor),
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.circular(
                                              getProportionateScreenWidth(20)),
                                        ),
                                        child: Center(
                                          child: BodyText(
                                            text: "Yes".tr,
                                            color: kPrimaryLightColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetDialog(
      {required context,
      required String icon,
      required String title,
      required void Function() onTap}) {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
        ),
        child: Container(
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(25),
              left: getProportionateScreenWidth(16),
              right: getProportionateScreenWidth(16)),
          width: double.infinity,
          height: getProportionateScreenWidth(270),
          child: Column(
            children: [
              Container(
                width: getProportionateScreenWidth(70),
                height: getProportionateScreenWidth(75),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: error,
                    width: 1.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(100)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: getProportionateScreenWidth(40),
                    height: getProportionateScreenWidth(40),
                    color: error,
                  ),
                ),
              ),
              Gap(15),
              BodyText(
                text: title,
                fontSize: getProportionateScreenWidth(16),
                weight: FontWeight.bold,
              ),
              Gap(40),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenWidth(50),
                        decoration: BoxDecoration(
                          border: Border.all(color: kTextColor),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? kPrimaryLightColor
                                  : kPrimaryDarkColor,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(12)),
                        ),
                        child: Center(
                          child: BodyText(
                            text: "No".tr,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        width: getProportionateScreenWidth(30),
                        height: getProportionateScreenWidth(50),
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(20)),
                        ),
                        child: Center(
                          child: BodyText(
                            text: "Yes".tr,
                            color: kPrimaryLightColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
