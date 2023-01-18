import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Animations/FadeAnimation.dart';
import '../../Globals/globals.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../size_config.dart';
import '../../theme.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _thirdController = TextEditingController();
  final _fourthController = TextEditingController();
  String otpCode = "";
  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
          child: Form(
            child: Column(
              children: [
                Lottie.asset(
                  'assets/icons/otp.json',
                  width: 250,
                  height: 250,
                  fit: BoxFit.fill,
                ),
                FadeAnimation2(
                  1,
                  ScreenTitle(text: "Verification code".tr),
                ),
                const Gap(10),
                FadeAnimation2(
                  1.1,
                  BodyText(
                    text: "Verification body".tr,
                    maxLines: 2,
                  ),
                ),
                const Gap(50),
                FadeAnimation(
                  1.2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(60),
                        child: TextFormField(
                          controller: _firstController,
                          autofocus: true,
                          focusNode: pin1FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin2FocusNode);
                          },
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(60),
                        child: TextFormField(
                            controller: _secondController,
                            focusNode: pin2FocusNode,
                            obscureText: true,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                pin1FocusNode!.previousFocus();
                              }
                              nextField(value, pin3FocusNode);
                            }),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(60),
                        child: TextFormField(
                            controller: _thirdController,
                            focusNode: pin3FocusNode,
                            obscureText: true,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                pin2FocusNode!.previousFocus();
                              }
                              nextField(value, pin4FocusNode);
                            }),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(60),
                        child: TextFormField(
                          controller: _fourthController,
                          focusNode: pin4FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 24),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              pin3FocusNode!.previousFocus();
                            }
                            if (value.length == 1) {
                              pin4FocusNode!.unfocus();
                              otpCode = _firstController.text +
                                  _secondController.text +
                                  _thirdController.text +
                                  _fourthController.text;
                              authController.Verification(otpCode: otpCode);
                              _firstController.text = "";
                              _secondController.text = "";
                              _thirdController.text = "";
                              _fourthController.text = "";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
