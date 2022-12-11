import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import '../../Globals/globals.dart';
import '../../Services/api.dart';
import '../../size_config.dart';
import '../../theme.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashtime = 3;
  @override
  void initState() {
    Applive();
    // Future.delayed(
    //   Duration(seconds: splashtime),
    //   () async {
    //     Get.offAllNamed("intro");
    //   },
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/Intro2.jpg", fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF15141F).withOpacity(0.1),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(30),
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenWidth(200),
                    ),
                  ),
                  Lottie.asset(
                    'assets/icons/loading2.json',
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> Applive() async {
  try {
    final response = await Api.AppLive();
    final res = json.decode(response.data);
    print("Applive :$res");
    if (res['statuscode'] == 0) {
      await GetStorage().write("whatsapp", res['whatsapp']);
      await GetStorage().write("messenger", res['messenger']);
      await GetStorage().write("call", res['call']);
      await GetStorage().write("Live", true);
      await init();
      print("isLive : $isLive");
      Get.offAllNamed("intro");
    }
    if (res['statuscode'] == 3) {
      await GetStorage().write("Live", false);
      await init();
      print("isLive : $isLive");
      Get.offAllNamed("intro");
    }
  } catch (e) {
    print(e);
    await GetStorage().write("Live", null);
    await init();
    print("isLive : $isLive");
    Get.offAllNamed("intro");
  }
}

@override
State<StatefulWidget> createState() {
  throw UnimplementedError();
}
