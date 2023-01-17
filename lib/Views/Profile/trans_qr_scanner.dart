import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Animations/FadeAnimation.dart';
import '../../Controllers/wallet_controller.dart';
import '../../Widgets/inputField.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';
import '../../theme.dart';

class TransferQR extends StatefulWidget {
  TransferQR({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransferQRState();
}

class _TransferQRState extends State<TransferQR> {
  WalletController walletController = Get.find<WalletController>();
  final formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  String? amount;
  List<String> errors = [];

  Barcode? barcode;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: kPrimaryLightColor),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildQrView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: kPrimaryColor,
        borderLength: 20,
        borderWidth: 10,
        borderRadius: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Future QrDialog(context) {
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
                            reassemble();
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      reassemble();
    });
    controller.scannedDataStream.listen(
      (scanData) {
        barcode = scanData;
        walletController.scannedQR = barcode!.code;
        controller.pauseCamera();
        print(walletController.scannedQR);
        walletController.GetShop().then(
          (value) {
            if (walletController.successShowDialog == true) {
              print("true");
              QrDialog(context);
            } else if (walletController.successShowDialog == false) {
              print("false");
              reassemble();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
