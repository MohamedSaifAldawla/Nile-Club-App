import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Models/eventsTickets.dart';
import 'package:nile_club/Models/services.dart';
import '../../Controllers/services_controller.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';
import '../../theme.dart';

class EventBookingDetails extends StatelessWidget {
  const EventBookingDetails({Key? key, required this.event}) : super(key: key);
  final EventsTickets event;
  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();
    final Map<String, dynamic> _eventData = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details".tr),
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
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(25),
                    right: getProportionateScreenWidth(25),
                    bottom: getProportionateScreenWidth(30),
                    top: getProportionateScreenWidth(10)),
                child: Column(
                  children: [
                    const Gap(20),
                    SizedBox(
                      width: getProportionateScreenWidth(100),
                      height: getProportionateScreenWidth(100),
                      child: Hero(
                        tag: "services${event.id}",
                        child: CircleAvatar(
                          backgroundColor: kPrimaryLightColor,
                          backgroundImage: NetworkImage("${event.img}"),
                        ),
                      ),
                    ),
                    const Gap(10),
                    BodyText(
                        text: "${event.ticketType}".tr,
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
                          text: "${event.totalPrice} " "SDG".tr,
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
                          text: "${event.ticketType}",
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const Gap(15),
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
                            text: '''${event.note}''',
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
                          text: "${event.totalPrice} " "SDG",
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
                        _eventData['tt_id'] = event.id;
                        _eventData['tk_qty'] = "1";
                        _eventData['event_id'] = event.eventId;
                        servicesController.Servicebooking(
                            servicedata: _eventData);
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