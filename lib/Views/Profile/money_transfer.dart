import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/Views/Profile/trans_qr_scanner.dart';
import 'package:nile_club/theme.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Globals/globals.dart';
import '../../Widgets/form_error.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';

class MoneyTransferScreen extends StatefulWidget {
  MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _merchantID = TextEditingController();
  String? amount;
  String? merchantID;
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
          "Money Transfer".tr,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 40),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeAnimation(
                    1.1,
                    BodyText(
                      text: "Tap on the QR".tr,
                      color: kSecondaryColor,
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    GestureDetector(
                      onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TransferQR(),
                            ),
                          )),
                      child: Lottie.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? 'assets/icons/QrLight.json'
                            : 'assets/icons/QrDark.json',
                        width: 350,
                        height: 350,
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
                    Form(
                      key: formKey2,
                      child: InputField(
                        controller: _merchantID,
                        label: "Merchant ID".tr,
                        hint: "Enter merchant id".tr,
                        type: "Merchant",
                        icon: "assets/icons/Male.svg",
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) => merchantID = newValue,
                        onChanged: (value) {
                          if (value == null || value.isNotEmpty) {
                            removeError(error: "Please Enter merchant id".tr);
                          }
                          if (value == null || value.isEmpty) {
                            addError(error: "Please Enter merchant id".tr);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            addError(error: "Please Enter merchant id".tr);
                            return "";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  FormError(errors: errors),
                  const Gap(30),
                  FadeAnimation(
                    1.6,
                    PrimaryButton(
                      text: "Continue".tr,
                      press: () {
                        if (formKey2.currentState!.validate()) {
                          walletController.scannedQR = _merchantID.text;
                          walletController.GetShop().then(
                            (value) {
                              if (walletController.successShowDialog == true) {
                                print("true");
                                TransferDialog(context);
                              } else if (walletController.successShowDialog ==
                                  false) {
                                print("false");
                              }
                            },
                          );
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
    );
  }

  Future TransferDialog(context) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? kPrimaryLightColor
              : kPrimaryDarkColor,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              //height: 400,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/Cancel.svg",
                            color: error,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          FadeAnimation2(
                            1.1,
                            ScreenTitle(text: "Enter your Amount".tr),
                          ),
                          const Gap(25),
                          FadeAnimation2(
                            1.2,
                            InputField(
                              label: "Client Name".tr,
                              hint: walletController.clientName,
                              type: "Name",
                              icon: "assets/icons/User.svg",
                              obscureText: false,
                              enabled: true,
                            ),
                          ),
                          const Gap(20),
                          FadeAnimation2(
                            1.3,
                            InputField(
                              label: "Client Phone".tr,
                              hint: walletController.clientPhone,
                              type: "Phone",
                              icon: "assets/icons/Phone.svg",
                              obscureText: false,
                              enabled: true,
                            ),
                          ),
                          const Gap(20),
                          FadeAnimation2(
                            1.4,
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
                          const Gap(20),
                          FadeAnimation(
                            1.5,
                            PrimaryButton(
                              text: "Transfer".tr,
                              press: () {
                                walletController.TransferFund(
                                    amount: _amount.text);
                              },
                            ),
                          ),
                          const Gap(30),
                        ],
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













                  // const Gap(10),
                  // FadeAnimation(
                  //   1.2,
                  //   BodyText(
                  //     text: "Please align QR".tr,
                  //     color: kSecondaryColor,
                  //   ),
                  // ),
                  // FadeAnimation(
                  //   1.3,
                  //   ScreenTitle(
                  //     text: "Scan QR Code".tr,
                  //   ),
                  // ),
//QrView(context);
                          // try {
                          //   walletController.QRScanner().then(
                          //     (value) => {
                          //       walletController.SnackBar(
                          //           "Success".tr,
                          //           "AccountID : $value",
                          //           SvgPicture.asset(
                          //             "assets/icons/Success2.svg",
                          //             color: Colors.white,
                          //           ),
                          //           success,
                          //           SnackPosition.TOP),
                          //       if (value != "-1")
                          //         {
                          //           walletController.GetShop().then(
                          //             (value) => QrDialog(context),
                          //           )
                          //         }
                          //     },
                          //   );
                          // } catch (e) {
                          //   walletController.SnackBar(
                          //       "Error".tr,
                          //       "$e",
                          //       SvgPicture.asset(
                          //         "assets/icons/Close.svg",
                          //         color: Colors.white,
                          //       ),
                          //       error,
                          //       SnackPosition.TOP);
                          // }

                          //QrDialog(context);




                          
 // walletController.QRScanner().then(
                          //   (value) => {
                          //     if (value != "-1")
                          //       {
                          //         // QrDialog(context)
                          //         walletController.GetShop()
                          //             .then((value) => QrDialog(context))
                          //       }
                          //   },
                          // );