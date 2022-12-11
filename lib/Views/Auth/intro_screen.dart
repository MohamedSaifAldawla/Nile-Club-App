import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Widgets/image_button.dart';
import '../../Controllers/language_controller.dart';
import '../../Widgets/intro.dart';
import '../../size_config.dart';
import '../../theme.dart';

class IntroScreen extends GetView<LanguageController> {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Language".tr),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                "assets/images/Splash.png",
                height: getProportionateScreenHeight(350),
                width: getProportionateScreenWidth(350),
              ),
              ScreenTitle(text: "AppName".tr),
              BodyText(text: "WelcomeText".tr),
              const Gap(70),
              ImageButton(
                text: "العربيه       ",
                image: "assets/images/saudi.png",
                press: () {
                  GetStorage().write("intro", "1");
                  controller.changeLang("ar");
                  Get.offAllNamed("login");
                },
              ),
              const Gap(20),
              ImageButton(
                text: "English",
                image: "assets/images/english.png",
                press: () {
                  GetStorage().write("intro", '1');
                  controller.changeLang("en");
                  Get.offAllNamed("login");
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
