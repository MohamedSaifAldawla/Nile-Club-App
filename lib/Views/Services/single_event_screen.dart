import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nile_club/Models/eventsCinema.dart';
import 'package:nile_club/Views/Services/event_booking_details.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Controllers/services_controller.dart';
import '../../Models/eventsTickets.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../size_config.dart';
import '../../theme.dart';

class SingleEventScreen extends StatelessWidget {
  SingleEventScreen({Key? key, required this.eventsCinema}) : super(key: key);

  final servicesController = Get.find<ServicesController>();
  final EventsCinema eventsCinema;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(horizontalPadding),
              vertical: getProportionateScreenWidth(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Loader(),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: 'event' + eventsCinema.id.toString(),
                      child: Image.network(
                        '${eventsCinema.img}',
                        width: double.infinity,
                        //height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(10),
                    right: getProportionateScreenWidth(10)),
                child: FadeAnimation(
                  1,
                  BodyText(
                    text: '${eventsCinema.title}',
                    fontSize: getProportionateScreenWidth(18),
                    weight: FontWeight.w500,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
              ),
              const Gap(20),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Calendar.svg",
                      color: yellow,
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(30),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        BodyText(
                          text: "Start Date".tr,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const Gap(5),
                    BodyText(
                      text: Jiffy('${eventsCinema.startTime}')
                          .format('MMM do yyyy, h:mm a'),
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenWidth(13),
                    )
                  ],
                ),
              ),
              const Gap(5),
              FadeAnimation(
                1.3,
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Door.svg",
                      color: yellow,
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(30),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        BodyText(
                          text: "Entrance".tr,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const Gap(5),
                    BodyText(
                      text: Jiffy('${eventsCinema.startTime}')
                          .format('MMM do yyyy, h:mm a'),
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenWidth(13),
                    )
                  ],
                ),
              ),
              const Gap(20),
              FadeAnimation(
                1.4,
                Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(10),
                      right: getProportionateScreenWidth(10)),
                  child: BodyText(
                    text: "Event Details".tr,
                    weight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(18),
                  ),
                ),
              ),
              const Gap(10),
              FadeAnimation(
                1.5,
                Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(10),
                      right: getProportionateScreenWidth(10)),
                  child: NormalBodyText(
                    text: '${eventsCinema.details}',
                    fontSize: getProportionateScreenWidth(15),
                    color: kSecondaryColor,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Gap(25),
              FadeAnimation(
                1.6,
                Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(10),
                      right: getProportionateScreenWidth(10)),
                  child: BodyText(
                    text: "Available Tickets".tr,
                    weight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(18),
                  ),
                ),
              ),
              //const Gap(25),
              FadeAnimation(
                1.7,
                GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(5),
                      vertical: getProportionateScreenWidth(20)),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: servicesController.eventsTickets.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return EventsItem(servicesController.eventsTickets[index],
                        servicesController, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget EventsItem(EventsTickets eventsTickets, servicesController, context) {
  return GestureDetector(
    onTap: () {
      servicesController.initVar();
      Get.to(() => EventBookingDetails(event: eventsTickets));
    },
    child: Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenWidth(100),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Loader(),
                ),
                Center(
                  child: SizedBox(
                    width: getProportionateScreenWidth(100),
                    height: getProportionateScreenWidth(100),
                    child: Hero(
                      tag: "Ticket${eventsTickets.id}",
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage("${eventsTickets.img}"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          BodyText(
            text: "${eventsTickets.ticketType}",
          ),
        ],
      ),
    ),
  );
}
