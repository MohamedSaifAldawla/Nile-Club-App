import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nile_club/Controllers/trans_controller.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../Widgets/sections.title.dart';
import '../../Widgets/trans_card.dart';
import '../../size_config.dart';
import '../../theme.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({Key? key}) : super(key: key);
  final transController = Get.find<TransController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("History".tr),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: transController.isLoading.value
              ? Center(child: Loader())
              : transController.trans.isEmpty == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/icons/notFound.json',
                            width: 350,
                            height: 350,
                            fit: BoxFit.fill,
                          ),
                          BodyText(
                            text: "no Transaction yet".tr,
                            weight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        const Gap(20),
                        GestureDetector(
                          onTap: Refresh,
                          child: IconSectionsTitle(
                            title: "Latest Transactions".tr,
                            icon: "assets/icons/Refresh.svg",
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(25),
                                horizontal: getProportionateScreenWidth(5)),
                            physics: BouncingScrollPhysics(),
                            itemCount: transController.trans.length,
                            itemBuilder: (context, index) => FadeAnimation(
                              1,
                              TransCard2(transController.trans[index], context),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Refresh() {
    transController.GetHistory();
  }
}
