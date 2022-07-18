import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/screens/DrawerScreens/Queries/AllChatScreen/query_card.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

class AllChatScreen extends StatefulWidget {
  const AllChatScreen({Key? key}) : super(key: key);

  @override
  _AllChatScreenState createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    return Scaffold(
      backgroundColor: AppConfig.tripColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(25)), // Set this height
        child: SafeArea(
          child:Container(
              height: _appConfig.rH(30),
              padding: EdgeInsets.only(
                  left: _appConfig.rWP(5), right: _appConfig.rHP(5), top: _appConfig.rWP(5),bottom: _appConfig.rWP(5)),
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
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_none,
                            size: 30,
                            color: Colors.white,
                          ),
                          PopUp(),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "CHATS",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
          child: Container(
            height: _appConfig.rH(72),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: AppConfig.whiteColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: ListView(
                children: [
                QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),
                  QueryCard(),

                ],
              )),
        ),
      ),
    );
  }
}
