import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/size_config.dart';
import '../../Controllers/services_controller.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/offers_card.dart';
import '../../theme.dart';
import 'service_details.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServicesController servicesController = Get.find<ServicesController>();
    final lang = GetStorage().read("lang");

    return Scaffold(
      appBar: AppBar(
        title: Text("Offers".tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: servicesController.offers.isEmpty == true
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
                      text: "no offers yet".tr,
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
                      padding: EdgeInsets.symmetric(vertical: 25),
                      physics: BouncingScrollPhysics(),
                      itemCount: servicesController.offers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Get.to(
                          () => ServiceDetails(
                              services: servicesController.offers[index]),
                        ),
                        child: OffersCard(
                          img: '${servicesController.offers[index].img}',
                          discount:
                              '${servicesController.offers[index].discountPrice}',
                          newPrice:
                              '${servicesController.offers[index].totalPrice}',
                          body: '${servicesController.offers[index].note}',
                          title:
                              '${servicesController.offers[index].ticket_type}',
                          subTitle: '${servicesController.offers[index].title}',
                          height: lang == "ar"
                              ? getProportionateScreenWidth(160)
                              : getProportionateScreenWidth(140),
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
