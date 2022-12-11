import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nile_club/size_config.dart';
import 'package:nile_club/theme.dart';

import 'intro.dart';

class ProfileCard extends StatelessWidget {
  String firstIcon;
  String title;
  Color color;
  void Function()? onTap;

  ProfileCard({
    Key? key,
    required this.firstIcon,
    required this.title,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = GetStorage().read("lang");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: getProportionateScreenWidth(60),
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
          ],
        ),
        child: Padding(
          //padding: const EdgeInsets.all(15),
          padding: lang == 'en'
              ? EdgeInsets.only(
                  top: getProportionateScreenWidth(12),
                  bottom: getProportionateScreenWidth(12),
                  left: getProportionateScreenWidth(15),
                  right: getProportionateScreenWidth(20))
              : EdgeInsets.only(
                  top: getProportionateScreenWidth(12),
                  bottom: getProportionateScreenWidth(12),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(15)),
          child: Row(
            children: [
              SvgPicture.asset(
                firstIcon,
                color: color,
                width: getProportionateScreenWidth(25),
                height: getProportionateScreenWidth(25),
              ),
              const Gap(20),
              BodyText(text: title),
              Spacer(),
              SvgPicture.asset(
                lang == "ar"
                    ? "assets/icons/Back.svg"
                    : "assets/icons/arrow_right.svg",
                width: getProportionateScreenWidth(15),
                height: getProportionateScreenWidth(15),
                color: Theme.of(context).brightness == Brightness.light
                    ? kSecondaryColor
                    : kPrimaryLightColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
