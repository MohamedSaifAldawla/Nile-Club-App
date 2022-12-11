import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nile_club/Controllers/bar_controller.dart';
import 'package:nile_club/theme.dart';

import '../../Controllers/trans_controller.dart';

class HomePage extends StatelessWidget {
  final barController = Get.put(BarController());

  HomePage({Key? key}) : super(key: key);
  final transController = Get.find<TransController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: barController.screens[barController.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? kPrimaryLightColor
                : kPrimaryDarkColor,
            elevation: 15,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kTextColor,
            currentIndex: barController.currentIndex.value,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Home.svg",
                    color: Colors.grey,
                    height: 25,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Home.svg",
                    color: gold,
                    height: 25,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/News.svg",
                    color: Colors.grey,
                    height: 25,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/News.svg",
                    color: kPrimaryColor,
                    height: 25,
                  ),
                  label: "News"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Cash.svg",
                    color: Colors.grey,
                    height: 18,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Cash.svg",
                    color: success,
                    height: 18,
                  ),
                  label: "Transactions"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/DebitCard.svg",
                    color: Colors.grey,
                    height: 25,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/DebitCard.svg",
                    color: Color(0xffEA1E63),
                    height: 25,
                  ),
                  label: "Memberships"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Male.svg",
                    color: Colors.grey,
                    height: 25,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/Male.svg",
                    color: Color(0xffF77A47),
                    height: 25,
                  ),
                  label: "Profile"),
            ],
            onTap: (index) {
              if (index == 2) {
                transController.GetHistory();
              }
              barController.currentIndex.value = index;
            },
          ),
        ));
  }
}
