import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/models/blog_comments.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blog_card.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blog_detailed_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/review_card.dart';
import 'package:untitled/services/services.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../functions/drawer.dart';

class BlogDetailedScreen extends StatefulWidget {
  final Blogs? item;
  final Future<List<BlogsComments>>? blogsComments;
  final Future<List<BlogsComments>>? blogsCommentsById;

  var limit = 5;

  BlogDetailedScreen(
      {Key? key, this.item, this.blogsComments, this.blogsCommentsById})
      : super(key: key);
  @override
  _BlogDetailedScreenState createState() => _BlogDetailedScreenState();
}

class _BlogDetailedScreenState extends State<BlogDetailedScreen> {
  late AppConfig _appConfig;
  TextEditingController _comments = TextEditingController();
  UserProfile userProfile = UserProfile();
  bool loading = true;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var user = prefs.setString('name', "${userProfile.name}");

    var url = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_profile&user_email=$email");
    var response = await http.get(url);
    setState(() {
      print("Hello  $response");
      final jsonresponse = json.decode(response.body);

      userProfile = UserProfile.fromJson(jsonresponse[0]);
      // userProfile = UserProfile.fromJson(json.decode(response.body));
      print(userProfile);
      loading = false;
    });
    prefs.setString("id", userProfile.id.toString());
    prefs.setString("name", userProfile.name.toString());
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Scaffold(
      appBar: preferredSizeAppbar("Blogs", context),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MyBlogs(
                      )),
              (route) => false);
          return Future.value(false);
        },
        child: SingleChildScrollView(
            child: Column(
          children: [
            BlogDetailedCard(
              item: widget.item,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Comment here",
                    style: TextStyle(
                        fontSize: AppConfig.f4,
                        fontWeight: FontWeight.w700,
                        color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                    textScaleFactor: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _comments,
                    maxLines: 2,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(150),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusColor: AppConfig.tripColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomBtn(
                          "Send",
                          _appConfig.rW(7),
                          AppConfig.hotelColor,
                          textColor: AppConfig.tripColor,
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var name = prefs.getString('name');
                            var email = prefs.getString("email");
                            print("hello $name, $email, ${_comments.text}");
                            WebServices.addBlogCommentItems(
                                "${widget.item!.id}",
                                name,
                                email,
                                _comments.text);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => BlogDetailedScreen(
                                        item: widget.item,
                                      blogsCommentsById: WebServices.blogCommentItemsById(widget.item!.id)

                                  )),
                            );
                          },
                          textSize: AppConfig.f4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _appConfig.rH(2),
                  )
                ],
              ),
            ),
            Column(
              children: [

                FutureBuilder<List<BlogsComments>>(
                  future: widget.blogsCommentsById,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    // snapshot.data!.length;
                    return snapshot.hasData
                        ? BlogCommentsItems(
                            items: snapshot.data,
                            itemLimit: widget.limit,
                          )
                        // return the ListView widget :
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                Divider(
                  thickness: 3,
                ),
                //ReviewCard(),
                SizedBox(
                  height: 10,
                ),
                CustomBtn(
                  "See more",
                  60,
                  AppConfig.carColor,
                  onPressed: () {
                    setState(() {
                      widget.limit = widget.limit + 5;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        )),
      ),
      drawer: const MyDrawer(),

    );
  }
}
