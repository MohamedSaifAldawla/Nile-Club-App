import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nile_club/Globals/globals.dart';
import 'package:nile_club/Models/TransMemberships.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../size_config.dart';
import '../../theme.dart';

class FamilyMembershipScreen extends StatelessWidget {
  FamilyMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Memberships".tr),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const Gap(20),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
                  physics: BouncingScrollPhysics(),
                  itemCount: profileController.transMemberships.length,
                  itemBuilder: (context, index) => FadeAnimation(
                    1,
                    MembershipItem(
                        context: context,
                        membership: profileController.transMemberships[index]),
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
}

Widget MembershipItem(
    {required context, required TransMemberships membership}) {
  return FadeAnimation(
    1,
    GestureDetector(
      onTap: () => profileController.GetMemberData(memberid: membership.id!),
      child: Container(
        width: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${membership.img}",
                    placeholder: (context, url) => Loader(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 60,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: getProportionateScreenWidth(80.0),
                      height: getProportionateScreenWidth(80.0),
                      decoration: BoxDecoration(
                        color: kTextColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(
                        text: "${membership.name}".toUpperCase(),
                        weight: FontWeight.bold,
                      ),
                      const Gap(5),
                      BodyText(
                        text: "${membership.phone}",
                        color: kSecondaryColor,
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      profileController.GetMemberData(memberid: membership.id!);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/edit.svg",
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
