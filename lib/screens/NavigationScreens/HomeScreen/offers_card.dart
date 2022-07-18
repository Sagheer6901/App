import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';

class OfferCards extends StatelessWidget {
  OfferCards({Key? key}) : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Stack(
      children: [
        Container(
          // height: _appConfig.rH(22),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(10),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: AppConfig.tripColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            "${AppConfig.srcLink}t.png",
                            height: _appConfig.rH(15),
                            width: _appConfig.rW(20),
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      width: _appConfig.rW(2),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: 'Flat 20% Discount* on ',
                            style: TextStyle(
                                color: AppConfig.tripColor,
                                fontSize: AppConfig.f4,
                                fontFamily: AppConfig.fontFamilyRegular),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Photography Trip',
                                style: TextStyle(
                                    color: AppConfig.tripColor,
                                    fontSize: AppConfig.f3,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppConfig.fontFamilyMedium),
                              ),
                              TextSpan(
                                text:
                                    '\n\nExclusive offer* for PAK Bank Credit Carde',
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: _appConfig.rH(1),
                            ),
                            Text(
                              'Swat',
                              style: TextStyle(
                                  fontSize: AppConfig.f3,
                                  fontWeight: FontWeight.bold,
                                  color: AppConfig.carColor,
                                  fontFamily: AppConfig.fontFamilyMedium),
                              textScaleFactor: 1,
                            ),
                            SizedBox(
                              height: _appConfig.rH(0.5),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: _appConfig.rH(2),
                                  color: AppConfig.textColor,
                                ),
                                Text(
                                  "Swat,Pakistan",
                                  style: TextStyle(
                                      color: AppConfig.textColor,
                                      fontFamily: AppConfig.fontFamilyRegular),
                                  textScaleFactor: 1,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            right: _appConfig.rW(8),
            bottom: _appConfig.rH(3),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Know More>>',
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: AppConfig.tripColor,
                      fontFamily: AppConfig.fontFamilyRegular),
                )))
      ],
    );

    // return GestureDetector(
    //     onTap: () {},
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           top: 10,
    //           left: 15,
    //           child: Container(
    //             height: _appConfig.rH(25),
    //             width: 300,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(20.0),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.withOpacity(0.3),
    //                   spreadRadius: 2,
    //                   blurRadius: 7,
    //                   offset: const Offset(2, 5),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: 15,
    //           left: 25,
    //           child: Card(
    //             color: Colors.green,
    //             elevation: 10.0,
    //             shadowColor: Colors.grey.withOpacity(0.5),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(20.0),
    //             ),
    //             child: Container(
    //               height: 130,
    //               width: 100,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 image: const DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: const AssetImage('assets/images/Untitled-18.png'),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: 30,
    //           left: 140,
    //           child: Container(
    //             height: 150,
    //             width: 180,
    //             child: RichText(
    //               text:  TextSpan(
    //                   text: 'Flat 20% Discount* on ',
    //                   style: TextStyle(
    //                     color: AppConfig.tripColor,
    //                     fontSize: AppConfig.f5,
    //                   ),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: 'Photography Trip',
    //                       style: TextStyle(
    //                           color: AppConfig.tripColor,
    //                           fontSize: AppConfig.f4,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                     TextSpan(
    //                       text: '\n\nExclusive offer* for PAK Bank Credit Carde',
    //                       style: TextStyle(
    //                         color: AppConfig.textColor,
    //                         fontSize: AppConfig.f5,
    //                       ),
    //                     ),
    //                   ]),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: 155,
    //           left: 30,
    //           child: RichText(
    //             text:  TextSpan(
    //               text: 'Swat',
    //               style: TextStyle(
    //                 color: AppConfig.carColor,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: AppConfig.f2,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           top: 170,
    //           left: 25,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Row(
    //                 children: [
    //                   Icon(
    //                     Icons.location_on_outlined,
    //                     size: 20,
    //                     color: AppConfig.textColor,
    //                   ),
    //                    Text('Swat, Pakistan',style: TextStyle(color: AppConfig.textColor)),
    //                   const SizedBox(
    //                     width: 50,
    //                   ),
    //
    //                 ],
    //
    //               ),
    //               TextButton(onPressed: () {}, child:  Text('Know More>>',style: TextStyle(color: AppConfig.tripColor),))
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
