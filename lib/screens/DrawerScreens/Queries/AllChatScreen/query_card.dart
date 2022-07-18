import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/functions/app_config.dart';

class QueryCard extends StatelessWidget {
  QueryCard({Key? key}) : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return              Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        height: _appConfig.rH(10),
        width: double.infinity,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(5)),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black12,
        //       offset: Offset(0, 2),
        //       blurRadius: 5,
        //     ),
        //   ],
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/user.png',
                  ),
                  maxRadius: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("New User",style: TextStyle(fontSize: AppConfig.f4,fontWeight: FontWeight.w700, color: AppConfig.tripColor),),
                      Expanded(
                        child: Container(
                          width: _appConfig.rW(50),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                                style: TextStyle(color: AppConfig.textColor),
                                text: '${AppConfig.dummyReview}'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.nature_sharp,color: AppConfig.textColor,),
                Text("data",style: TextStyle(color: AppConfig.textColor)),
              ],
            )
          ],
        ));
  }
}
