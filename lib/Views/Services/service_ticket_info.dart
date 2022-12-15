import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../Controllers/services_controller.dart';
import '../../Globals/globals.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../Widgets/primary_button.dart';
import '../../Widgets/social_item.dart';
import '../../Widgets/ticket_card.dart';
import '../../size_config.dart';
import '../../theme.dart';

class ServiceTicketInfo extends StatelessWidget {
  ServiceTicketInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();

    ScreenshotController screenshotController = ScreenshotController();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 20),
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? kPrimaryLightColor
                            : kPrimaryDark3Color,
                        image: DecorationImage(
                            image:
                                Theme.of(context).brightness == Brightness.light
                                    ? AssetImage("assets/images/ticket2.png")
                                    : AssetImage("assets/images/ticket.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? shadow
                                    : shadow2,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, left: 25, right: 25, bottom: 30),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "${servicesController.serviceReserve['output_ticket_img']}",
                            placeholder: (context, url) => Loader(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: 60,
                            ),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const Gap(10),
                          BodyText(
                            text: "successfully booked".tr,
                            // fontSize: 18,
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
                          const Gap(20),
                          Row(
                            children: [
                              BodyText(
                                text: "Transaction id".tr,
                                weight: FontWeight.w500,
                              ),
                              Spacer(),
                              BodyText(
                                text:
                                    "${servicesController.serviceReserve['trans_id']}",
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              BodyText(
                                text: "Ticket organizer".tr,
                                weight: FontWeight.w500,
                              ),
                              Spacer(),
                              BodyText(
                                text:
                                    "${servicesController.serviceReserve['output_ticket_organizer']}",
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              BodyText(
                                text: "Ticket type".tr,
                                weight: FontWeight.w500,
                              ),
                              Spacer(),
                              BodyText(
                                text:
                                    "${servicesController.serviceReserve['output_ticket_ticket_Type']}",
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              BodyText(
                                text: "Ticket quantity".tr,
                                weight: FontWeight.w500,
                              ),
                              Spacer(),
                              BodyText(
                                text:
                                    "${servicesController.serviceReserve['output_ticket_t_qty']}",
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
                                text:
                                    "${servicesController.serviceReserve['output_date']}",
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Gap(10),
                          Divider(
                            color: kSecondaryColor,
                            thickness: 0.1,
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              BodyText(
                                text: "Remaning Balance".tr,
                                weight: FontWeight.bold,
                              ),
                              Spacer(),
                              BodyText(
                                text:
                                    "${servicesController.serviceReserve['output_available_balance']} "
                                            "SDG"
                                        .tr,
                                weight: FontWeight.bold,
                                fontSize: 18,
                                color: success,
                              ),
                            ],
                          ),
                          const Gap(20),
                          QrImage(
                            data:
                                "${servicesController.serviceReserve['output_ticket_serial']}",
                            backgroundColor: kPrimaryLightColor,
                            version: QrVersions.auto,
                            size: 100,
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallButtons(
                                icon: "assets/icons/Save2.svg",
                                color: kPrimaryColor,
                                press: () async {
                                  final image =
                                      await screenshotController.capture();
                                  if (image == null) return;
                                  profileController.saveImage(image);
                                },
                              ),
                              SmallButtons(
                                icon: "assets/icons/Home.svg",
                                color: kPrimaryColor,
                                press: () {
                                  Get.offAllNamed('homepage');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 10),
  //       child: TicketCard(),
  //     ),
  //   );
  // }
}



                          // InkWell(
                          //   onTap: () async {
                          //     final image =
                          //         await screenshotController.capture();
                          //     //print(image);
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
                          //       padding:
                          //           const EdgeInsets.only(right: 15, left: 15),
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
                          // const Gap(15),
                          // PrimaryButton(
                          //   text: "homepage".tr,
                          //   press: () {
                          //     Get.offAllNamed('homepage');
                          //   },
                          // ),