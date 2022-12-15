import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Models/services.dart';
import '../../Controllers/services_controller.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';
import '../../theme.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails({Key? key, required this.services}) : super(key: key);
  final Services services;
  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final Map<String, dynamic> _serviceData = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Service Details".tr),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(horizontalPadding)),
            child: Container(
              width: double.infinity,
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
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(25),
                    right: getProportionateScreenWidth(25),
                    bottom: getProportionateScreenWidth(30),
                    top: getProportionateScreenWidth(10)),
                child: Column(
                  children: [
                    const Gap(20),
                    Hero(
                      tag: "services${services.id}",
                      child: CachedNetworkImage(
                        imageUrl: "${services.img}",
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

                    const Gap(10),
                    BodyText(
                        text: "${services.ticketType}".tr,
                        fontSize: getProportionateScreenWidth(18),
                        weight: FontWeight.bold),
                    const Gap(30),
                    Row(
                      children: [
                        BodyText(
                          text: "Service price".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${services.totalPrice} " + "SDG".tr,
                          weight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(18),
                          color: success,
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
                          text: "${services.ticketType}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const Gap(10),
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
                            text: '''${services.note}''',
                            weight: FontWeight.bold,
                            textAlign: TextAlign.end,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
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
                          text: "Name".tr,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${GetStorage().read("name")}",
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
                          text: "${GetStorage().read("phone")}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    // const Gap(10),
                    // Row(
                    //   children: [
                    //     BodyText(
                    //       text: "No. of persons".tr,
                    //       weight: FontWeight.w500,
                    //     ),
                    //     Spacer(),
                    //     BodyText(
                    //       text: "1" + " person".tr,
                    //       weight: FontWeight.bold,
                    //     ),
                    //   ],
                    // ),
                    const Gap(20),
                    Divider(
                      color: kSecondaryColor,
                      thickness: 0.1,
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        BodyText(
                          text: "Total Price".tr,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                        BodyText(
                          text: "${services.totalPrice} " + "SDG".tr,
                          weight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(18),
                          color: success,
                        ),
                      ],
                    ),
                    const Gap(25),
                    PrimaryButton(
                      text: "Confirm booking".tr,
                      press: () {
                        _serviceData['tt_id'] = services.id;
                        _serviceData['tk_qty'] = "1";
                        _serviceData['event_id'] = services.eventId;
                        // _serviceData['tk_qty'] = servicesController.counter.value;
                        servicesController.Servicebooking(
                            servicedata: _serviceData);
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
}




















 // Row(
                  //   children: [
                  //     BodyText(
                  //       text: "No. of persons".tr,
                  //       weight: FontWeight.w500,
                  //     ),
                  //     Spacer(),
                  //     Row(
                  //       children: [
                  //         Obx(
                  //           () => BodyText(
                  //             text: "${servicesController.counter.value}",
                  //             weight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),



  // Row(
                  //   children: [
                  //     BodyText(
                  //       text: "Total Price".tr,
                  //       weight: FontWeight.bold,
                  //     ),
                  //     Spacer(),
                  //     Obx(() => BodyText(
                  //           text: "${servicesController.total.value} " "SDG",
                  //           weight: FontWeight.bold,
                  //           fontSize: 18,
                  //           color: success,
                  //         )),
                  //   ],
                  // ),



   // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         servicesController.decrement(services.totalPrice);
                  //       },
                  //       icon: Icon(
                  //         Icons.remove_circle_outline,
                  //         size: 20,
                  //       ),
                  //     ),
                  //     Obx(
                  //       () => BodyText(
                  //         text: "${servicesController.counter.value}" +
                  //             "person".tr,
                  //         weight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     // const Gap(20),
                  //     IconButton(
                  //       onPressed: () {
                  //         servicesController.increment(services.totalPrice);
                  //       },
                  //       icon: Icon(
                  //         Icons.add_circle_outline,
                  //         size: 20,
                  //       ),
                  //     ),
                  //   ],
                  // ),