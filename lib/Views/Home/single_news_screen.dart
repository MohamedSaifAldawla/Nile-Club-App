import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nile_club/Models/blogs.dart';

import '../../Animations/FadeAnimation.dart';
import '../../Widgets/intro.dart';
import '../../Widgets/loader.dart';
import '../../size_config.dart';
import '../../theme.dart';

class SingleNewsScreen extends StatelessWidget {
  const SingleNewsScreen({Key? key, required this.blog}) : super(key: key);
  final Blogs blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: 'news' + blog.id.toString(),
                  child: CachedNetworkImage(
                    imageUrl: '${blog.image}',
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(250),
                      child: Loader(),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 60,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(300),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(30),
              FadeAnimation(
                1,
                BodyText(
                  text: '${blog.title}',
                  fontSize: getProportionateScreenWidth(18),
                  weight: FontWeight.w500,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ),
              const Gap(5),
              FadeAnimation(
                1.2,
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Calendar.svg",
                      color: yellow,
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenHeight(30),
                    ),
                    const Gap(10),
                    BodyText(
                      text: Jiffy('${blog.date}').format('MMM do yyyy, h:mm a'),
                      color: kSecondaryColor,
                      fontSize: getProportionateScreenWidth(13),
                    )
                  ],
                ),
              ),
              const Gap(20),
              FadeAnimation(
                1.3,
                NormalBodyText(
                  text: '${blog.content}',
                  fontSize: getProportionateScreenWidth(15),
                  color: kSecondaryColor,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






                      // Image.network(
                      //   '${blog.image}',
                      //   width: double.infinity,
                      //   // height: 250,
                      //   fit: BoxFit.cover,
                      // ),