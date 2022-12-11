import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size_config.dart';
import '../theme.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function(),
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(9),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? kPrimaryLightColor
              : kPrimaryDarkColor,
          //color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? shadow
                  : shadow2,
              blurRadius: 20.0,
              offset: Offset(0, 8),
              blurStyle: BlurStyle.normal,
            )
          ],
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}

class SmallButtons extends StatelessWidget {
  const SmallButtons({
    Key? key,
    required this.icon,
    required this.press,
    this.color,
  }) : super(key: key);

  final String icon;
  final Function press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function(),
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(9)),
        height: getProportionateScreenWidth(45),
        width: getProportionateScreenWidth(45),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? kPrimaryLightColor
              : kPrimaryDarkColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? shadow
                  : shadow2,
              blurRadius: 20.0,
              offset: Offset(0, 8),
              blurStyle: BlurStyle.normal,
            )
          ],
        ),
        child: SvgPicture.asset(
          icon,
          color: color,
        ),
      ),
    );
  }
}
