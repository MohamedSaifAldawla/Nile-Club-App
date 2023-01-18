import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nile_club/Widgets/intro.dart';
import '../Globals/globals.dart';
import '../Models/transactions.dart';
import '../Views/Home/trans_tickets_screen.dart';
import '../size_config.dart';
import '../theme.dart';

Widget TransCard2(Transaction transaction, context) {
  return Container(
    padding: EdgeInsets.only(
        left: getProportionateScreenWidth(13),
        right: getProportionateScreenWidth(15),
        top: getProportionateScreenWidth(10),
        bottom: getProportionateScreenWidth(12)),
    width: double.infinity,
    //height: getProportionateScreenHeight(90),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? kPrimaryLightColor
          : kPrimaryDark3Color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).brightness == Brightness.light
              ? shadow
              : shadow2,
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        Get.to(() => TransTicketsScreen(transaction: transaction));
      },
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                  color: transaction.output == "Approved"
                      ? Color.fromARGB(30, 64, 199, 165)
                      : transaction.output == "Declined"
                          ? Color.fromARGB(30, 232, 76, 92)
                          : Color.fromARGB(30, 251, 189, 92),
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(25))),
              child: (() {
                if (transaction.alias == "reserve") {
                  return SvgPicture.asset(
                    "assets/icons/ticket1.svg",
                    width: getProportionateScreenWidth(30),
                    height: getProportionateScreenWidth(30),
                    color: transaction.output == "Approved" ? success : gold,
                  );
                }
                if (transaction.alias == "topup") {
                  return SvgPicture.asset(
                    "assets/icons/Transfer.svg",
                    width: getProportionateScreenWidth(30),
                    height: getProportionateScreenWidth(30),
                    color: transaction.output == "Approved" ? success : gold,
                  );
                }
                if (transaction.alias == "membership") {
                  return SvgPicture.asset(
                    "assets/icons/Membership.svg",
                    width: getProportionateScreenWidth(30),
                    height: getProportionateScreenWidth(30),
                    color: transaction.output == "Approved"
                        ? success
                        : transaction.output == "Declined"
                            ? error
                            : gold,
                  );
                } else
                  () {
                    return SvgPicture.asset(
                      "assets/icons/Calendar.svg",
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(30),
                      color: transaction.output == "Approved" ? success : gold,
                    );
                  };
              }())),
          Gap(10),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    BodyText(
                      text: "${transaction.outputType}",
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Gap(5),
                Row(
                  children: [
                    BodyText(
                      text: "${transaction.status}",
                      fontSize: getProportionateScreenWidth(13),
                      color: Theme.of(context).brightness == Brightness.light
                          ? kSecondaryColor
                          : Colors.white70,
                    ),
                    Spacer(),
                    BodyText(
                      text: "${transaction.outputAmount}" + "SDG".tr,
                      weight: FontWeight.bold,
                      color: transaction.output == "Approved"
                          ? success
                          : transaction.output == "Declined"
                              ? error
                              : gold,
                    ),
                  ],
                ),
                Gap(5),
                Row(
                  children: [
                    BodyText(
                      text: Jiffy('${transaction.outputDate}')
                          .format('MMM do yyyy, h:mm a'),
                      fontSize: getProportionateScreenWidth(13),
                      color: Theme.of(context).brightness == Brightness.light
                          ? kSecondaryColor
                          : Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}







// class TransCard extends StatelessWidget {
//   Function()? onTap;
//   TransCard({
//     this.onTap,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 13, right: 15, top: 0),
//       width: double.infinity,
//       height: getProportionateScreenHeight(90),
//       decoration: BoxDecoration(
//           color: kPrimaryLightColor,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [boxShadow]),
//       child: InkWell(
//         onTap: onTap,
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(30, 251, 189, 92),
//                   borderRadius: BorderRadius.circular(25)),
//               child: SvgPicture.asset(
//                 "assets/icons/Schedule.svg",
//                 width: getProportionateScreenWidth(30),
//                 height: getProportionateScreenHeight(30),
//                 color: Color(0xffFBBD5C),
//               ),
//             ),
//             Gap(10),
//             Flexible(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       BodyText(
//                         text: "Bowlling Service",
//                         weight: FontWeight.w500,
//                       ),
//                       Spacer(),
//                       BodyText(
//                         text: "\$ " "10,000",
//                         weight: FontWeight.bold,
//                         color: yellow,
//                       ),
//                     ],
//                   ),
//                   Gap(5),
//                   Row(
//                     children: [
//                       BodyText(
//                         text: "14-8-2022",
//                         fontSize: 13,
//                         color: kSecondaryColor,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
