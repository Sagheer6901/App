import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/plans.dart';

class CurveItemCard extends StatefulWidget {
  final Plans item;
  final Future<List<Plans>>? products;
  CurveItemCard({Key? key, this.products, required this.item}) : super(key: key);

  @override
  _CurveItemCardState createState() => _CurveItemCardState();
}

class _CurveItemCardState extends State<CurveItemCard> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Container(
      margin: EdgeInsets.all(10),
      // height: _appConfig.rH(5),
      width: _appConfig.rW(36),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // boxShadow: [
        //   BoxShadow(
        //     // color: AppConfig.shadeColor,
        //     offset: Offset(0, 5),
        //     blurRadius: 10,
        //   ),
        // ],
      ),
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(200),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          color: AppConfig.tripColor,
          boxShadow: [
            BoxShadow(
              color: AppConfig.tripColor,
              offset: Offset(0, 5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(_appConfig.rHP(2.5)),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _appConfig.rH(2.5),
                  ),
                  Text("${widget.item.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: AppConfig.f4,color: AppConfig.whiteColor,                          fontFamily: AppConfig.fontFamilyRegular
                  ),textScaleFactor: 1,),
                  SizedBox(
                    height: _appConfig.rH(1),
                  ),
                  Text("${widget.item.title}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: AppConfig.f4,color: AppConfig.hotelColor,                          fontFamily: AppConfig.fontFamilyRegular
                  ),textScaleFactor: 1,),
                  SizedBox(
                    height: _appConfig.rH(0.5),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("${widget.item.description}",style: TextStyle(color: AppConfig.whiteColor,fontSize: AppConfig.f5,                          fontFamily: AppConfig.fontFamilyRegular
                  ),textScaleFactor: 1,),
                  SizedBox(
                    height: _appConfig.rH(0.5),
                  ),
                ],
              ),
              FittedBox(
                child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(" Rs. ",style: TextStyle(color: AppConfig.whiteColor),),
                    Text("${widget.item.price}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: AppConfig.f4,color: AppConfig.carColor,fontFamily: AppConfig.fontFamilyMedium
                    ),textScaleFactor: 1,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
