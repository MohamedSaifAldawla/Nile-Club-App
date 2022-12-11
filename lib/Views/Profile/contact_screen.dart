import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Widgets/social_item.dart';
import 'package:nile_club/theme.dart';
import '../../Controllers/profile_controller.dart';
import '../../Globals/globals.dart';
import '../../Widgets/intro.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help Center".tr,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 70),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Clock.svg",
                        color: kSecondaryColor,
                        width: 25,
                        height: 25,
                      ),
                      const Gap(10),
                      NormalBodyText(
                        text: 'Working Hours'.tr,
                        fontSize: 15,
                        color: kSecondaryColor,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Gap(10),
                  BodyText(
                    text: " All Days / 4PM - 12AM",
                    fontSize: 18,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Phone2.svg",
                        color: kSecondaryColor,
                        width: 25,
                        height: 25,
                      ),
                      const Gap(10),
                      NormalBodyText(
                        text: 'Phone Numbers'.tr,
                        fontSize: 15,
                        color: kSecondaryColor,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Gap(10),
                  BodyText(
                    text: "${GetStorage().read("call")} - 0187090100",
                    fontSize: 18,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Message.svg",
                        color: kSecondaryColor,
                        width: 25,
                        height: 25,
                      ),
                      const Gap(10),
                      NormalBodyText(
                        text: 'Email Address'.tr,
                        fontSize: 15,
                        color: kSecondaryColor,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Gap(10),
                  BodyText(
                    text: "info@nileclub.net",
                    fontSize: 18,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Location.svg",
                        color: kSecondaryColor,
                        width: 25,
                        height: 25,
                      ),
                      const Gap(10),
                      NormalBodyText(
                        text: 'Office Location'.tr,
                        fontSize: 15,
                        color: kSecondaryColor,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Gap(10),
                  BodyText(
                    text: "JG6R+XH4, Nile St, Khartoum, Sudan",
                    fontSize: 18,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                  const Gap(40),
                  BodyText(text: "--------  Reach us on  --------".tr),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "assets/icons/Phone3.svg",
                        press: () {
                          profileController.launchInPhone(
                              "tel:${GetStorage().read("call")}");
                        },
                      ),
                      SocialCard(
                        icon: "assets/icons/WhatsApp.svg",
                        press: () {
                          profileController.launchInBrowser(
                              "https://api.whatsapp.com/send?phone=${GetStorage().read("whatsapp")}");
                        },
                      ),
                      SocialCard(
                        icon: "assets/icons/Messenger.svg",
                        press: () {
                          profileController.launchInBrowser(
                              "${GetStorage().read("messenger")}");
                        },
                      ),
                    ],
                  ),
                  const Gap(60),
                  NormalBodyText(
                    text: "version ${version}",
                    fontSize: 15,
                    color: kSecondaryColor,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
