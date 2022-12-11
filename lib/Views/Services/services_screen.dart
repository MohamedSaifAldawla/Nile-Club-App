import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Models/services.dart';
import 'package:nile_club/Views/Services/service_details.dart';
import '../../../Controllers/services_controller.dart';
import '../../../Widgets/intro.dart';
import '../../../size_config.dart';
import '../../../theme.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Widgets/loader.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesController = Get.find<ServicesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Comercial Services".tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(horizontalPadding)),
        child: GridView.builder(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenWidth(30)),
          physics: BouncingScrollPhysics(),
          itemCount: servicesController.services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: getProportionateScreenWidth(20),
            mainAxisSpacing: getProportionateScreenWidth(20),
          ),
          itemBuilder: (context, index) {
            return FadeAnimation(
              1,
              ServiceItem(servicesController.services[index],
                  servicesController, context),
            );
          },
        ),
      ),
    );
  }
}

Widget ServiceItem(Services services, servicesController, context) {
  return GestureDetector(
    onTap: () {
      servicesController.initVar();
      Get.to(() => ServiceDetails(services: services));
    },
    child: Container(
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
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenWidth(100),
            child: Center(
              child: Hero(
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
            ),
          ),
          const Gap(10),
          BodyText(
            text: "${services.ticketType}",
          ),
        ],
      ),
    ),
  );
}
