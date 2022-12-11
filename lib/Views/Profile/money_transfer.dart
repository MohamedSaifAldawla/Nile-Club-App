import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/Views/Profile/trans_qr_scanner.dart';
import 'package:nile_club/theme.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Controllers/profile_controller.dart';
import '../../Controllers/wallet_controller.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/primary_button.dart';

class MoneyTransferScreen extends StatefulWidget {
  MoneyTransferScreen({Key? key}) : super(key: key);

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  WalletController walletController = Get.find<WalletController>();
  ProfileController profileController = Get.find<ProfileController>();
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
                horizontal: horizontalPadding, vertical: 80),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeAnimation(
                    1,
                    ScreenTitle(
                      text: "Scan QR Code".tr,
                    ),
                  ),
                  FadeAnimation(
                    1.1,
                    Lottie.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? 'assets/icons/QrLight.json'
                          : 'assets/icons/QrDark.json',
                      width: 350,
                      height: 350,
                      fit: BoxFit.fill,
                    ),
                  ),
                  FadeAnimation(
                    1.2,
                    BodyText(
                      text: "Please align QR".tr,
                      color: kSecondaryColor,
                    ),
                  ),
                  const Gap(30),
                  FadeAnimation(
                    1.3,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: PrimaryButton(
                        text: "Scan".tr,
                        press: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TransferQR(),
                            ),
                          );
                        },
                      ),
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
}















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