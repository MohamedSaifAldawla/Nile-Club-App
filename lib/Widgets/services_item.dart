import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../size_config.dart';
import '../theme.dart';
import 'intro.dart';

class ServicesItem extends StatelessWidget {
  ServicesItem({
    required this.icon,
    required this.containercolor,
    required this.iconcolor,
    required this.service,
    this.onTap,
    Key? key,
  }) : super(key: key);
  String icon;
  Color containercolor;
  Color iconcolor;
  String service;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: getProportionateScreenWidth(70),
                height: getProportionateScreenWidth(70),
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
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: containercolor,
                            borderRadius: BorderRadius.circular(25)),
                        child: SvgPicture.asset(
                          icon,
                          color: iconcolor,
                          width: getProportionateScreenWidth(25),
                          height: getProportionateScreenWidth(25),
                        )),
                  ],
                ),
              ),
            ),
            const Gap(5),
            BodyText(
              text: service,
            ),
            const Gap(5),
          ],
        ),
      ],
    );
  }
}

class ServicesItem2 extends StatelessWidget {
  ServicesItem2({
    required this.icon,
    required this.containercolor,
    required this.iconcolor,
    required this.service,
    this.onTap,
    Key? key,
  }) : super(key: key);
  String icon;
  Color containercolor;
  Color iconcolor;
  String service;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: getProportionateScreenWidth(90),
              height: getProportionateScreenHeight(90),
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [boxShadow],
              ),
              child: InkWell(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: containercolor,
                            borderRadius: BorderRadius.circular(25)),
                        child: SvgPicture.asset(
                          icon,
                          color: iconcolor,
                          width: 35,
                          height: 35,
                        )),
                  ],
                ),
              ),
            ),
            const Gap(5),
            BodyText(
              text: service,
            ),
            const Gap(5),
          ],
        ),
      ],
    );
  }
}
