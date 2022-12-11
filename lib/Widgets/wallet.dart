import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/theme.dart';

import '../size_config.dart';
import 'intro.dart';

class Wallet extends StatelessWidget {
  const Wallet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var balance = GetStorage().read("balance");
    var name = GetStorage().read("name");
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).brightness == Brightness.light
              ? shadow
              : shadow2,
          blurRadius: 20.0,
          offset: Offset(0, 8),
          blurStyle: BlurStyle.normal,
        )
      ]),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(40))),
        child: Container(
          width: double.infinity,
          height: getProportionateScreenWidth(190),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    Theme.of(context).brightness == Brightness.light
                        ? "assets/images/Wallet4.png"
                        : "assets/images/Wallet4-1.png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    BodyText(
                      text: name.toUpperCase(),
                      weight: FontWeight.w500,
                      color: kPrimaryLightColor,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/Splash_2.png",
                      width: getProportionateScreenWidth(70),
                      height: getProportionateScreenWidth(70),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      balance != null ? balance : '0.00',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(30),
                          fontWeight: FontWeight.w800,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? kPrimaryLightColor
                                  : yellow),
                    ),
                    Text(
                      ' SDG',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? kPrimaryLightColor
                                  : yellow.withAlpha(200)),
                    ),
                  ],
                ),
                Gap(getProportionateScreenHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/top-up.svg",
                      width: getProportionateScreenWidth(25),
                      height: getProportionateScreenWidth(25),
                      color: Theme.of(context).brightness == Brightness.light
                          ? kPrimaryLightColor
                          : yellow,
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: () {
                        Get.toNamed('wallet');
                      },
                      child: BodyText(
                        text: "Charge Wallet".tr,
                        color: kPrimaryLightColor,
                        // weight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    BodyText(
                      text: "|".tr,
                      color: kPrimaryLightColor,
                    ),
                    const Gap(10),
                    SvgPicture.asset(
                      "assets/icons/Transfer.svg",
                      width: getProportionateScreenWidth(25),
                      height: getProportionateScreenWidth(25),
                      color: Theme.of(context).brightness == Brightness.light
                          ? kPrimaryLightColor
                          : yellow,
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: () {
                        Get.toNamed('transfer');
                      },
                      child: BodyText(
                        text: "Money Transfer".tr,
                        color: kPrimaryLightColor,
                        // weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Wallet2 extends StatelessWidget {
  const Wallet2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var balance = GetStorage().read("balance");
    var name = GetStorage().read("name");
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).brightness == Brightness.light
              ? shadow
              : shadow2,
          blurRadius: 20.0,
          offset: Offset(0, 8),
          blurStyle: BlurStyle.normal,
        )
      ]),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(40))),
        child: Container(
          width: double.infinity,
          height: getProportionateScreenWidth(190),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    Theme.of(context).brightness == Brightness.light
                        ? "assets/images/Wallet4.png"
                        : "assets/images/Wallet4-1.png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    BodyText(
                      text: name.toUpperCase(),
                      weight: FontWeight.w500,
                      color: kPrimaryLightColor,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/Splash_2.png",
                      width: getProportionateScreenWidth(70),
                      height: getProportionateScreenWidth(70),
                    ),
                  ],
                ),
                //const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      balance != null ? balance : '0.00',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(30),
                          fontWeight: FontWeight.w800,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? kPrimaryLightColor
                                  : yellow),
                    ),
                    Text(
                      ' SDG',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? kPrimaryLightColor
                                  : yellow.withAlpha(200)),
                    ),
                  ],
                ),
                Gap(getProportionateScreenHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Transfer.svg",
                      width: getProportionateScreenWidth(25),
                      height: getProportionateScreenWidth(25),
                      color: Theme.of(context).brightness == Brightness.light
                          ? kPrimaryLightColor
                          : yellow,
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('transfer');
                      },
                      child: BodyText(
                        text: "Money Transfer".tr,
                        color: kPrimaryLightColor,
                        // weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








  // @override
  // Widget build(BuildContext context) {
  //   var balance = GetStorage().read("balance");
  //   return Container(
  //     decoration: BoxDecoration(boxShadow: [
  //       BoxShadow(
  //         color: Theme.of(context).brightness == Brightness.light
  //             ? shadow
  //             : shadow2,
  //         blurRadius: 20.0,
  //         offset: Offset(0, 8),
  //         blurStyle: BlurStyle.normal,
  //       )
  //     ]),
  //     child: ClipRRect(
  //         borderRadius: const BorderRadius.all(Radius.circular(40)),
  //         child: Container(
  //           width: double.infinity,
  //           height: 180,
  //           color: Theme.of(context).brightness == Brightness.light
  //               ? kPrimaryLightColor
  //               : kPrimaryDark2Color,
  //           child: Stack(
  //             fit: StackFit.expand,
  //             children: <Widget>[
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Text(
  //                     'Total Balance'.tr,
  //                     style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                         color:
  //                             Theme.of(context).brightness == Brightness.light
  //                                 ? kTextColor
  //                                 : kPrimaryLightColor),
  //                   ),
  //                   const Gap(5),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Text(
  //                         balance != null ? balance : '0.00',
  //                         style: TextStyle(
  //                             fontSize: 30,
  //                             fontWeight: FontWeight.w800,
  //                             color: yellow),
  //                       ),
  //                       Text(
  //                         ' SDG',
  //                         style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.w500,
  //                             color: yellow.withAlpha(200)),
  //                       ),
  //                     ],
  //                   ),
  //                   const Gap(15),
  //                   GestureDetector(
  //                     onTap: () {
  //                       Get.toNamed('wallet');
  //                     },
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         SvgPicture.asset(
  //                           "assets/icons/Wallet.svg",
  //                           width: getProportionateScreenWidth(20),
  //                           height: getProportionateScreenHeight(20),
  //                           color: yellow,
  //                         ),
  //                         Gap(10),
  //                         BodyText(
  //                           text: "Charge Wallet".tr,
  //                           fontSize: 14,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const Positioned(
  //                 left: -150,
  //                 top: -170,
  //                 child: CircleAvatar(
  //                   radius: 130,
  //                   backgroundColor: navyBlue1,
  //                 ),
  //               ),
  //               const Positioned(
  //                 left: -140,
  //                 top: -190,
  //                 child: CircleAvatar(
  //                   radius: 130,
  //                   backgroundColor: kPrimaryColor,
  //                 ),
  //               ),
  //               const Positioned(
  //                 right: -150,
  //                 bottom: -170,
  //                 child: CircleAvatar(
  //                   radius: 130,
  //                   backgroundColor: yellow2,
  //                 ),
  //               ),
  //               const Positioned(
  //                 right: -140,
  //                 bottom: -190,
  //                 child: CircleAvatar(
  //                   radius: 130,
  //                   backgroundColor: yellow,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         )),
  //   );
  // }