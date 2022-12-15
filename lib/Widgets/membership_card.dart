import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Widgets/primary_button.dart';
import 'package:screenshot/screenshot.dart';
import '../Controllers/profile_controller.dart';
import '../size_config.dart';
import '../theme.dart';
import 'intro.dart';

Widget MembershipCard(context) {
  ProfileController profileController = Get.find<ProfileController>();

  ScreenshotController screenshotController = ScreenshotController();
  return Center(
    child: SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? kPrimaryLightColor
                    : kPrimaryDark3Color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.light
                        ? shadow
                        : shadow2,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: Column(
                children: [
                  const Gap(30),
                  SizedBox(
                    width: getProportionateScreenWidth(100),
                    height: getProportionateScreenHeight(100),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/logo3.png"),
                    ),
                  ),
                  const Gap(10),
                  BodyText(
                    text: "Your application is under processing".tr,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      BodyText(
                        text: "Status".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text:
                            "${profileController.membershipReserve['status']}",
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      BodyText(
                        text: "Ticket name".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text:
                            "${profileController.membershipReserve['ticketName']}",
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      BodyText(
                        text: "No. of family".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text:
                            "${profileController.membershipReserve['no_family']}" +
                                " " +
                                "family".tr,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Gap(10),
                  if (profileController.membershipType == "Family")
                    Row(
                      children: [
                        BodyText(
                          text: "No. of Adults".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text:
                              "${profileController.membershipReserve['no_adult']}" +
                                  " " +
                                  "Adult's".tr,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  const Gap(10),
                  if (profileController.membershipType == "Family")
                    Row(
                      children: [
                        BodyText(
                          text: "No. of children's".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text:
                              "${profileController.membershipReserve['no_child']}" +
                                  " " +
                                  "children's".tr,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  const Gap(10),
                  if (profileController.membershipType == "Family" &&
                      profileController.membershipReserve['no_adult'] < 2)
                    InkWell(
                      onTap: () {
                        profileController.Init();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: getProportionateScreenHeight(50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BodyText(
                                text: "Add Adult".tr.toUpperCase(),
                                weight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const Gap(10),
                  if (profileController.membershipType == "Family")
                    InkWell(
                      onTap: () {
                        profileController.Init();
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: getProportionateScreenHeight(50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BodyText(
                                text: "Add Child".tr.toUpperCase(),
                                weight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const Gap(10),
                  PrimaryButton(
                    text: "homepage".tr,
                    press: () {
                      Get.offAllNamed('homepage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
