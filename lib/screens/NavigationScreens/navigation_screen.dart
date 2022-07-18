import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/routes.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/NavigationScreens/mapLocation/live_location.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/screens/NavigationScreens/home-page.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/home_page.dart';
import 'package:untitled/screens/NavigationScreens/map.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/profile_screen.dart';
import 'package:untitled/services/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:response/response.dart';
// void main() {
//   runApp(const MainScreen());
// }

// var oldCount= 0;
// var supportOldCount = 0;
// List<dynamic> chatItems = [];
// List<dynamic> supportItems = [];
//
// getSupportNoti() async {
//
//   List<String> item=[];
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await WebServices.productsCustomerSupportNotification().first.then((categories) {
//     // if (prefs.containsKey('notification_count')) {
//     //   supportOldCount = prefs.getInt('notification_count')!;
//     // }
//     // _categories = categories;
//     categories. forEach((element){
//       item.add("${element.notiCount}");
//       // print("${element.title}");
//     });
//
//     print("list of support item ${item.first} and ${supportOldCount}");
//     supportItems = item;
//     // print("list of items ${items[0][1]}");
//   });
//   if (supportOldCount < int.parse(supportItems.first)){
//     not();
//     supportOldCount =  int.parse(supportItems.first);
//     prefs.setInt('notification_count', supportOldCount);
//   }
//   else{
//     print(" No notification");
//     if(supportOldCount!=  int.parse(chatItems.first)){
//       supportOldCount =  int.parse(chatItems.first);
//     }
//   }
// }
//
// getNoti() async {
//   List<String> item=[];
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await WebServices.productsNotification().first.then((categories) {
//     // if (prefs.containsKey('notification_count')) {
//     //   oldCount = prefs.getInt('notification_count')!;
//     // }
//     // _categories = categories;
//     categories. forEach((element){
//       item.add("${element.notiCount}");
//       // print("${element.title}");
//     });
//
//     print("list of item ${item.first} and ${oldCount}");
//     chatItems = item;
//     print("list of items $chatItems");
//   });
//   if (oldCount < int.parse(chatItems.first)){
//     not();
//     oldCount =  int.parse(chatItems.first);
//     prefs.setInt('notification_count', oldCount);
//   }
//   else{
//     print(" No notification");
//     if(oldCount!=  int.parse(chatItems.first)){
//       oldCount =  int.parse(chatItems.first);
//     }
//   }
//   // count=items.length;
// }

var oldChatCount= 0;
var oldEnquiryCount= 0;
List<dynamic> chatItems = [];
List<dynamic> enquiryItems = [];

getEnquiryNoti() async {
  List<String> item=[];
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await WebServices.productsCustomerSupportNotification().first.then((categories) {
    // if (prefs.containsKey('notification_enquiry_count')) {
    //   oldEnquiryCount = prefs.getInt('notification_enquiry_count')!;
    // }
    // _categories = categories;
    categories. forEach((element){
      item.add("${element.notiCount}");
      // print("${element.title}");
    });

    print("list of item $item");
    enquiryItems = item;
    print("list of items ${enquiryItems.first}}");
  });
  print(" oldenquiry $oldEnquiryCount new ${enquiryItems.first}");

  if (oldEnquiryCount < int.parse(enquiryItems.first)){

    not();
    oldEnquiryCount =  int.parse(enquiryItems.first);
    prefs.setInt('notification_enquiry_count', oldEnquiryCount);
  }
  else{
    print(" No notification enquiry");
    if(oldEnquiryCount!=  int.parse(enquiryItems.first)){
      oldEnquiryCount =  int.parse(enquiryItems.first);
    }
  }
  // count=items.length;
}

getChatNoti() async {
  List<String> item=[];
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await WebServices.productsNotification().first.then((categories) {
    // if (prefs.containsKey('notification_count')) {
    //   oldChatCount = prefs.getInt('notification_count')!;
    // }
    // _categories = categories;
    categories. forEach((element){
      item.add("${element.notiCount}");
      // print("${element.title}");
    });

    print("list of item $item");
    chatItems = item;
    print("list of items $chatItems");
  });
  print(" olchat $oldEnquiryCount new ${enquiryItems.first}");

  if (oldChatCount < int.parse(chatItems.first)){
    not();
    oldChatCount =  int.parse(chatItems.first);
    prefs.setInt('notification_count', oldChatCount);
  }
  else{
    print(" No notification");
    if(oldChatCount!=  int.parse(chatItems.first)){
      oldChatCount =  int.parse(chatItems.first);
    }
  }
  // count=items.length;
}


not(){
  FlutterRingtonePlayer.play(
    android: AndroidSounds.notification,
    ios: IosSounds.glass,
    // looping: true,
    volume: 1.0,
  );
}

class NavigationScreen extends StatefulWidget {
  // const NavigationScreen({Key? key, required User user})
  //     : _user = user,
  //       super(key: key);

  // final User _user;

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t){
    //   // setState(() {
    //   //   oldChatCount=0;
    //   //   oldEnquiryCount=0;
    //   // });
    //   // getSupportNoti();
    //   getEnquiryNoti();
    //   getChatNoti();
    // });
  }
  not(){
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      // looping: true,
      volume: 1.0,
    );
  }


  @override
  Widget build(BuildContext context) {
    // print("Get  mediaquery width: ${Get.mediaQuery.size.width}");
    // print("Get  mediaquery height: ${Get.mediaQuery.size.height}");
    // print("Get  mediaquery width: ${Get.width}");
    // print("Get  mediaquery height: ${Get.height}");
    // print("Get  mediaquery width: ${MediaQuery.of(context).size.width}");
    // print("Get  mediaquery height: ${MediaQuery.of(context).size.height}");
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    // ScreenUtil.init(context, designSize: const Size(360, 690));
    final List<Widget> _children = [
      MyHomePage(),
      MapLocation(),
      GuideList(),
      Profile()
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        body: _children[_currentIndex],
            drawer: const MyDrawer(),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: AppConfig.textColor,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.map),
              title: Text("Map"),
              selectedColor: AppConfig.textColor,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.person_outline),
              title: Text("Guide"),
              selectedColor: AppConfig.textColor,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.app_settings_alt),
              title: Text("Profile"),
              selectedColor: AppConfig.textColor,
            ),
          ],
        ),
      )),
    );
  }
}
