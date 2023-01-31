import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/Models/eventsCinema.dart';
import 'package:nile_club/Widgets/intro.dart';
import 'package:nile_club/size_config.dart';
import 'package:nile_club/theme.dart';

import '../../Animations/FadeAnimation.dart';
import '../../Controllers/services_controller.dart';
import '../../Widgets/loader.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServicesController eventsCinemaController = Get.find<ServicesController>();

    final lang = GetStorage().read("lang");

    return Scaffold(
      appBar: AppBar(
        title: Text("${eventsCinemaController.screenTitle}".tr),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
        child: eventsCinemaController.eventsCinema.isEmpty == true
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/icons/notFound.json',
                      width: 350,
                      height: 350,
                      fit: BoxFit.fill,
                    ),
                    BodyText(
                      text: "no Events yet".tr,
                      weight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        top: getProportionateScreenWidth(20),
                        bottom: getProportionateScreenWidth(50),
                      ),
                      physics: BouncingScrollPhysics(),
                      itemCount: eventsCinemaController.eventsCinema.length,
                      itemBuilder: (context, index) => FadeAnimation(
                        1,
                        EventsCard(context, lang,
                            eventsCinemaController.eventsCinema[index]),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget EventsCard(
    BuildContext context, String lang, EventsCinema eventsCinema) {
  ServicesController servicesController = Get.find<ServicesController>();
  return GestureDetector(
    onTap: () {
      servicesController.EventBooking(
          eventID: "${eventsCinema.id}", eventsCinema: eventsCinema);
    },
    child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Container(
        padding: EdgeInsets.only(bottom: getProportionateScreenWidth(20)),
        width: double.infinity,
        //height: lang == "ar" ? 460 : 450,
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
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(150),
                  child: Loader(),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Hero(
                    tag: 'event' + eventsCinema.id.toString(),
                    child: Image.network(
                      "${eventsCinema.img}",
                      width: double.infinity,
                      //height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(15),
                  right: getProportionateScreenWidth(15)),
              child: BodyText(
                text: "${eventsCinema.title}",
                weight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(17),
                maxLines: 2,
              ),
            ),
            const Gap(5),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/Schedule.svg",
                    color: yellow,
                    width: getProportionateScreenWidth(30),
                    height: getProportionateScreenWidth(30),
                  ),
                  const Gap(10),
                  BodyText(
                    text: Jiffy(eventsCinema.startTime)
                        .format('MMM do yyyy, h:mm:ss a'),
                    fontSize: getProportionateScreenWidth(15),
                  )
                ],
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(15),
                  right: getProportionateScreenWidth(15)),
              child: Row(
                children: [
                  BodyText(
                    text: "See more details".tr,
                    textAlign: TextAlign.start,
                    fontSize: getProportionateScreenWidth(15),
                    color: yellow,
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    lang == "ar"
                        ? "assets/icons/Back.svg"
                        : "assets/icons/arrow_right.svg",
                    width: getProportionateScreenWidth(13),
                    height: getProportionateScreenWidth(13),
                    color: yellow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
