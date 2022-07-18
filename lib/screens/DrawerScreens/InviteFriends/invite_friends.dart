import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/DrawerScreens/PaymentScreens/payment_methods.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
        appBar: preferredSizeAppbar("Invite Friends", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                    (route) => false);
            return Future.value(false);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/traboon_logo.png",
                  height: _appConfig.rH(20),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Invite Friends",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppConfig.f2,
                        color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyMedium)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Share the app with others to help grow our Traboon community",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontFamily: AppConfig.fontFamilyMedium),
                ),
                SizedBox(
                  height: _appConfig.rH(2),
                ),
                CustomBtn(
                    "Invite", 30, AppConfig.hotelColor,
                    textSize: AppConfig.f4,
                    textColor: AppConfig.tripColor,
                    height: 50, onPressed: () async {
                  await Share.share('check out our app https://play.google.com/store/apps/', subject: 'Look what I made!');
                  //copy the app link from PC by opening app
                },),
              ],
            ),
          ),
        ));
  }
}
