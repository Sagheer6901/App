import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/google_auth.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/all_my_requests.dart';
import 'package:untitled/screens/DrawerScreens/Notifiations/notification_card.dart';
import 'package:untitled/screens/DrawerScreens/Notifiations/notification_screen.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/chat_screen.dart';
import 'package:untitled/screens/NavigationScreens/map.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_place.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/PaymentHistoryScreen/payment_history.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/profile_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list.dart';
import 'package:untitled/services/services.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationPopUp extends StatefulWidget {
  final Widget? icon;

  const NotificationPopUp({Key? key, this.icon}) : super(key: key);

  @override
  State<NotificationPopUp> createState() => _NotificationPopUpState();
}

class _NotificationPopUpState extends State<NotificationPopUp> {

  void initState() {
    super.initState();
  }

  streamNotification(){
    return WebServices.productsNotification();
  }


  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: PopupMenuButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            itemBuilder: ((context) => [

              PopupMenuItem(
                child: Column(
                  children: [
                    ListTile(
                      leading:  CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/user.png',
                        ),
                        maxRadius: 20,
                      ),
                      title: Text(
                        ' New messages in Enquiry from Admin',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationScreen()),
                        );
                      },
                    ),
                    Divider(
                      thickness: 2,
                    )
                  ],
                ),
              ),

              PopupMenuItem(
                child: ListTile(
                  leading:  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/user.png',
                    ),
                    maxRadius: 20,
                  ),
                  title: Text(
                    ' New messages in Chat from Admin',
                    style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                    textScaleFactor: 1,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreen()),
                    );
                  },
                ),
              ),

            ]),
            icon: Container(child: NotIcon())
        ));
  }
}
