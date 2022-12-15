import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Models/transactions.dart';
import 'package:nile_club/Widgets/secondery_button.dart';
import 'package:nile_club/Widgets/social_item.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../Animations/FadeAnimation.dart';
import '../size_config.dart';
import '../theme.dart';
import 'intro.dart';
import 'loader.dart';

Widget TicketCard(Transaction transaction, context) {
  ScreenshotController screenshotController = ScreenshotController();
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(horizontalPadding),
          vertical: getProportionateScreenWidth(20)),
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? kPrimaryLightColor
                  : kPrimaryDark3Color,
              image: DecorationImage(
                  image: Theme.of(context).brightness == Brightness.light
                      ? AssetImage("assets/images/ticket2.png")
                      : AssetImage("assets/images/ticket.png"),
                  fit: BoxFit.cover),
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
              ]),
          child: FadeAnimation(
            1,
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(25),
                  right: getProportionateScreenWidth(25),
                  bottom: getProportionateScreenWidth(25)),
              child: Column(
                children: [
                  const Gap(30),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: "${transaction.outputImg}",
                      placeholder: (context, url) => Loader(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 60,
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        width: getProportionateScreenWidth(100.0),
                        height: getProportionateScreenWidth(100.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  BodyText(
                    text: "${transaction.outputResponsemessage}".tr,
                    maxLines: 2,
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      BodyText(
                        text: "Transaction id".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text: "${transaction.id}",
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      BodyText(
                        text: "Status".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text: "${transaction.output}",
                        weight: FontWeight.bold,
                        color: transaction.output == "Pending" ? gold : success,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      BodyText(
                        text: "Amount".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text: "${transaction.outputAmount}" + "SDG".tr,
                        weight: FontWeight.bold,
                        color: success,
                      ),
                    ],
                  ),
                  if (transaction.alias == "topup") const Gap(10),
                  if (transaction.alias == "topup")
                    Row(
                      children: [
                        BodyText(
                          text: "Ticket type".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${transaction.outputTicketType}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  const Gap(10),
                  if (transaction.alias != "topup")
                    Row(
                      children: [
                        BodyText(
                          text: transaction.alias == "reserve"
                              ? "Service".tr
                              : "Type".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${transaction.outputOrganizer}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  const Gap(10),
                  if (transaction.alias != "topup")
                    Row(
                      children: [
                        BodyText(
                          text: transaction.alias == "reserve"
                              ? "Ticket type".tr
                              : "Package name".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${transaction.outputTicketType}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  if (transaction.alias == "reserve") const Gap(10),
                  if (transaction.alias == "reserve")
                    Row(
                      children: [
                        BodyText(
                          text: "Note".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        Expanded(
                          flex: 4,
                          child: BodyText(
                            text: '''${transaction.outputNote}''',
                            weight: FontWeight.bold,
                            textAlign: TextAlign.end,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                  const Gap(30),
                  Row(
                    children: [
                      BodyText(
                        text: "Booking Details".tr,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      BodyText(
                        text: "Phone no".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text: "${transaction.outputPhone}",
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      BodyText(
                        text: "Date".tr,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                      BodyText(
                        text: Jiffy('${transaction.outputDate}')
                            .format('MMM do yyyy, h:mm a'),
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  if (transaction.alias != "topup") const Gap(10),
                  if (transaction.alias != "topup")
                    Row(
                      children: [
                        BodyText(
                          text: "No. of persons".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${transaction.outputQty}" + "person".tr,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  const Gap(10),
                  Divider(
                    color: kSecondaryColor,
                    thickness: 0.1,
                  ),
                  if (transaction.alias != "membership") const Gap(10),
                  if (transaction.alias != "membership")
                    Row(
                      children: [
                        BodyText(
                          text: "Remaning Balance".tr,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${transaction.outputBalance} " + "SDG".tr,
                          weight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(18),
                          color: success,
                        ),
                      ],
                    ),
                  const Gap(10),
                  if (transaction.alias == "membership")
                    Row(
                      children: [
                        BodyText(
                          text: "Extra fees".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${transaction.outputExtraFees} " + "SDG".tr,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  if (transaction.alias == "reserve")
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: getProportionateScreenWidth(270),
                              color: kPrimaryLightColor,
                              child: Center(
                                child: QrImage(
                                  data: "${transaction.serials}",
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
                        data: "${transaction.serials}",
                        backgroundColor: kPrimaryLightColor,
                        version: QrVersions.auto,
                        size: getProportionateScreenWidth(100),
                      ),
                    ),
                  if (transaction.alias != "membership") const Gap(20),
                  if (transaction.alias != "membership")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallButtons(
                          icon: "assets/icons/Save2.svg",
                          color: kPrimaryColor,
                          press: () async {
                            final image = await screenshotController.capture();
                            if (image == null) return;
                            profileController.saveImage(image);
                          },
                        ),
                      ],
                    ),
                  if (transaction.alias == "membership") const Gap(20),
                  if (transaction.alias == "membership")
                    SeconderyButton2(
                      text: "View Memberships".tr,
                      press: () async {
                        profileController.getTransMemberships();
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












  // InkWell(
                  //   onTap: () async {
                  //     final image = await screenshotController.capture();
                  //     if (image == null) return;
                  //     profileController.saveImage(image);
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     height: getProportionateScreenHeight(50),
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: kPrimaryColor,
                  //         width: 1.0,
                  //       ),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(right: 15, left: 15),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           BodyText(
                  //             text: "Save your ticket".tr.toUpperCase(),
                  //             weight: FontWeight.bold,
                  //             color: kPrimaryColor,
                  //           ),
                  //           Spacer(),
                  //           SvgPicture.asset(
                  //             "assets/icons/save.svg",
                  //             width: getProportionateScreenWidth(25),
                  //             height: getProportionateScreenHeight(25),
                  //             color: kPrimaryColor,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),