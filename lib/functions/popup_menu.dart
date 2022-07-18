import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/google_auth.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/NavigationScreens/map.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_place.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/OrderHistory/order_history.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/PaymentHistoryScreen/payment_history.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/profile_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list.dart';
import 'package:untitled/services/services.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../screens/NavigationScreens/mapLocation/live_location.dart';

class PopUp extends StatefulWidget {
  final Widget? icon;

  const PopUp({Key? key, this.icon}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  bool _isSigningOut = false;
  void initState() {
    super.initState();
    fetchData();
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  UserProfile userProfile = UserProfile();

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var url = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_profile&user_email=$email");
    var response = await http.get(url);
    if (this.mounted) {
      setState(() {
        print("Hello  $response");
        final jsonresponse = json.decode(response.body);

        userProfile = UserProfile.fromJson(jsonresponse[0]);
        // userProfile = UserProfile.fromJson(json.decode(response.body));
        print(userProfile);
        // loading = false;
      });
    }

    prefs.setString("profileImage", userProfile.image.toString());
    prefs.setString("id", userProfile.id.toString());
    prefs.setString("name", userProfile.name.toString());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            itemBuilder: ((context) => [

                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(
                        CupertinoIcons.person,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.message),
                      title: Text(
                        'Blogs',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyBlogs()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.car_rental),
                      title: Text(
                        'Car',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VehicleList(

                                  )),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(
                        Icons.hotel,
                      ),
                      title: Text(
                        'Hotel',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HotelList()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(
                        'Guide',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuideList()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.trip_origin),
                  title: Text(
                    'Trip',
                    style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                    textScaleFactor: 1,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripList()),
                    );
                  },
                ),
              ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.map),
                      title: Text(
                        'Map',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>       MapLocation()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(
                        CupertinoIcons.list_dash,
                      ),
                      title: Text(
                        'Wish List',
                        style: TextStyle(fontSize: AppConfig.f4),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishList(
                                  )),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(
                        Icons.reorder_sharp,
                      ),
                      title: Text(
                        'Order History',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistoryList()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                    ),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      setState(() {
                        _isSigningOut = true;
                      });
                      await Authentication.signOut(context: context);
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context)
                          .pushReplacement(_routeToSignInScreen());
                    },
                  ),
                ]),
            icon: Container(
              height: 100.0,
              width: 100.0,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: AppConfig.carColor),
              child:                                       ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: userProfile.image!=null?Image.network(
                    userProfile.image.toString().contains("http")?"${userProfile.image}":"${AppConfig.srcLink}${userProfile.image}",

                    fit: BoxFit.cover,
                  ):Center(child: Text("--",style: TextStyle(fontSize: AppConfig.f3),),
                  )
              )

            )
        ));
  }
}
