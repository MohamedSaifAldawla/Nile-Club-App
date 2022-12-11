import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/theme.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';

class FingerAuthScreen extends StatefulWidget {
  const FingerAuthScreen({Key? key}) : super(key: key);

  @override
  State<FingerAuthScreen> createState() => _FingerAuthScreenState();
}

class _FingerAuthScreenState extends State<FingerAuthScreen> {
  @override
  void initState() {
    AuthInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Finger Authorization".tr,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeAnimation(
                    1.1,
                    Lottie.asset(
                      'assets/icons/Fingerprint.json',
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.fill,
                    ),
                  ),
                  FadeAnimation(
                    1,
                    BodyText(
                      text: "Please use finger".tr,
                      color: kSecondaryColor,
                      fontSize: 16,
                      maxLines: 2,
                    ),
                  ),
                  const Gap(30),
                  FadeAnimation(
                    1.2,
                    PrimaryButton(
                      text: "Authenticate".tr,
                      press: () {
                        AuthInit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AuthInit() async {
    final isAuthenticated = await local_auth.authenticate();
    if (isAuthenticated) {
      local_auth.autoLogin = true;
      Get.offAllNamed("login");
    }
  }
}
