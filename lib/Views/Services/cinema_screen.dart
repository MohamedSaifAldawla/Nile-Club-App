import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/Widgets/intro.dart';
import 'package:nile_club/size_config.dart';
import 'package:nile_club/theme.dart';
import '../../Controllers/services_controller.dart';
import '../../Widgets/loader.dart';
import 'service_details.dart';

class CinemaScreen extends StatelessWidget {
  const CinemaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServicesController servicesController = Get.put(ServicesController());
    final lang = GetStorage().read("lang");

    return Scaffold(
      appBar: AppBar(
        title: Text("Cinema".tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: servicesController.services.isEmpty == true
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
                      text: "no Movies yet".tr,
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
                        top: 30,
                      ),
                      physics: BouncingScrollPhysics(),
                      itemCount: servicesController.services.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15),
                          width: double.infinity,
                          //height: lang == "ar" ? 460 : 450,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? kPrimaryLightColor
                                    : kPrimaryDark3Color,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
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
                              Center(
                                child: Loader(),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero,
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Hero(
                                  tag:
                                      "services${servicesController.services[index].id}",
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${servicesController.services[index].img}",
                                    placeholder: (context, url) => Container(
                                      width: double.infinity,
                                      height: getProportionateScreenHeight(450),
                                      color: Colors.amber,
                                      child: Loader(),
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 60,
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: double.infinity,
                                      //height: getProportionateScreenHeight(300),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: BodyText(
                                  text: "Movie Name",
                                  weight: FontWeight.bold,
                                  fontSize: 17,
                                  maxLines: 2,
                                ),
                              ),
                              const Gap(5),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/Schedule.svg",
                                      color: yellow,
                                      width: getProportionateScreenWidth(30),
                                      height: getProportionateScreenHeight(30),
                                    ),
                                    Gap(10),
                                    BodyText(
                                      text: "3-5-2022",
                                      fontSize: 15,
                                    )
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: GestureDetector(
                                  onTap: () => Get.to(
                                    () => ServiceDetails(
                                        services:
                                            servicesController.services[index]),
                                  ),
                                  child: Row(
                                    children: [
                                      BodyText(
                                        text: "See more details",
                                        textAlign: TextAlign.start,
                                        fontSize: 15,
                                        color: yellow,
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                        lang == "ar"
                                            ? "assets/icons/Back.svg"
                                            : "assets/icons/arrow_right.svg",
                                        width: getProportionateScreenWidth(13),
                                        height:
                                            getProportionateScreenHeight(13),
                                        color: yellow,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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


                                      // Image.network(
                                      //   "${servicesController.services[index].img}",
                                      //   width: double.infinity,
                                      //   //height: 250,
                                      //   fit: BoxFit.cover,
                                      // ),
