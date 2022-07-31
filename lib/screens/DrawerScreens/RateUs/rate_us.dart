import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class RateUs extends StatefulWidget {
  const RateUs({Key? key}) : super(key: key);

  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    double value = 3.5;

    return Scaffold(body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
                  (route) => false);
          return Future.value(false);
        },
        child: Container(
          child: Column(
            children: [
              Image.asset(
                "assets/images/traboon_logo.png",
                height: _appConfig.rH(20),
              ),
          Center(
            child: RatingStars(
              value: value,
              onValueChanged: (v) {
                //
                setState(() {
                  value = v;
                });
              },
              starBuilder: (index, color) => Icon(
                Icons.ac_unit_outlined,
                color: color,
              ),
              starCount: 5,
              starSize: 20,
              valueLabelColor: const Color(0xff9b9b9b),
              valueLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              valueLabelRadius: 10,
              maxValue: 5,
              starSpacing: 2,
              maxValueVisibility: true,
              valueLabelVisibility: true,
              animationDuration: Duration(milliseconds: 1000),
              valueLabelPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              valueLabelMargin: const EdgeInsets.only(right: 8),
              starOffColor: const Color(0xffe7e8ea),
              starColor: Colors.yellow,
            ),
          ),

            ],
          ),
        )));
  }
}
