import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Controllers/wallet_controller.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../Widgets/wallet.dart';
import '../../theme.dart';

class Transfer extends StatefulWidget {
  Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final walletController = Get.put(WalletController());
  final formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  String? amount;
  List<String> errors = [];
  final Map<String, dynamic> _createData = {};

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
        title: Text("Charge Wallet".tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(40),
                FadeAnimation2(
                  1,
                  Wallet(),
                ),
                //ScreenTitle(text: "Charge Wallet".tr),
                const Gap(80),
                FadeAnimation2(
                  1.1,
                  BodyText(
                    text: "Enter amount".tr,
                  ),
                ),
                const Gap(40),
                FadeAnimation2(
                  1.2,
                  InputField(
                    controller: _amount,
                    label: "Enter your Amount".tr,
                    hint: "Ex:".tr,
                    type: "Amount",
                    icon: "assets/icons/Money.svg",
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => amount = newValue,
                    onChanged: (value) {
                      if (value == null || value.isNotEmpty) {
                        removeError(error: "Please Enter amount".tr);
                      }
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter amount".tr);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError(error: "Please Enter amount".tr);
                        return "";
                      }
                      return null;
                    },
                  ),
                ),
                FormError(errors: errors),
                const Gap(40),
                FadeAnimation2(
                  1.3,
                  PrimaryButton(
                    text: "Continue".tr,
                    press: () {
                      if (formKey.currentState!.validate()) {
                        _createData.clear();
                        _createData['amount'] = _amount.text;
                        walletController.PayGateway(createData: _createData);
                        //print(_createData);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
