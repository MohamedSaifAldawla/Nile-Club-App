import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/theme.dart';

import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';

class StateScreen extends StatelessWidget {
  StateScreen({
    Key? key,
    required this.state,
    required this.text,
    required this.btntext,
  }) : super(key: key);
  final String state;
  final String text;
  final String btntext;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                const Gap(40),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(40),
                    width: getProportionateScreenWidth(200),
                    height: getProportionateScreenHeight(220),
                    decoration: BoxDecoration(
                        color: state == "success"
                            ? Color.fromARGB(20, 64, 199, 165)
                            : Color.fromARGB(20, 232, 76, 92),
                        borderRadius: BorderRadius.circular(100)),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          color: state == "success" ? success : error,
                          borderRadius: BorderRadius.circular(100)),
                      child: SvgPicture.asset(
                        state == "success"
                            ? "assets/icons/Success.svg"
                            : "assets/icons/Error.svg",
                        width: getProportionateScreenWidth(50),
                        height: getProportionateScreenHeight(50),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Gap(40),
                ScreenTitle(
                    text: state == "success" ? "Successfull".tr : "Error".tr),
                const Gap(20),
                BodyText(
                  text: text,
                  maxLines: 2,
                ),
                const Gap(100),
                PrimaryButton(
                  text: btntext,
                  press: () {
                    Get.offNamed('homepage');
                  },
                  gradient: state == "success"
                      ? kSuccessGradientColor
                      : kErrorGradientColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
