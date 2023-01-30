import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nile_club/Widgets/intro.dart';

import '../Globals/globals.dart';
import '../size_config.dart';
import '../theme.dart';
import 'loader.dart';

class NewsCard extends StatelessWidget {
  NewsCard({
    Key? key,
    required this.title,
    required this.image,
    required this.body,
    required this.date,
    this.width,
  }) : super(key: key);
  String title;
  String image;
  String body;
  String date;

  double? width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 13, right: 15, top: 10),
        width: width ?? getProportionateScreenWidth(300),
        // height: getProportionateScreenHeight(130),
        decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [boxShadow]),
        child: Column(
          children: [
            Row(
              children: [
                Stack(children: [
                  // Loader(),
                  Image.network(
                    image,
                    height: getProportionateScreenHeight(80),
                    width: getProportionateScreenWidth(80),
                  ),
                ]),
                const Gap(10),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(
                        text: title,
                        weight: FontWeight.w500,
                      ),
                      BodyText(
                        text: body,
                        fontSize: 13,
                        color: kSecondaryColor,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(5),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Calendar.svg",
                    width: getProportionateScreenWidth(20),
                    height: getProportionateScreenHeight(18),
                  ),
                  const Gap(5),
                  BodyText(
                    text: date == null ? '' : date,
                    fontSize: 12,
                    color: kSecondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCard2 extends StatelessWidget {
  NewsCard2({
    Key? key,
    required this.title,
    required this.image,
    required this.body,
    required this.date,
    required this.index,
    this.width,
  }) : super(key: key);
  String title;
  String image;
  String body;
  String date;
  String index;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      child: Container(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(13),
            right: getProportionateScreenWidth(15),
            top: getProportionateScreenWidth(15),
            bottom: getProportionateScreenWidth(15)),
        width: width ?? getProportionateScreenWidth(300),
        // height: getProportionateScreenHeight(130),
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
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(10)),
                child: Hero(
                  tag: 'news' + index.toString(),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: getProportionateScreenWidth(200),
                      child: Loader(),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 60,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      height: getProportionateScreenWidth(200),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            const Gap(20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(
                  text: title,
                  weight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(14),
                ),
                const Gap(5),
                BodyText(
                  text: body,
                  fontSize: getProportionateScreenWidth(13),
                  color: kSecondaryColor,
                  textAlign: lang == "en" ? TextAlign.left : TextAlign.right,
                  maxLines: 2,
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/icons/Calendar.svg",
                  width: getProportionateScreenWidth(20),
                  height: getProportionateScreenWidth(18),
                ),
                const Gap(5),
                BodyText(
                  text: date == null
                      ? ''
                      : Jiffy(date).format('MMM do yyyy, h:mm a'),
                  fontSize: getProportionateScreenWidth(12),
                  color: kSecondaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



  // Image.network(
                      //   image,
                      //   width: double.infinity,
                      //   height: getProportionateScreenHeight(200),
                      //   fit: BoxFit.fill,
                      // ),