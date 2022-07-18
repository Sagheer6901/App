import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';

class CompletionAlertBox extends StatelessWidget {
  final String? title;
  final String? description;
  final IconData? iconName;
  final String? buttonText;
  final Function()? onPressed;

  CompletionAlertBox({
    this.title,
    this.description,
    this.iconName,
    this.buttonText,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                title.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConfig.tripColor,
                  fontFamily: AppConfig.fontFamilyRegular
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                description.toString(),
                style: TextStyle(
                  decorationStyle: TextDecorationStyle.wavy,
                  fontFamily: AppConfig.fontFamilyRegular
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomBtn(
              buttonText,
              30,
              AppConfig.hotelColor,
              textColor: AppConfig.tripColor,
              iconName: iconName,
              onPressed: onPressed,
              height: 30,
            ),
          ],
        ),
      )
    ]);
  }
}
