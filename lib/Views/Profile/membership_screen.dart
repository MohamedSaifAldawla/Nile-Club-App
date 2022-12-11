import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Controllers/profile_controller.dart';
import 'package:nile_club/Views/Profile/subscribe_screen.dart';

import '../../Animations/FadeAnimation.dart';
import '../../Models/services.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/sections.title.dart';
import '../../Widgets/services_item.dart';
import '../../size_config.dart';
import '../../theme.dart';

class MembershipScreen extends StatelessWidget {
  MembershipScreen({Key? key}) : super(key: key);
  ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memberships".tr),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: profileController.services.length,
        itemBuilder: (context, index) => FadeAnimation2(
          1,
          MembershipCard(
              services: profileController.services[index],
              profileController: profileController,
              context: context),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 0,
        ),
      ),
    );
  }
}

Widget MembershipCard(
    {required Services services, profileController, context}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(horizontalPadding),
        vertical: getProportionateScreenWidth(10)),
    child: GestureDetector(
      onTap: () {
        profileController.Init();
        Get.to(() => SubscribeScreen(services: services));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? kPrimaryLightColor
              : kPrimaryDark3Color,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
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
          padding: EdgeInsets.only(
              top: getProportionateScreenWidth(30),
              bottom: getProportionateScreenWidth(30),
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenWidth(50),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage("${services.img}"),
                ),
              ),
              const Gap(20),
              Expanded(
                child: BodyText(
                  text: "${services.ticketType}".tr,
                  weight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? kSecondaryColor
                      : kPrimaryLightColor,
                  fontSize: getProportionateScreenWidth(18),
                  maxLines: 2,
                ),
              ),
              const Gap(25),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? kPrimaryLightColor
                        : kPrimaryDarkColor,
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
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    child: BodyText(
                      text: "${services.totalPrice}" " SDG".tr,
                      weight: FontWeight.bold,
                      color: gold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}





  // const Gap(40),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     BodyText(
            //       text: "Add family members".tr,
            //       weight: FontWeight.bold,
            //       fontSize: 18,
            //     ),
            //   ],
            // ),
            // const Gap(20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ServicesItem2(
            //       icon: "assets/icons/Groom.svg",
            //       containercolor: Color.fromARGB(20, 3, 168, 245),
            //       iconcolor: Color(0xff03A9F5),
            //       service: "Adult's".tr,
            //       onTap: () {
            //         profileController.type = "Adult";
            //         profileController.Init();

            //         Get.toNamed('family');
            //         print(profileController.type);
            //         // if (profileController.isAdult == true) {
            //         //   profileController.SnackBar(
            //         //       "Error".tr,
            //         //       "Sorry ,you reached the maximum number".tr,
            //         //       SvgPicture.asset(
            //         //         "assets/icons/Close.svg",
            //         //         color: Colors.white,
            //         //       ),
            //         //       error,
            //         //       SnackPosition.TOP);
            //         // } else if (profileController.isAdult == false) {
            //         //   profileController.type = "Adult";
            //         //   Get.toNamed('family');
            //         //   print(profileController.type);
            //         // }
            //       },
            //     ),
            //     const Gap(20),
            //     ServicesItem2(
            //       icon: "assets/icons/Babys.svg",
            //       containercolor: Color.fromARGB(20, 234, 30, 99),
            //       iconcolor: Color(0xffEA1E63),
            //       service: "children's".tr,
            //       onTap: () {
            //         profileController.type = "Child";
            //         profileController.Init();

            //         Get.toNamed('family');
            //         print(profileController.type);
            //       },
            //     ),
            //   ],
            // ),