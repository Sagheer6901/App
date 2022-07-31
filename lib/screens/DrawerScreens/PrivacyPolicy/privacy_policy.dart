import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
        key: _scaffoldKey,
        // backgroundColor: AppConfig.secondaryColor,
        appBar: preferredSizeAppbar("FAQ's", context),
        // drawer: CustomDrawer.drawer(context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                (route) => false);
            return Future.value(false);
          },
          child: FAQBody(),
        ));
  }
}

class FAQBody extends StatefulWidget {
  @override
  _FAQBodyState createState() => _FAQBodyState();
}

class _FAQBodyState extends State<FAQBody> {
  late AppConfig _appConfig;

  bool faq0 = false;
  bool faq1 = false;
  bool faq2 = false;
  bool faq3 = false;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            height: _appConfig.rH(1),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "${AppConfig.dummyText}",
              style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular,height: 1.3),
              textScaleFactor: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              // color: AppConfig.secondaryColor,
              boxShadow: [
                BoxShadow(
                  color: AppConfig.queryBackground,
                  offset: Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                if (index == 0) {
                  if (faq0) {
                    setState(() {
                      faq0 = false;
                      faq1 = false;
                      faq2 = false;
                      faq3 = false;
                    });
                  } else {
                    setState(() {
                      faq0 = true;
                      faq1 = false;
                      faq2 = false;
                      faq3 = false;
                    });
                  }
                } else if (index == 1) {
                  if (faq1) {
                    setState(() {
                      faq0 = false;
                      faq1 = false;
                      faq2 = false;
                      faq3 = false;
                    });
                  } else {
                    setState(() {
                      faq0 = false;
                      faq1 = true;
                      faq2 = false;
                      faq3 = false;
                    });
                  }
                } else if (index == 2) {
                  if (faq2) {
                    setState(() {
                      faq0 = false;
                      faq1 = false;
                      faq2 = false;
                      faq3 = false;
                    });
                  } else {
                    setState(() {
                      faq0 = false;
                      faq1 = false;
                      faq2 = true;
                      faq3 = false;
                    });
                  }
                } else if (index == 3) {
                  if (faq3) {
                    setState(() {
                      faq0 = false;
                      faq1 = false;
                      faq2 = false;
                      faq3 = false;
                    });
                  } else {
                    setState(() {
                      faq0 = false;
                      faq1 = false;
                      faq2 = false;
                      faq3 = true;
                    });
                  }
                }
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'What is something?',
                        style: TextStyle(
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular
                        ),
                        textScaleFactor: 1,
                      ),
                    );
                  },
                  canTapOnHeader: true,
                  body: ListTile(
                    title: Padding(
                        padding: EdgeInsets.only(bottom: _appConfig.rH(1)),
                        child: Text(
                          "${AppConfig.dummyText}",
                          style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular,height: 1.3),
                          textScaleFactor: 1,
                        )),
                  ),
                  isExpanded: faq0,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'What is something?',
                        style: TextStyle(
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular
                        ),
                        textScaleFactor: 1,
                      ),
                    );
                  },
                  canTapOnHeader: true,
                  body: ListTile(
                    title: Padding(
                        padding: EdgeInsets.only(bottom: _appConfig.rH(1)),
                        child: Text(
                          "${AppConfig.dummyText}",
                          style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular,height: 1.3),
                          textScaleFactor: 1,
                        )),
                  ),
                  isExpanded: faq1,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'What is something?',
                        style: TextStyle(
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular
                        ),
                        textScaleFactor: 1,
                      ),
                    );
                  },
                  canTapOnHeader: true,
                  body: ListTile(
                    title: Padding(
                        padding: EdgeInsets.only(bottom: _appConfig.rH(1)),
                        child: Text(
                          "${AppConfig.dummyText}",
                          style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular,height: 1.3),
                          textScaleFactor: 1,
                        )),
                  ),
                  isExpanded: faq2,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'What is something?',
                        style: TextStyle(
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular
                        ),
                        textScaleFactor: 1,
                      ),
                    );
                  },
                  canTapOnHeader: true,
                  body: ListTile(
                    title: Padding(
                        padding: EdgeInsets.only(bottom: _appConfig.rH(1)),
                        child: Text(
                          "${AppConfig.dummyText}",
                          style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular,height: 1.3),
                          textScaleFactor: 1,
                        )),
                  ),
                  isExpanded: faq3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
