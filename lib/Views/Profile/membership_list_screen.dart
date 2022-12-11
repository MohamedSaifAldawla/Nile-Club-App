import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Models/Memberships.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../size_config.dart';
import '../../theme.dart';

class MembershipListScreen extends StatelessWidget {
  MembershipListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memberships Type".tr),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(horizontalPadding),
            vertical: 20),
        child: isMember == "1"
            ? FadeAnimation(
                1.2,
                MemberCard(context: context),
              )
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: profileController.memberships.length,
                itemBuilder: (context, index) => FadeAnimation(
                  1,
                  MembershipCard(
                      memberships: profileController.memberships[index],
                      profileController: profileController,
                      context: context),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 25,
                ),
              ),
      ),
    );
  }
}

Widget MembershipCard(
    {required Memberships memberships, profileController, context}) {
  return GestureDetector(
    onTap: () {
      memberships.id == "2"
          ? profileController.membershipType = "individual"
          : profileController.membershipType = "Family";
      profileController.getMemberships(catId: memberships.id);
      print(profileController.membershipType);
    },
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
        gradient: "${memberships.id}" == "2"
            ? kIndividualGradientColor
            : kfamailyGradientColor,
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
      child: Padding(
        padding: EdgeInsets.only(
            top: getProportionateScreenWidth(25),
            bottom: getProportionateScreenWidth(25),
            left: getProportionateScreenWidth(30),
            right: getProportionateScreenWidth(30)),
        child: Row(
          children: [
            BodyText(
              text: "${memberships.name}".tr,
              weight: FontWeight.bold,
              color: kPrimaryLightColor,
              fontSize: getProportionateScreenWidth(18),
              maxLines: 2,
            ),
            Spacer(),
            SvgPicture.asset(
              "${memberships.id}" == "2"
                  ? "assets/icons/Groom.svg"
                  : "assets/icons/Family.svg",
              color: kPrimaryLightColor,
              width: getProportionateScreenWidth(60),
              height: getProportionateScreenWidth(60),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget MemberCard({required context}) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        const Gap(30),
        BodyText(
          text: "This QR contains".tr,
          color: kSecondaryColor,
          maxLines: 3,
        ),
        Gap(getProportionateScreenWidth(90)),
        Container(
          width: double.infinity,
          height: getProportionateScreenWidth(400),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: membership == 'Gold'
                  ? AssetImage('assets/images/Gold2.jfif')
                  : AssetImage('assets/images/Platinum.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(20)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? shadow
                    : shadow2,
                blurRadius: 20.0,
                offset: Offset(0, 8),
                blurStyle: BlurStyle.normal,
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(50),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(15)),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: getProportionateScreenWidth(270),
                              color: kPrimaryLightColor,
                              child: Center(
                                child: QrImage(
                                  data: "${serial}",
                                  backgroundColor: kPrimaryLightColor,
                                  version: QrVersions.auto,
                                  size: getProportionateScreenWidth(200),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: QrImage(
                        data: "${serial}",
                        backgroundColor: kPrimaryLightColor,
                        version: QrVersions.auto,
                        size: getProportionateScreenWidth(250),
                      ),
                    ),
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyText(
                          text: "Membership Type".tr,
                          weight: FontWeight.w500,
                          color:
                              membership == 'Gold' ? kPrimaryLightColor : null,
                        ),
                        const Gap(10),
                        BodyText(
                          text: membership,
                          weight: FontWeight.bold,
                          color:
                              membership == 'Gold' ? kPrimaryLightColor : null,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyText(
                          text: "Expire Date".tr,
                          weight: FontWeight.w500,
                          color:
                              membership == 'Gold' ? kPrimaryLightColor : null,
                        ),
                        const Gap(10),
                        BodyText(
                          text: exDate,
                          weight: FontWeight.bold,
                          color:
                              membership == 'Gold' ? kPrimaryLightColor : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: getProportionateScreenWidth(-55),
                child: SizedBox(
                  width: getProportionateScreenWidth(105),
                  height: getProportionateScreenWidth(105),
                  child: CircleAvatar(
                    backgroundColor: kSecondaryColor,
                    child: SizedBox(
                      width: getProportionateScreenWidth(100),
                      height: getProportionateScreenWidth(100),
                      child: InkWell(
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(15)),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: getProportionateScreenWidth(270),
                                color: kPrimaryLightColor,
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: img,
                                    placeholder: (context, url) => Loader(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 60,
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? kPrimaryLightColor
                                  : kPrimaryDark3Color,
                          child: CachedNetworkImage(
                            imageUrl: img,
                            placeholder: (context, url) => Loader(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: 60,
                            ),
                            imageBuilder: (context, imageProvider) => Container(
                              width: getProportionateScreenWidth(100.0),
                              height: getProportionateScreenWidth(100.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

























//Widget MembershipCard(
//     {required Memberships memberships, profileController, context}) {
//   return GestureDetector(
//     onTap: () {
//       memberships.id == "2"
//           ? profileController.membershipType = "individual"
//           : profileController.membershipType = "Family";
//       profileController.getMemberships(catId: memberships.id);
//       print(profileController.membershipType);
//     },
//     child: Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).brightness == Brightness.light
//             ? kPrimaryLightColor
//             : kPrimaryDark3Color,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Theme.of(context).brightness == Brightness.light
//                 ? shadow
//                 : shadow2,
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding:
//             const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
//         child: Row(
//           children: [
//             "${memberships.id}" == "2"
//                 ? MemberIconIndividual(memberships, context)
//                 : MemberIconFamily(memberships, context),
//             const Gap(20),
//             BodyText(
//               text: "${memberships.name}".tr,
//               weight: FontWeight.bold,
//               color: Theme.of(context).brightness == Brightness.light
//                   ? kSecondaryColor
//                   : kPrimaryLightColor,
//               fontSize: 18,
//               maxLines: 2,
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// SvgPicture MemberIconIndividual(Memberships memberships, context) {
//   return SvgPicture.asset(
//     "assets/icons/Groom.svg",
//     color: kPrimaryColor,
//     width: 40,
//     height: 40,
//   );
// }

// SvgPicture MemberIconFamily(Memberships memberships, context) {
//   return SvgPicture.asset(
//     "assets/icons/Family.svg",
//     color: Color(0xffEA1E63),
//     width: 40,
//     height: 40,
//   );
// }
