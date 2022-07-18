import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';

class CustomBtn extends StatelessWidget {
  var text;
  Color? textColor;
  double width;
  double? height;
  final Function()? onPressed;
  Color color;
  final IconData? iconName;
  double? textSize;
  CustomBtn(this.text, this.width, this.color,
      {this.textSize,
      this.textColor,
      this.iconName,
      this.height,
      this.onPressed,
      Key? key})
      : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _appConfig.rW(1)),
        alignment: Alignment.center,
        height: height ?? 30,
        width: _appConfig.rW(width),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconName != null)
              Row(
                children: [
                  Icon(
                    iconName,
                    color: AppConfig.tripColor,
                  ),
                  SizedBox(
                    width: _appConfig.rH(0.6),
                  )
                ],
              )
            else
              SizedBox(
                width: _appConfig.rH(0.6),
              ),
            Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize ?? AppConfig.f5,
                    color: textColor ?? AppConfig.whiteColor,
                    fontWeight: FontWeight.w500,fontFamily: AppConfig.fontFamilyMedium),textScaleFactor: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
