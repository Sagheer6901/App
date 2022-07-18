import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/DrawerScreens/PaymentScreens/payment_methods.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({Key? key}) : super(key: key);

  @override
  _AddPaymentMethodState createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
        appBar: preferredSizeAppbar("Payment Method", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                (route) => false);
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _appConfig.rH(15),
                  ),
                  SvgPicture.asset(
                    "assets/images/online_payment.svg",
                    height: _appConfig.rH(20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Payment Methods",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConfig.f2,
                          color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyMedium)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add your payment options to make bookings even faster",
                    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomBtn(
                      "Add a new payment method", 80, AppConfig.hotelColor,
                      textSize: AppConfig.f4,
                      textColor: AppConfig.tripColor,
                      height: 50, onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentMethods()),
                    );
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
