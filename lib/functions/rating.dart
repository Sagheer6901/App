import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';

class Rating extends StatelessWidget {
  String? service;
  String? organization;
  String? friendliness;
  String? areaExpert;
  String? safety;
  String? totalRate;
   Rating({Key? key,this.service,this.organization,this.friendliness,this.areaExpert,this.safety}) : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    totalRate = ((double.parse(service.toString())+double.parse(organization.toString())+double.parse(friendliness.toString())+double.parse(areaExpert.toString())+double.parse(safety.toString()))/5).roundToDouble().toString();

    print(" ser $service");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: AppConfig.shadeColor),
                  color: AppConfig.whiteColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: _appConfig.rW(28),
                      child: Text("Service",style:TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),

                      decoration: BoxDecoration(
                        color: AppConfig.shadeColor,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                      ),
                      child: Text("${service}".substring(0,3),textScaleFactor: 1),
                    )
                  ],
                )
              ),
              SizedBox(
                width: _appConfig.rW(2),
              ),
              Container(
                // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConfig.shadeColor),
                    color: AppConfig.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: _appConfig.rW(28),
                        child: Text("Organization",style:TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),

                        decoration: BoxDecoration(
                          color: AppConfig.shadeColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        ),
                        child: Text("${organization}".substring(0,3),textScaleFactor: 1),
                      )
                    ],
                  )
              ),

            ],
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConfig.shadeColor),
                    color: AppConfig.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: _appConfig.rW(28),
                        child: Text("Friendliness",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),

                        decoration: BoxDecoration(
                          color: AppConfig.shadeColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        ),
                        child: Text("${friendliness}".substring(0,3),textScaleFactor: 1),
                      )
                    ],
                  )
              ),
              SizedBox(
                width: _appConfig.rW(2),
              ),
              Container(
                // padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConfig.shadeColor),
                    color: AppConfig.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: _appConfig.rW(28),
                        child: Text("Area Expert",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),

                        decoration: BoxDecoration(
                          color: AppConfig.shadeColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        ),
                        child: Text("${areaExpert}".substring(0,3),textScaleFactor: 1),
                      )
                    ],
                  )
              ),

            ],
          ),
          SizedBox(
            height: _appConfig.rH(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConfig.shadeColor),
                    color: AppConfig.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
              child: Center(child: Text(" ${totalRate}", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)),
              ),
              SizedBox(
                width: _appConfig.rW(2),
              ),
              Container(
                // margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppConfig.shadeColor),
                    color: AppConfig.whiteColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: _appConfig.rW(28),
                        child: Text("Safety",textScaleFactor: 1),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),

                        decoration: BoxDecoration(
                          color: AppConfig.shadeColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        ),
                        child: Text("${safety}".substring(0,3),textScaleFactor: 1),
                      )
                    ],
                  )
              ),

            ],
          )

        ],
      ),
    );
  }
}
