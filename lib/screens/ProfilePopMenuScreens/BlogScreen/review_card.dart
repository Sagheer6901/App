import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/models/blog_comments.dart';

class BlogReviewCard extends StatelessWidget {
  final BlogsComments? item;
  final Future<List<BlogsComments>>? products;
  BlogReviewCard({Key? key, this.products, this.item}) : super(key: key);
  final DateFormat? formatter = DateFormat('yyyy-MM-dd');
  // get rating => null;

  UserProfile userProfile = UserProfile();
  @override
  Widget build(BuildContext context) {
    final String formatted = formatter!.format(item!.date!);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 22,
                    backgroundImage: NetworkImage(
                      '${AppConfig.srcLink}${item!.image}',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item!.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConfig.f4,
                            color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                      ),
                      Text(
                        "$formatted",
                        style: TextStyle(fontSize: AppConfig.f6, color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),
                      )
                    ],
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     RatingBarIndicator(
              //       rating: 4,
              //       itemBuilder: (context, index) => Icon(
              //         Icons.star,
              //         color: Colors.amber,
              //       ),
              //       itemCount: 5,
              //       itemSize: 20.0,
              //
              //       unratedColor: Colors.amber.withAlpha(60),
              //       direction:  Axis.horizontal,
              //     ),
              //     Text(
              //       "Very Good",
              //       style: TextStyle(fontSize: AppConfig.f6),
              //     ),
              //   ],
              // )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(child: Text("${item!.comment}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),))
        ],
      ),
    );
  }
}
