
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/all_my_requests.dart';
import 'package:untitled/screens/DrawerScreens/Notifiations/notification_card.dart';
import 'package:untitled/screens/DrawerScreens/Queries/AllChatScreen/query_card.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/chat_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
        appBar: preferredSizeAppbar("Notifications", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                    (route) => false);
            return Future.value(false);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                //   width: double.infinity,
                //   alignment: Alignment.center,
                child: TabBar(
                      // isScrollable: true,
                      controller: _tabController,
                      unselectedLabelColor: AppConfig.tripColor,
                      labelColor: AppConfig.tripColor,
                      indicatorWeight: 2,
                      indicatorColor: AppConfig.carColor,
                      // indicator: ShapeDecoration(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(30))),
                      //     color: AppConfig.tripColor),
                    tabs: <Widget>[
                  Tab(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Unread",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                      SizedBox(width: _appConfig.rW(2),),
                      // Container(
                      //   padding: EdgeInsets.all(2),
                      //   decoration: new BoxDecoration(
                      //     color: Colors.red,
                      //     borderRadius: BorderRadius.circular(6),
                      //   ),
                      //   constraints: BoxConstraints(
                      //     minWidth: 14,
                      //     minHeight: 14,
                      //   ),
                      //   child: Text(
                      //     '2',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 8,
                      //     ),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // )
                    ],
                  ),),
                  Tab(child: Center(child: Text("All Read",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),)),)
                ]),
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      ListView(
                        children: [
                          oldChatCount!=0?NotificationCard(description: "New Messages from Admin",msgTitle: "Chat",color: AppConfig.queryBackground,onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatScreen()),
                            );
                          },):SizedBox(),
                          oldEnquiryCount!=0?NotificationCard(description: "New Messages on your Ticket",msgTitle: "Enquiry",color: AppConfig.queryBackground,onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllRequests(    products: WebServices
                                  .getGetTickets(),)),
                            );
                          },):SizedBox(),
                        ],
                      ),
                      ListView(
                        children: [
                          NotificationCard(description: "Admin sent you message",msgTitle: "Chat",color: AppConfig.shadeColor.withOpacity(0.3),onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatScreen()),
                            );
                          },),
                          NotificationCard(description: "Admin sent you message",msgTitle: "Enquiry",color: AppConfig.shadeColor.withOpacity(0.3),onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllRequests(    products: WebServices
                                  .getGetTickets(),)),
                            );
                          },)
                        ],
                      )

                ]),
              )
            ],
          ),
        ));
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('_tabController', _tabController));
  }
}



