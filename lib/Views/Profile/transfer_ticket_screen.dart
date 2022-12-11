import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/theme.dart';
import 'package:screenshot/screenshot.dart';
import '../../Globals/globals.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/social_item.dart';

class TransferTicketScreen extends StatelessWidget {
  TransferTicketScreen({super.key});
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 20),
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? kPrimaryLightColor
                            : kPrimaryDark3Color,
                        image: DecorationImage(
                            image:
                                Theme.of(context).brightness == Brightness.light
                                    ? AssetImage("assets/images/ticket2.png")
                                    : AssetImage("assets/images/ticket.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? shadow
                                    : shadow2,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 30),
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/icons/transfer.json',
                            width: 250,
                            height: 250,
                          ),
                          if (walletController.moneyTransfer['message'] != null)
                            BodyText(
                              text:
                                  "${walletController.moneyTransfer['message']}",
                              weight: FontWeight.bold,
                              fontSize: 20,
                              color: success,
                              maxLines: 2,
                            ),
                          if (walletController.moneyTransfer['msg'] != null)
                            BodyText(
                              text: "${walletController.moneyTransfer['msg']}",
                              weight: FontWeight.bold,
                              fontSize: 20,
                              color: success,
                              maxLines: 2,
                            ),
                          const Gap(10),
                          if (walletController.moneyTransfer['amount'] != null)
                            Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.06),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  BodyText(
                                    text:
                                        "${walletController.moneyTransfer['amount']}"
                                        " SDG",
                                    weight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  const Gap(10),
                                  BodyText(
                                    text: "Transferred amount".tr,
                                  ),
                                ],
                              ),
                            ),
                          const Gap(20),
                          Row(
                            children: [
                              BodyText(
                                text: "Transaction id".tr,
                                weight: FontWeight.bold,
                              ),
                              Spacer(),
                              BodyText(
                                text:
                                    "${walletController.moneyTransfer['trans_id']}",
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Gap(10),
                          if (walletController.moneyTransfer['sender'] != null)
                            Row(
                              children: [
                                BodyText(
                                  text: "From".tr,
                                  weight: FontWeight.bold,
                                ),
                                Spacer(),
                                BodyText(
                                  text:
                                      "${walletController.moneyTransfer['sender']}",
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          const Gap(10),
                          if (walletController.moneyTransfer['receiver'] !=
                              null)
                            Row(
                              children: [
                                BodyText(
                                  text: "To".tr,
                                  weight: FontWeight.bold,
                                ),
                                Spacer(),
                                BodyText(
                                  text:
                                      "${walletController.moneyTransfer['receiver']}",
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          const Gap(10),
                          if (walletController.moneyTransfer['date'] != null)
                            Row(
                              children: [
                                BodyText(
                                  text: "Date".tr,
                                  weight: FontWeight.bold,
                                ),
                                Spacer(),
                                BodyText(
                                  text: Jiffy(
                                          '${walletController.moneyTransfer['date']}')
                                      .format('MMM do yyyy'),
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          const Gap(10),
                          if (walletController.moneyTransfer['balance'] != null)
                            Divider(
                              color: kSecondaryColor,
                              thickness: 0.1,
                            ),
                          const Gap(10),
                          if (walletController.moneyTransfer['balance'] != null)
                            Row(
                              children: [
                                BodyText(
                                  text: "Remaning Balance".tr,
                                  weight: FontWeight.bold,
                                ),
                                Spacer(),
                                BodyText(
                                  text:
                                      "${walletController.moneyTransfer['balance']}"
                                      " SDG",
                                  weight: FontWeight.bold,
                                  fontSize: 18,
                                  color: success,
                                ),
                              ],
                            ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallButtons(
                                icon: "assets/icons/Save2.svg",
                                color: kPrimaryColor,
                                press: () async {
                                  final image =
                                      await screenshotController.capture();
                                  if (image == null) return;
                                  profileController.saveImage(image);
                                },
                              ),
                              SmallButtons(
                                icon: "assets/icons/Home.svg",
                                color: kPrimaryColor,
                                press: () {
                                  Get.offAllNamed('homepage');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
