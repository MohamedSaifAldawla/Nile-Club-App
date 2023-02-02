import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:nile_club/Views/Home/single_news_screen.dart';
import 'package:nile_club/Widgets/offers_card.dart';
import 'package:nile_club/size_config.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Globals/globals.dart';
import '../../Widgets/loader.dart';
import '../../Widgets/news_card.dart';
import '../../Widgets/sections.title.dart';
import '../../Widgets/services_item.dart';
import '../../Widgets/wallet.dart';
import '../../theme.dart';
import '../Services/service_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = GetStorage().read("lang");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home".tr),
      ),
      body: Obx(
        () => LiquidPullToRefresh(
          onRefresh: handleRefresh,
          color: Theme.of(context).brightness == Brightness.light
              ? kPrimaryLightColor
              : kPrimaryDarkColor,
          backgroundColor: yellow,
          animSpeedFactor: 2,
          height: 300,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Gap(12),
                FadeAnimation2(
                  1,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16)),
                    child: Wallet(),
                  ),
                ),
                const Gap(30),
                if (servicesController.offers.isEmpty == false)
                  FadeAnimation2(
                    1.2,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(16)),
                      child: SectionsTitle(
                        title: "Latest offers".tr,
                        title2: "",
                        onTap: () {},
                      ),
                    ),
                  ),
                if (servicesController.offers.isEmpty == false)
                  FadeAnimation2(
                    1.3,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: lang == "ar"
                                ? EdgeInsets.only(
                                    right: getProportionateScreenWidth(16))
                                : EdgeInsets.only(
                                    left: getProportionateScreenWidth(16)),
                            height: lang == "ar"
                                ? getProportionateScreenWidth(200)
                                : getProportionateScreenWidth(180),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(25)),
                              physics: BouncingScrollPhysics(),
                              itemCount: servicesController.offers.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => Get.to(
                                  () => ServiceDetails(
                                      services:
                                          servicesController.offers[index]),
                                ),
                                child: OffersCard(
                                  discount:
                                      '${servicesController.offers[index].discountPrice}',
                                  newPrice:
                                      '${servicesController.offers[index].totalPrice}',
                                  body:
                                      '${servicesController.offers[index].note}',
                                ),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Gap(5),
                FadeAnimation(
                  1.4,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16)),
                    child: SectionsTitle(
                      title: "Services".tr,
                      title2: ''.tr,
                    ),
                  ),
                ),
                const Gap(20),
                FadeAnimation(
                  1.5,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ServicesItem(
                          icon: "assets/icons/Swim.svg",
                          containercolor: Color.fromARGB(20, 3, 168, 245),
                          iconcolor: Color(0xff03A9F5),
                          service: "Services".tr,
                          onTap: () {
                            servicesController.getServices();
                          },
                        ),
                        ServicesItem(
                          icon: "assets/icons/Cinema.svg",
                          containercolor: Color.fromARGB(30, 46, 204, 113),
                          iconcolor: Color(0xff2ECC71),
                          service: "Cinema".tr,
                          onTap: () {
                            servicesController.getCinema();
                          },
                        ),
                        ServicesItem(
                          icon: "assets/icons/Advertising.svg",
                          containercolor: Color.fromARGB(30, 251, 189, 92),
                          iconcolor: Color(0xffFBBD5C),
                          service: "Offers".tr,
                          onTap: () {
                            servicesController.getOffers();
                          },
                        ),
                        ServicesItem(
                          icon: "assets/icons/Schedule.svg",
                          containercolor: Color.fromARGB(20, 234, 30, 99),
                          iconcolor: Color(0xffEA1E63),
                          service: "Events".tr,
                          onTap: () {
                            servicesController.getEvents();
                            //Get.toNamed("events");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(30),
                FadeAnimation(
                  1.5,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16)),
                    child: SectionsTitle(
                      title: "News feed".tr,
                      title2: "See all".tr,
                      onTap: () {
                        Get.toNamed("news");
                      },
                    ),
                  ),
                ),
                blogsController.isLoading.value
                    ? Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Loader(),
                      )
                    : FadeAnimation(
                        1.6,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: lang == "ar"
                                    ? EdgeInsets.only(
                                        right: getProportionateScreenWidth(16))
                                    : EdgeInsets.only(
                                        left: getProportionateScreenWidth(16)),
                                height: lang == "ar"
                                    ? getProportionateScreenWidth(430)
                                    : getProportionateScreenWidth(400),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenWidth(25),
                                  ),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      Get.to(() => SingleNewsScreen(
                                          blog: blogsController.blogs[index]));
                                    },
                                    child: NewsCard2(
                                      title:
                                          "${blogsController.blogs[index].title}",
                                      body:
                                          "${blogsController.blogs[index].content}",
                                      image:
                                          "${blogsController.blogs[index].image}",
                                      date:
                                          "${blogsController.blogs[index].date}",
                                      index:
                                          "${blogsController.blogs[index].id}",
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleRefresh() async {
    init();
    walletController.Balance();
    //transController.GetHistory();
    blogsController.getBlogs();
    return await Future.delayed(Duration(seconds: 3));
  }
}
