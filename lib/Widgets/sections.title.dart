import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../size_config.dart';
import '../theme.dart';
import 'intro.dart';

class SectionsTitle extends StatelessWidget {
  SectionsTitle({
    Key? key,
    required this.title,
    required this.title2,
    this.onTap,
  }) : super(key: key);
  String title;
  String title2;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          BodyText(
            text: title,
            weight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(16),
          ),
          Spacer(),
          InkWell(
            onTap: onTap,
            child: BodyText(
              text: title2 == null ? '' : title2,
              fontSize: getProportionateScreenWidth(13),
              color: Theme.of(context).brightness == Brightness.light
                  ? kTextColor
                  : kPrimaryLightColor,
            ),
          ),
        ],
      ),
    );
  }
}

class IconSectionsTitle extends StatelessWidget {
  IconSectionsTitle({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  String title;
  String icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Row(
        children: [
          BodyText(
            text: title,
            weight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(16),
          ),
          Spacer(),
          SvgPicture.asset(
            icon,
            color: Theme.of(context).brightness == Brightness.light
                ? kTextColor
                : kPrimaryLightColor,
            width: getProportionateScreenWidth(20),
            height: getProportionateScreenWidth(20),
          ),
        ],
      ),
    );
  }
}
