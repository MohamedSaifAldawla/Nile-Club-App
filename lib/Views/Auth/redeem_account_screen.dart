import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Widgets/primary_button.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Controllers/auth_controller.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../size_config.dart';
import '../../theme.dart';

class RedeemAccountScreen extends StatefulWidget {
  const RedeemAccountScreen({Key? key}) : super(key: key);

  @override
  State<RedeemAccountScreen> createState() => _RedeemAccountState();
}

class _RedeemAccountState extends State<RedeemAccountScreen> {
  final authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String? phone;

  Map<String, dynamic> _resetData = {};
  final List<String> errors = [];

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
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem account".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: 100),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FadeAnimation2(
                  1,
                  ScreenTitle(text: "Redeem Account".tr),
                ),
                const Gap(10),
                FadeAnimation2(
                  1.1,
                  BodyText(text: "Reset Pass Body".tr),
                ),
                const Gap(40),
                FadeAnimation2(
                  1.2,
                  InputField(
                    controller: _phoneController,
                    label: "Phone".tr,
                    hint: "Enter your Phone".tr,
                    type: "Phone",
                    icon: "assets/icons/Phone.svg",
                    obscureText: false,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => phone = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter your Phone".tr);
                      }
                      if (value!.length >= 10) {
                        removeError(error: "Phone number is too short".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Phone".tr);
                      }

                      if (value.length < 10) {
                        addError(error: "Phone number is too short".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter your Phone".tr);
                        return "";
                      } else if (value.length < 10) {
                        addError(error: "Phone number is too short".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(30),
                FormError(errors: errors),
                const Gap(20),
                FadeAnimation2(
                  1.3,
                  PrimaryButton(
                    text: "Continue".tr,
                    press: () {
                      //Get.toNamed("otp");
                      if (_formKey.currentState!.validate()) {
                        _resetData['phone'] = _phoneController.text;
                        authController.RedeemAccount(resetData: _resetData);
                      }
                    },
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
