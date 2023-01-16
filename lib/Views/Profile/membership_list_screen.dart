import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Models/Memberships.dart';
import 'package:nile_club/Views/Profile/add_new_member_screen.dart';
import 'package:nile_club/Views/Profile/subscribe_screen.dart';
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
            : formId != null && isMember == "0"
                ? FadeAnimation(
                    1.2,
                    MembersReceipt(context: context),
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

Widget MembersReceipt({required context}) {
  return Center(
    child: Container(
      width: double.infinity,
      height: getProportionateScreenWidth(480),
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
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
        child: Column(
          children: [
            const Gap(30),
            SizedBox(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(100),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/logo3.png"),
              ),
            ),
            const Gap(30),
            Row(
              children: [
                BodyText(
                  text: "Status".tr,
                  weight: FontWeight.w500,
                ),
                Spacer(),
                BodyText(
                  text: "${profileController.membershipReserve['status']}",
                  weight: FontWeight.bold,
                  color: profileController.membershipReserve['status'] ==
                          "Declined"
                      ? error
                      : gold,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                BodyText(
                  text: "Ticket name".tr,
                  weight: FontWeight.w500,
                ),
                Spacer(),
                BodyText(
                  text:
                      "${profileController.membershipReserve['MembershipType']}",
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                BodyText(
                  text: "No. of family".tr,
                  weight: FontWeight.w500,
                ),
                Spacer(),
                BodyText(
                  text: "${profileController.membershipReserve['no_family']}" +
                      " " +
                      "family".tr,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                BodyText(
                  text: "No. of Adults".tr,
                  weight: FontWeight.w500,
                ),
                Spacer(),
                BodyText(
                  text: "${profileController.membershipReserve['noAdult']}" +
                      " " +
                      "Adult's".tr,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                BodyText(
                  text: "No. of children's".tr,
                  weight: FontWeight.w500,
                ),
                Spacer(),
                BodyText(
                  text: "${profileController.membershipReserve['noChild']}" +
                      " " +
                      "children's".tr,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                BodyText(
                  text: "Amount".tr,
                  weight: FontWeight.w500,
                ),
                Spacer(),
                if (profileController.membershipReserve['amount'] != null)
                  BodyText(
                    text: "${profileController.membershipReserve['amount']} " +
                        "${profileController.membershipReserve['currency']}".tr,
                    weight: FontWeight.bold,
                    color: success,
                  ),
                if (profileController.membershipReserve['amount'] == null)
                  BodyText(
                    text: "0",
                    weight: FontWeight.bold,
                    color: success,
                  ),
              ],
            ),
            const Gap(40),
            if (profileController.membershipReserve['status'] != "Pending")
              InkWell(
                onTap: () {
                  profileController.membershipType = "Family";
                  profileController.Init();
                  Get.to(() => AddNewMemberScreen());
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: getProportionateScreenHeight(50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyText(
                          text: "Add Member".tr.toUpperCase(),
                          weight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const Gap(15),
            InkWell(
              onTap: () {
                profileController.Getfamily();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                height: getProportionateScreenHeight(50),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BodyText(
                        text: "View Memberships".tr.toUpperCase(),
                        weight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
