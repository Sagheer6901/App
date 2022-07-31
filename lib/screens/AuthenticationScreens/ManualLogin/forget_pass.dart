
import 'package:email_auth/email_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/functions.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/change_pass.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/services/services.dart';

import '../../../models/Profile/get_user_profile_data.dart';
// import 'package:auth_config/auth.config.dart';

class ForgetPass extends StatefulWidget {
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController email = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  Email_OTP myauth = Email_OTP();
  late AppConfig _appConfig;

  UserProfile userProfile = UserProfile();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  bool v = false;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppConfig.tripColor
          //color set to transperent or set your own color
        )
    );
    return Scaffold(
      backgroundColor: AppConfig.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(20)), // Set this height
        child: SafeArea(
          child: Container(
              height: _appConfig.rH(30),
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
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.notifications_none,
                      //       size: 30,
                      //       color: Colors.white,
                      //     ),
                      //     PopUp(),
                      //   ],
                      // ),
                    ],
                  ),
                  Text(
                    "Verify Email",
                    style: TextStyle(
                        fontSize: AppConfig.f1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textScaleFactor: 1,
                  ),
                ],
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/traboon_logo.png",
                  height: _appConfig.rH(30),
                ),
                SizedBox(
                  height: _appConfig.rH(10),
                ),
                v==false?Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: email,
                            decoration:
                            const InputDecoration(hintText: "User Email")),
                      ),
                      CustomBtn("Send OTP", 30, AppConfig.hotelColor,textColor: AppConfig.tripColor, onPressed: () async {

                        myauth.setConfig(
                          appEmail: "ahmedsubhan741@gmail.com",
                          appName: "Email Verification OTP",
                          userEmail: email.text.trim(),
                        );
                        if (await myauth.sendOTP() == true) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("OTP has been sent"),
                          ));
                          setState(() {
                            v = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Oops, OTP send failed"),
                          ));
                        }
                      },),
                      SizedBox(height: 10,)
                    ],
                  ),
                ):SizedBox(),
                // SizedBox(height: 20,),
                v==true?Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: otp,
                            decoration:
                            const InputDecoration(hintText: "Enter OTP")),
                      ),
                      CustomBtn("Verify", 30, AppConfig.hotelColor,textColor: AppConfig.tripColor,    onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("email", email.text);
                        if (await myauth.verifyOTP(otp: otp.text.trim()) == true) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => MaterialApp(        debugShowCheckedModeBanner: false,
                                    home: ChangePass())),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("OTP is verified"),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Invalid OTP"),
                          ));
                        }
                      },),
                      SizedBox(height: 10,)
                    ],
                  ),
                ):SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}