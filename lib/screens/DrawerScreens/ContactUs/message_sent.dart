import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/all_my_requests.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';

class MessageSuccess extends StatefulWidget {
  const MessageSuccess({Key? key}) : super(key: key);

  @override
  _MessageSuccessState createState() => _MessageSuccessState();
}

class _MessageSuccessState extends State<MessageSuccess> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light,        ),

    );
    return Scaffold(
      backgroundColor: AppConfig.tripColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(15)), // Set this height
        child: SafeArea(
          child: Container(
              height: _appConfig.rH(15),
              padding: EdgeInsets.only(
                  left: _appConfig.rWP(5),
                  right: _appConfig.rHP(5),
                  top: _appConfig.rWP(5),
                  bottom: _appConfig.rWP(5)),
              decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationScreen()),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppConfig.whiteColor,
                          size: 30,
                        ),
                      ),

                    ],
                  ),
                ],
              )),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
                  (route) => false);
          return Future.value(false);
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Thank You.",style: TextStyle(fontSize: AppConfig.f(7), color: AppConfig.whiteColor),),
              Divider(
                height: 25,
                thickness: 1,
                color: AppConfig.whiteColor,
              ),
              Text("We will be in touch. Shortly!",style: TextStyle(fontSize: AppConfig.f3, color: AppConfig.whiteColor),)
            ],
          ),
        ),
      ),
    );
  }
// showCustomToast() {
//   Widget toast = Container(
//     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(25.0),
//       color: AppConfig.shadeColor,
//     ),
//     child: Text("Ticket Sent",textScaleFactor: 1,),
//   );
//
//   // fToast.showToast(
//   //   child: toast,
//   //   toastDuration: Duration(seconds: 3),
//   // );
// }

}
