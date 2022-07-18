import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/screens/DrawerScreens/ContactUs/contact_us.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/contact_form.dart';
import 'package:untitled/screens/DrawerScreens/InviteFriends/invite_friends.dart';
import 'package:untitled/screens/DrawerScreens/Notifiations/notification_screen.dart';
import 'package:untitled/screens/DrawerScreens/PaymentScreens/add_payment_method.dart';
import 'package:untitled/screens/DrawerScreens/PrivacyPolicy/privacy_policy.dart';
import 'package:untitled/screens/DrawerScreens/Queries/AllChatScreen/all_chat_screen.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/chat_screen.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_screen.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/checkout.dart';
import 'package:untitled/services/services.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Profile/get_user_profile_data.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  UserProfile userProfile = UserProfile();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    fetchData();

  }

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
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
    prefs.setString("profileImage", userProfile.image.toString());
    prefs.setString("id", userProfile.id.toString());
    prefs.setString("name", userProfile.name.toString());
  }
  late AppConfig _appConfig;



  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(40.0),
            ),
            child: Drawer(
              backgroundColor: AppConfig.whiteColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration:  BoxDecoration(color: AppConfig.whiteColor),
                    child: Center(
                      child: Row(
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(
                            horizontal: 5,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child:  userProfile.name!=null?Text(
                                      '${userProfile.name}',
                                      style: TextStyle(fontSize: AppConfig.f3,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    ):Text(
                                      '--',
                                      style: TextStyle(fontSize: AppConfig.f3,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    ),
                                  ),
                                   userProfile.email!=null?Text('${userProfile.email}',style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,):Text('--',style: TextStyle(fontSize: AppConfig.f5),textScaleFactor: 1,),
                                ],
                              ),
                               Padding(
                                  padding: EdgeInsets.only(right: 25,left: 5),
                                  child: Container(
                                      height: _appConfig.rH(5),
                                      width: _appConfig.rH(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: AppConfig.carColor),
                                      child:
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                        child: userProfile.image!=null?Image.network(
                                          userProfile.image.toString().contains("http")?"${userProfile.image}":"${AppConfig.srcLink}${userProfile.image}",

                                          fit: BoxFit.cover,
                                        ):Center(child: Text("--",style: TextStyle(fontSize: AppConfig.f3),),
                                      )
                                  )
                              ),)
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),

                    child: ListTile(
                      title:  Text(
                        "Privacy",
                        style:
                            TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading:  const Icon(Icons.privacy_tip_outlined),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FAQ()),
                        );
                      },                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Payments",
                        style:
                            TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading: const Icon(Icons.payment),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPaymentMethod()),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Help center",
                        style:
                            TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading:  Icon(Icons.help_center_outlined),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen(chat: WebServices.productsStreamchat(),)),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => AllChatScreen()),
                        // );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Invite Friends",
                        style:
                            TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading: const Icon(Icons.insert_invitation),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InviteFriends()),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Notification",
                        style:
                            TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading:const Icon(Icons.notifications_none_outlined),


                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationScreen()),

                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: ListTile(
                  //     title:  Text(
                  //       "Settings",
                  //       style:
                  //           TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                  //     ),
                  //     trailing: const Image(
                  //       image: AssetImage('assets/images/arow.png'),
                  //       height: 15,
                  //       width: 15,
                  //     ),
                  //     leading: const Icon(Icons.settings),
                  //
                  //     onTap: () {},
                  //   ),
                  // ),
                  // const Divider(
                  //   indent: 80,
                  //   endIndent: 20,
                  //   height: 1,
                  //   thickness: 1,
                  //   color: Colors.grey,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Enquiry",
                        style:
                        TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading: const Icon(Icons.contact_page_outlined),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactForm()),

                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Contact Us",
                        style:
                        TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading: const Icon(Icons.contact_page_outlined),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),

                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(
                      title:  Text(
                        "Rate Us",
                        style:
                            TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      trailing: const Image(
                        image: AssetImage('assets/images/arow.png'),
                        height: 15,
                        width: 15,
                      ),
                      leading: const Icon(Icons.rate_review_outlined),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),

                        );
                      },                    ),
                  ),
                  const Divider(
                    indent: 80,
                    endIndent: 20,
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
