import 'package:flutter/cupertino.dart' hide Notification;
import 'package:flutter/material.dart' hide Notification;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/notification_pop_menu.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/models/notification.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/chat_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:untitled/services/services.dart';


// Widget notIcon(){
//   return           numOfNot==null?        IconButton(
//     icon: Icon(
//       Icons.notifications_none,
//       size: _appConfig.rH(3),
//       color: Colors.white,
//     ), onPressed: () {
//
//   },
//   ):                   IconButton(
//     icon: Icon(
//       Icons.,
//       size: _appConfig.rH(3),
//       color: Colors.white,
//     ), onPressed: () {
//   },
//   )
//   ;
//
// }
late AppConfig _appConfig;

class NotIcon extends StatefulWidget {
  const NotIcon({Key? key}) : super(key: key);

  @override
  _NotIconState createState() => _NotIconState();
}

class _NotIconState extends State<NotIcon> {
   late AppConfig _appConfig;
   List<dynamic> items = [];

   // getNotCountCustomerSupportNot()async{
   //   List<String> item=[];
   //   SharedPreferences prefs = await SharedPreferences.getInstance();
   //   return WebServices.productsCustomerSupportNotification().first.then((categories) {
   //     if (prefs.containsKey('notification_count')) {
   //       oldChatCount = prefs.getInt('notification_count')!;
   //     }
   //     // _categories = categories;
   //     categories. forEach((element){
   //       item.add("${element.notiCount}");
   //       // print("${element.title}");
   //     });
   //
   //     print("list of item $item");
   //     items = item;
   //     print("list of items ${items[0][1]}");
   //   });
   // }
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return StreamBuilder<List<Notification>>(
      stream: WebServices.productsNotification(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? Stack(children: <Widget>[
             IconButton(
                  iconSize: _appConfig.rH(3),
                  color: AppConfig.hotelColor,
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => NotificationPopUp()),
                    // );
                    // setState(() {
                    //   oldCount = 0;
                    // }
                    // );
                  }),
            oldChatCount != 0 || oldEnquiryCount!=0
                  ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '${oldChatCount+oldEnquiryCount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            )
                  : new Container()
        ])
            : Center(child: Container());

        // return the ListView widget :
        //     : Center(child: CircularProgressIndicator());
      },
    );

    // return Stack(children: <Widget>[
    //       IconButton(
    //           iconSize: _appConfig.rH(3),
    //           color: AppConfig.hotelColor,
    //           icon: Icon(Icons.notifications),
    //           onPressed: () {
    //             setState(() {
    //               oldCount = 0;
    //             });
    //           }),
    //       oldCount != 0
    //           ? new Positioned(
    //         right: 11,
    //         top: 11,
    //         child: new Container(
    //           padding: EdgeInsets.all(2),
    //           decoration: new BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.circular(6),
    //           ),
    //           constraints: BoxConstraints(
    //             minWidth: 14,
    //             minHeight: 14,
    //           ),
    //           child:StreamBuilder<List<Notification>>(
    // stream: WebServices.productsNotification(),
    // builder: (context, snapshot) {
    //   if (snapshot.hasError) print(snapshot.error);
    //   return Text(
    //     '${snapshot.data!.first.notiCount}',
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 8,
    //     ),
    //     textAlign: TextAlign.center,
    //   );
    // }
    //           ),
    //         ),
    //       )
    //           : new Container()
    //     ]);

  }
}

PreferredSizeWidget preferredSizeAppbar(title, context) {
  _appConfig = AppConfig(context);

  return PreferredSize(
    preferredSize: Size.fromHeight(_appConfig.rH(15)), // Set this height
    child: SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: _appConfig.rWP(5), vertical: _appConfig.rHP(5)),
          decoration: BoxDecoration(
              color: AppConfig.tripColor,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationScreen()),
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppConfig.whiteColor,
                  size: _appConfig.rH(3),
                ),
              ),
              Text(
                "$title",
                style: TextStyle(
                    fontSize: AppConfig.f2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,fontFamily: AppConfig.fontFamilyRegular),
                textScaleFactor: 1,
              ),
              Row(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.notifications_none,
                  //     size: _appConfig.rH(3),
                  //     color: Colors.white,
                  //   ),
                  //   onPressed: () {
                  //     FlutterRingtonePlayer.play(
                  //       android: AndroidSounds.notification,
                  //       ios: IosSounds.glass,
                  //       // looping: true,
                  //       volume: 1.0,
                  //     );
                  //   },
                  // ),

                  // NotIcon(),
                  NotificationPopUp(),
                  PopUp(),
                ],
              ),
            ],
          )),
    ),
  );
}
