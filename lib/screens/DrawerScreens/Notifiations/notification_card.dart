import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/functions/app_config.dart';

class NotificationCard extends StatelessWidget {
  String? msgTitle,description;
  Color color;
  Function onPressed;
  NotificationCard({Key? key,this.msgTitle,this.description,required this.color,required this.onPressed}) : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return              InkWell(
      onTap: (){
        onPressed();
      },
      child: Column(
        children: [
          Container(
            color: color,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
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
                          Text("${msgTitle}",style: TextStyle(fontSize: AppConfig.f4,fontWeight: FontWeight.w700, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),),
                          Text("${description}",style: TextStyle(fontSize: AppConfig.f5,fontWeight: FontWeight.w500, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),),

                          // Expanded(
                          //   child: Container(
                          //     width: _appConfig.rW(50),
                          //     child: RichText(
                          //       overflow: TextOverflow.ellipsis,
                          //       strutStyle: StrutStyle(fontSize: 12.0),
                          //       text: TextSpan(
                          //           style: TextStyle(color: AppConfig.textColor),
                          //           text: '${AppConfig.dummyReview}'),
                          //     ),
                          //   ),
                          // )
                          // Row(
                          //   children: [
                          //     Text("9h ago",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                          //     Text("  .  "),
                          //     Text('Blog',style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),)
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
