import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/theme.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Globals/globals.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import 'membershib_qr_scanner.dart';

class Activate extends StatefulWidget {
  Activate({Key? key}) : super(key: key);

  @override
  State<Activate> createState() => _ActivateState();
}

class _ActivateState extends State<Activate> {
  final formKey = GlobalKey<FormState>();
  final _serial = TextEditingController();
  String? serial;
  List<String> errors = [];
  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Membership Activation".tr,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(20),
                    FadeAnimation(
                      1,
                      BodyText(
                        text: "Tap on the QR".tr,
                        color: kSecondaryColor,
                      ),
                    ),
                    const Gap(10),
                    FadeAnimation(
                      1.2,
                      BodyText(
                        text: "Please align QR".tr,
                        color: kSecondaryColor,
                      ),
                    ),
                    FadeAnimation(
                      1.3,
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => MembershipQR(),
                          //   ),
                          // );
                        },
                        child: Lottie.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? 'assets/icons/QrLight.json'
                              : 'assets/icons/QrDark.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      BodyText(text: "---- OR ----".tr),
                    ),
                    const Gap(20),
                    FadeAnimation(
                      1.5,
                      ScreenTitle(
                        text: "Enter serial number".tr,
                      ),
                    ),
                    const Gap(30),
                    FadeAnimation(
                      1.6,
                      InputField(
                        controller: _serial,
                        label: "Serial".tr,
                        hint: "Ex:2".tr,
                        type: "Serial",
                        icon: "assets/icons/QRCode.svg",
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) => serial = newValue,
                        onChanged: (value) {
                          if (value == null || value.isNotEmpty) {
                            removeError(error: "Please Enter serial".tr);
                          }
                          if (value == null || value.isEmpty) {
                            addError(error: "Please Enter serial".tr);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            addError(error: "Please Enter serial".tr);
                            return "";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(30),
                    FadeAnimation(
                      1.8,
                      PrimaryButton(
                        text: "Activate".tr,
                        press: () {
                          if (formKey.currentState!.validate()) {
                            //_serial.text = "202352448351";
                            // profileController.Activate(serial: _serial.text);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


















 // const Gap(25),
                  // FadeAnimation(
                  //   1.7,
                  //   InputField(
                  //     label: "Phone".tr,
                  //     hint: phone,
                  //     type: "Phone",
                  //     icon: "assets/icons/Phone.svg",
                  //     obscureText: false,
                  //     enabled: true,
                  //   ),
                  // ),