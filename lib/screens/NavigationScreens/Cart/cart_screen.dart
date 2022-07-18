import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/completion_alert_box.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/functions/text_field.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_card.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/checkout.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';

import '../../DrawerScreens/PaymentScreens/payment_methods.dart';

enum PaymentsMethods { paypal, jazzcash, easypaisa }


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PaymentsMethods _method = PaymentsMethods.paypal;
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
        appBar: PreferredSize(
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
                      "Cart",
                      style: TextStyle(
                          fontSize: AppConfig.f2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textScaleFactor: 1,
                    ),
                    Container()
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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: _appConfig.rH(65),
                    child: ListView(
                      children: [
                        CartCard(),
                        CartCard(),
                        CartCard(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",style: TextStyle(fontSize: AppConfig.f3, color: AppConfig.tripColor),),
                        Text("\$730",style: TextStyle(fontSize: AppConfig.f3, color: AppConfig.tripColor),),

                      ],
                    ),
                  ),
                  CustomBtn("Checkout", 40, AppConfig.hotelColor,textSize: AppConfig.f4,textColor: AppConfig.tripColor,height: 40,onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOut()),
                    );
                  },)
                ],
              ),
            ),
          ),
        ));
  }
}






