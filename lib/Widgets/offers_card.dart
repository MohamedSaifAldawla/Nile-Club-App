import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/Widgets/intro.dart';
import '../size_config.dart';
import '../theme.dart';

class OffersCard extends StatelessWidget {
  OffersCard({
    Key? key,
    required this.newPrice,
    required this.body,
    required this.title,
    required this.img,
    required this.discount,
    this.width,
    this.height,
  }) : super(key: key);
  String newPrice;
  String discount;
  String body, title, img;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    final lang = GetStorage().read("lang");
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(17),
            right: getProportionateScreenWidth(15),
            top: getProportionateScreenWidth(15)),
        width: width ?? getProportionateScreenWidth(290),
        height: height ?? 0,
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
                blurRadius: 20.0,
                offset: Offset(0, 8),
                blurStyle: BlurStyle.normal,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SvgPicture.asset(
                //   "assets/icons/Discount.svg",
                //   width: getProportionateScreenWidth(40),
                //   height: getProportionateScreenWidth(40),
                //   color: yellow,
                // ),
                Image.network(
                  img,
                  width: getProportionateScreenWidth(40),
                  height: getProportionateScreenWidth(40),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(
                      text: title,
                      fontSize: getProportionateScreenWidth(15),
                      weight: FontWeight.bold,
                    ),
                    const Gap(3),
                    BodyText(
                      text: discount + "  " + newPrice + "SDG".tr,
                      fontSize: getProportionateScreenWidth(14),
                      color: kSecondaryColor,
                    ),
                  ],
                ),
              ],
            ),
            Gap(10),
            Divider(
              color: kSecondaryColor,
              thickness: 0.1,
            ),
            BodyText(
              text: body,
              fontSize: getProportionateScreenWidth(13),
              color: kSecondaryColor,
              textAlign: TextAlign.left,
              maxLines: 2,
            ),
            // Expanded(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       SvgPicture.asset(
            //         lang == "ar"
            //             ? "assets/icons/Back.svg"
            //             : "assets/icons/arrow_right.svg",
            //         width: getProportionateScreenWidth(13),
            //         height: getProportionateScreenHeight(13),
            //         color: kSecondaryColor,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
