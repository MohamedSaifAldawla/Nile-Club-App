import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nile_club/Models/blogs.dart';
import 'package:nile_club/Views/Home/single_news_screen.dart';
import '../../Animations/FadeAnimation.dart';
import '../../Controllers/blogs_controller.dart';
import '../../Widgets/loader.dart';
import '../../Widgets/news_card.dart';
import '../../theme.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlogsController blogsController = Get.find<BlogsController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("News".tr),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: blogsController.isLoading.value
              ? Center(child: Loader())
              : Column(
                  children: [
                    //const Gap(25),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        physics: BouncingScrollPhysics(),
                        itemCount: blogsController.blogs.length,
                        itemBuilder: (context, index) => FadeAnimation(
                          1,
                          NewsItem(blogsController.blogs[index]),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 25,
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

Widget NewsItem(Blogs blogs) {
  return GestureDetector(
    onTap: () {
      Get.to(() => SingleNewsScreen(blog: blogs));
    },
    child: NewsCard2(
      width: double.infinity,
      title: "${blogs.title}",
      body: "${blogs.content}",
      image: "${blogs.image}",
      date: "${blogs.date}",
      index: "${blogs.id}",
    ),
  );
}
