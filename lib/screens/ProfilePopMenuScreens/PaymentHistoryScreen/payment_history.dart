import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_appConfig.rH(40)), // Set this height
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Column(
                  children: <Widget>[
                    Container(
                      color: AppConfig.tripColor,

                      // decoration: new BoxDecoration(
                      //   color: AppConfig.tripColor,
                      //   borderRadius: BorderRadius.vertical(
                      //       bottom: Radius.elliptical(
                      //           _appConfig.rW(100), 250.0)),
                      // ),
                      height: _appConfig.rH(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: _appConfig.rWP(5),right: _appConfig.rWP(5), top: _appConfig.rHP(5)),                            child: Row(
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
                                    size: _appConfig.rH(3),
                                  ),
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,fontFamily: AppConfig.fontFamilyRegular),
                                ),
                                Row(
                                  children: [
                                    NotIcon(),

                                    PopUp(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Center(
                              child: Text(
                                "Payment History",
                                style: TextStyle(
                                    fontSize: AppConfig.f2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),textScaleFactor: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Profile image
                Positioned(
                  top:
                      150.0, // (background container size) - (circle height / 2)
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Container(
                            height: _appConfig.rH(12),
                            width: _appConfig.rW(43),
                            decoration: BoxDecoration(
                              color: AppConfig.whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "20000",
                                  style: TextStyle(
                                      color: AppConfig.tripColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                ),
                                Text(
                                  "can Dominate",
                                  style: TextStyle(color: AppConfig.textColor,fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Container(
                            height: _appConfig.rH(12),
                            width: _appConfig.rW(43),
                            decoration: BoxDecoration(
                              color: AppConfig.whiteColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "20000",
                                  style: TextStyle(
                                      color: AppConfig.tripColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                ),
                                Text(
                                  "can Dominate",
                                  style: TextStyle(color: AppConfig.textColor,fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                  // height: 150,
                  //alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: _appConfig.rH(1), horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: _appConfig.rH(45),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: AppConfig.shadeColor,
                              offset: Offset(0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                                height: _appConfig.rH(12),
                                width: double.infinity,
                                // margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppConfig.whiteColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Amount",
                                          style: TextStyle(
                                              color: AppConfig.tripColor,
                                              fontWeight: FontWeight.w300,
                                              fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                        ),
                                        Text(
                                          "345,454 people joined",
                                          style: TextStyle(
                                              color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                        )
                                      ],
                                    ),
                                    Text(
                                      "81.6%",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    )
                                  ],
                                )),
                            Container(
                                height: _appConfig.rH(8),
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppConfig.shadeColor,
                                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    ),
                                    Text(
                                      "\$813",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    )
                                  ],
                                )),
                            Container(
                                height: _appConfig.rH(8),
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppConfig.shadeColor,
                                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    ),
                                    Text(
                                      "\$813",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    )
                                  ],
                                )),
                            Container(
                                height: _appConfig.rH(8),
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppConfig.shadeColor,
                                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    ),
                                    Text(
                                      "\$813",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    )
                                  ],
                                )),
                            Container(
                                height: _appConfig.rH(8),
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppConfig.shadeColor,
                                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    ),
                                    Text(
                                      "\$813",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppConfig.f2,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      // CustomBtn("Edit Profile", 60, AppConfig.hotelColor,height: 40,textColor: AppConfig.tripColor,textSize: AppConfig.f3,)
                    ],
                  )),
            ],
          )),
        ),
      drawer: const MyDrawer(),
    );
  }
}
