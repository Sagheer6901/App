import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/completion_alert_box.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/functions/text_field.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
        appBar: preferredSizeAppbar("Payment", context),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment methods",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConfig.f3,
                            color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyMedium),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "This will help to book your services even faster",
                        style: TextStyle(fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyMedium),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => CardPayments()),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/mastercard.png"),
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Mastercard",style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),),
                                ],
                              ),
                              Icon(
                                Icons.more_horiz,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => CardPayments()),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/visa.png"),
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Visa Card",style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),),
                                ],
                              ),
                              Icon(
                                Icons.more_horiz,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => JazzcashOrEasyPaisa()),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/jazzcash.png"),
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Jazzcash",style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),),
                                ],
                              ),
                              Icon(
                                Icons.more_horiz,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => JazzcashOrEasyPaisa()),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "assets/images/easypaisa.png"),
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Easypaisa",style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),),
                                ],
                              ),
                              Icon(
                                Icons.more_horiz,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CardPayments extends StatefulWidget {
  const CardPayments({Key? key}) : super(key: key);

  @override
  _CardPaymentsState createState() => _CardPaymentsState();
}

class _CardPaymentsState extends State<CardPayments> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
        appBar: preferredSizeAppbar("Payment", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethods()),
                (route) => false);
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Card(
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                elevation: 18.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/online_payment.svg",
                      height: _appConfig.rH(20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      text: 'Card Number',
                      verticalMargin: 5,
                      horizontalMargin: 40,
                      suffixIcon: Icon(
                        Icons.credit_card,
                        color: AppConfig.tripColor,
                      ),
                      validator: (String? name) {
                        if (name!.isEmpty) {
                          return "Name can't be empty!";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      text: 'Card Holder Name',
                      verticalMargin: 5,
                      horizontalMargin: 40,
                      suffixIcon: Icon(
                        Icons.person,
                        color: AppConfig.tripColor,
                      ),
                      validator: (String? name) {
                        if (name!.isEmpty) {
                          return "Name can't be empty!";
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            text: 'Expiry',
                            verticalMargin: 5,
                            horizontalMargin: 40,
                            validator: (String? name) {
                              if (name!.isEmpty) {
                                return "Name can't be empty!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            text: 'CVV',
                            verticalMargin: 5,
                            horizontalMargin: 40,
                            validator: (String? name) {
                              if (name!.isEmpty) {
                                return "Name can't be empty!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomBtn(
                        'Add Payment Method',
                        60,
                        AppConfig.hotelColor,
                        textColor: AppConfig.tripColor,
                        iconName: Icons.payments,
                        height: 50,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CompletionAlertBox(
                                title: "Payment Activated!",
                                description:
                                    "Payment Method has been activated successfully, Now you can order anytime.",
                                iconName: Icons.explore,
                                buttonText: "Explore",
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => PaymentMethods()),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class JazzcashOrEasyPaisa extends StatefulWidget {
  const JazzcashOrEasyPaisa({Key? key}) : super(key: key);

  @override
  _JazzcashOrEasyPaisaState createState() => _JazzcashOrEasyPaisaState();
}

class _JazzcashOrEasyPaisaState extends State<JazzcashOrEasyPaisa> {
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
        appBar: preferredSizeAppbar("Payment", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethods()),
                (route) => false);
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Card(
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/online_payment.svg",
                      height: _appConfig.rH(20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      verticalMargin: 5,
                      horizontalMargin: 40,
                      text: 'Mobile Number',
                      suffixIcon: Icon(
                        Icons.credit_card,
                        color: AppConfig.tripColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomBtn(
                        'Add Payment Method',
                        60,
                        AppConfig.hotelColor,
                        textColor: AppConfig.tripColor,
                        iconName: Icons.payments,

                        height: 50,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CompletionAlertBox(
                                title: "Payment Activated!",
                                description:
                                    "Payment Method has been activated successfully, Now you can order anytime.",
                                iconName: Icons.explore,
                                buttonText: "Explore",
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => PaymentMethods()),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
