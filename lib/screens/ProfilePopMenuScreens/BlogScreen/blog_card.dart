import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blog_detailed.dart';
import 'package:untitled/services/services.dart';

class BlogCard extends StatelessWidget {
  List<String>? categories;
  final Blogs? item;
  final Future<List<Blogs>>? products;
  BlogCard({Key? key, this.products, this.item,this.categories}) : super(key: key);
  final DateFormat? formatter = DateFormat('yyyy-MM-dd');

  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    final String formatted = formatter!.format(item!.date!);

    return InkWell(
      child: Container(
        // height: 450,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      // color: AppConfig.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.network(
                        "${AppConfig.srcLink}${item!.image}",
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )),
                // Positioned(right: 20, top: 20, child: Icon(Icons.favorite))
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                  alignment: Alignment.topLeft,
                  width: 100,
                  height: 25,
                  child: Text(
                    item!.title!,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppConfig.f3,
                        color: AppConfig.carColor,
                        fontFamily: AppConfig.fontFamilyMedium
                    ),
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.supervised_user_circle,
                  size: 20,
                  color: AppConfig.textColor,
                ),
                Text(
                  "by author",
                  style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),
                ),
                Text(
                  "Traboon",
                  style: TextStyle(color: AppConfig.carColor,fontFamily: AppConfig.fontFamilyMedium),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                item!.description!,
                overflow: TextOverflow.clip,
                style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatted,
                  style: TextStyle(color: AppConfig.carColor),
                ),
                CustomBtn(
                  "Read more",
                  30.0,
                  AppConfig.carColor,
                  textColor: AppConfig.whiteColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlogDetailedScreen(
                                item: item,
                              blogsCommentsById: WebServices.blogCommentItemsById(item!.id)
                              )),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
