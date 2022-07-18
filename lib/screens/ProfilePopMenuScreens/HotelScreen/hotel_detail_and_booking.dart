import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/functions/rating.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/Categories/review_hotel.dart';
import 'package:untitled/models/hotel_rooms.dart';
import 'package:untitled/screens/NavigationScreens/map.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/review_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_place.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/room_details_card.dart';

import 'package:untitled/services/services.dart';

class HotelDetailAndBooking extends StatefulWidget {
  final HotelModel? item;
  final Future<List<HotelModel>>? products;
  final Future<List<HotelReview>>? reviews;
  HotelDetailAndBooking({Key? key, this.reviews, this.products, this.item})
      : super(key: key);
  @override
  _HotelDetailAndBookingState createState() => _HotelDetailAndBookingState();
}

class _HotelDetailAndBookingState extends State<HotelDetailAndBooking>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  dynamic? rooms;
      var limit=7;
  List<String> items = [];

  String? service;
  String? organization;
  String? friendliness;
  String? areaExpert;
  String? safety;
  String? totalRate;

  getHotelRooms(){
    return WebServices.hotelRoomsItems(widget.item!.id);
  }
  getHotelRating() async {
    // isLoading = true;
    await WebServices.hotelRating(widget.item!.id).then((ratings) {
      for(var element in ratings){
        print("servicesss: ${element.service}");
        setState(() {
          service = element.service;
          organization = element.organization;
          friendliness = element.friendliness;
          areaExpert = element.areaExpert;
          safety = element.safety;
        });
        totalRate = ((double.parse(service.toString())+double.parse(organization.toString())+double.parse(friendliness.toString())+double.parse(areaExpert.toString())+double.parse(safety.toString()))/5).roundToDouble().toString();

      }
    });
  }
  @override
  void initState() {
    super.initState();
    getHotelRating();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  TextEditingController _comments = TextEditingController();

  late AppConfig _appConfig;
  String dropdownServiceValue = '5';
  String dropdownOrganizationValue = '5';
  String dropdownFriendlinessValue = '5';
  String dropdownAreaExpertValue = '5';
  String dropdownSafetyValue = '5';

  // getCategories () async {
  //   List<String> item=[];
  //
  //   await WebServices.carRateItem("${widget.item!.id}").then((categories) {
  //     // _categories = categories;
  //     // categories!. forEach((element){
  //     //   item.add("${element.service}");
  //     //   item.add("${element.organization}");
  //     //   item.add("${element.friendliness}");
  //     //   item.add("${element.areaExpert}");
  //     //   item.add("${element.safety}");
  //     //
  //     //   print("${element.service}");
  //     // });
  //     print("list of item $categories");
  //     items = item;
  //     print("list of items $items");
  //   });
  //   print("list of items $items");
  //   setState(() {
  //     items=item;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);

    return Scaffold(
      appBar: preferredSizeAppbar("${widget.item!.title}", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                        decoration: const BoxDecoration(
                          // color: AppConfig.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.network(
                            "${AppConfig.srcLink}${widget.item!.image}",
                            height: _appConfig.rH(25),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                   SizedBox(
                    height: _appConfig.rH(1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  this.widget.item!.title!,
                                  style: TextStyle(
                                      fontSize: AppConfig.f3,
                                      fontWeight: FontWeight.bold,
                                      color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                ),
                                SizedBox(
                                  width: _appConfig.rW(2),
                                ),
                                // SizedBox(
                                //   height: 25,
                                //   width: 95,
                                //   child: ElevatedButton(
                                //     onPressed: () {},
                                //     style: ButtonStyle(
                                //         backgroundColor:
                                //             MaterialStateProperty.all<Color>(
                                //           AppConfig.tripColor,
                                //         ),
                                //         shape: MaterialStateProperty.all<
                                //                 RoundedRectangleBorder>(
                                //             RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(18.0),
                                //         ))),
                                //     child: Row(
                                //       children: const [
                                //         Text(
                                //           'Filter',
                                //           style: TextStyle(color: Colors.white),
                                //         ),
                                //         SizedBox(
                                //           width: 2,
                                //         ),
                                //         Image(
                                //             image: AssetImage(
                                //                 'assets/images/down-arrow.png'))
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          totalRate!=null?RatingBarIndicator(
                            rating: double.parse("${totalRate}"),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            unratedColor: Colors.amber.withAlpha(60),
                            direction: Axis.horizontal,
                          ):Center(child: SizedBox(),),
                           SizedBox(
                            height: _appConfig.rH(1),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Amenities: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConfig.f4,
                                        color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                ),
                                SizedBox(
                                  height: _appConfig.rH(5),
                                  width: _appConfig.rW(50),
                                    child: Text("${widget.item!.terms}",
                                        overflow: TextOverflow.clip,
                                        maxLines: 5,
                                        style: TextStyle(
                                            fontSize: AppConfig.f4,
                                            color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                    )),
                              ],
                            ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   height: 250,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 40,
            //         padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            //         width: double.infinity,
            //         alignment: Alignment.center,
            //         child: TabBar(
            //           isScrollable: true,
            //           controller: _tabController,
            //           unselectedLabelColor: AppConfig.tripColor,
            //           labelColor: Colors.white,
            //           indicatorWeight: 2,
            //           indicator: ShapeDecoration(
            //               shape: RoundedRectangleBorder(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(30))),
            //               color: AppConfig.tripColor),
            //           tabs: <Widget>[
            //             Tab(
            //               child: Text("Details"),
            //             ),
            //             Tab(
            //               child: Text("Review"),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Expanded(
            //         child: TabBarView(
            //           controller: _tabController,
            //           children: <Widget>[
            //             HotelDetails(
            //               products: WebServices.hotelItems(),
            //               item: this.widget.item,
            //             ),
            //             Rating(),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: _appConfig.rW(65),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      unselectedLabelColor: AppConfig.tripColor,
                      labelColor: Colors.white,
                      indicatorWeight: 2,
                      indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          color: AppConfig.tripColor),
                      tabs: <Widget>[
                        Tab(
                          child: Text("Review",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                        ),

                        Tab(
                          child: Text("Details",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        totalRate!=null?Rating(service: service,organization: organization,friendliness: friendliness,areaExpert: areaExpert,safety: safety,):Center(child: SizedBox(),),

                        HotelDetails(
                          products: WebServices.hotelItems(),
                          item: this.widget.item,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1,
              thickness: 2,
            ),
            SizedBox(
              height: _appConfig.rH(1),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Map",
                style: TextStyle(
                    fontSize: AppConfig.f2,
                    color: AppConfig.tripColor,
                    fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          Map()),
                );              },
              child: Container(
                height: _appConfig.rH(30),
                child: MapLocation(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                FutureBuilder<List<HotelRooms>>(
                  future: getHotelRooms(),
                  builder: (context, snapshot) {
                    rooms = snapshot.data!.length;
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? HotelRoomItems(items: snapshot.data)

                    // return the ListView widget :
                        : Center(child: CircularProgressIndicator());
                  },
                ),

                (rooms!=0 || rooms==null)?Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Select Room",
                    style: TextStyle(
                        fontSize: AppConfig.f2,
                        color: AppConfig.tripColor,
                        fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),
                  ),
                ):SizedBox(),

                RoomDetailsCard(
                  products: WebServices.hotelItems(),
                  item: this.widget.item,
                ),
                FutureBuilder<List<HotelReview>>(
                  future: widget.reviews,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? HotelReviewListItems(items: snapshot.data)

                        // return the ListView widget :
                        : Center(child: CircularProgressIndicator());
                  },
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Comment here",
                              style: TextStyle(
                                  fontSize: AppConfig.f4,
                                  fontWeight: FontWeight.w700,
                                  color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _comments,
                              maxLines: 2,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(150),
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusColor: AppConfig.tripColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   padding:
                      //       EdgeInsets.symmetric( vertical: 20),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //               // padding: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                     color: AppConfig.shadeColor),
                      //                 color: AppConfig.whiteColor,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     width: 110,
                      //                     child: Text("Service"),
                      //                   ),
                      //                   Container(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0, left: 5),
                      //                     decoration: BoxDecoration(
                      //                       color: AppConfig.shadeColor,
                      //                       borderRadius: BorderRadius.only(
                      //                           topRight: Radius.circular(30),
                      //                           bottomRight:
                      //                               Radius.circular(30)),
                      //                     ),
                      //                     child: DropdownButton<String>(
                      //                       value: dropdownServiceValue,
                      //                       // icon: const Icon(Icons.arrow_downward),
                      //                       elevation: 5,
                      //                       style: TextStyle(
                      //                           color: AppConfig.tripColor),
                      //                       underline: Container(
                      //                         color: AppConfig.shadeColor,
                      //                       ),
                      //                       onChanged: (String? newValue) {
                      //                         setState(() {
                      //                           dropdownServiceValue = newValue!;
                      //                         });
                      //                       },
                      //                       items: <String>[
                      //                         '1',
                      //                         '2',
                      //                         '3',
                      //                         '4',
                      //                         '5'
                      //                       ].map<DropdownMenuItem<String>>(
                      //                           (String value) {
                      //                         return DropdownMenuItem<String>(
                      //                           value: value,
                      //                           child: Text(value),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   )
                      //                 ],
                      //               )),
                      //           SizedBox(
                      //             width: 20,
                      //           ),
                      //           Container(
                      //               // padding: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                     color: AppConfig.shadeColor),
                      //                 color: AppConfig.whiteColor,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     width: 110,
                      //                     child: Text("Organization"),
                      //                   ),
                      //                   Container(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0, left: 5),
                      //                     decoration: BoxDecoration(
                      //                       color: AppConfig.shadeColor,
                      //                       borderRadius: BorderRadius.only(
                      //                           topRight: Radius.circular(30),
                      //                           bottomRight:
                      //                               Radius.circular(30)),
                      //                     ),
                      //                     child: DropdownButton<String>(
                      //                       value: dropdownOrganizationValue,
                      //                       // icon: const Icon(Icons.arrow_downward),
                      //                       elevation: 5,
                      //                       style: TextStyle(
                      //                           color: AppConfig.tripColor),
                      //                       underline: Container(
                      //                         color: AppConfig.shadeColor,
                      //                       ),
                      //                       onChanged: (String? newValue) {
                      //                         setState(() {
                      //                           dropdownOrganizationValue = newValue!;
                      //                         });
                      //                       },
                      //                       items: <String>[
                      //                         '1',
                      //                         '2',
                      //                         '3',
                      //                         '4',
                      //                         '5'
                      //                       ].map<DropdownMenuItem<String>>(
                      //                           (String value) {
                      //                         return DropdownMenuItem<String>(
                      //                           value: value,
                      //                           child: Text(value),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   )
                      //                 ],
                      //               )),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //               // padding: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                     color: AppConfig.shadeColor),
                      //                 color: AppConfig.whiteColor,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     width: 110,
                      //                     child: Text("Friendliness"),
                      //                   ),
                      //                   Container(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0, left: 5),
                      //                     decoration: BoxDecoration(
                      //                       color: AppConfig.shadeColor,
                      //                       borderRadius: BorderRadius.only(
                      //                           topRight: Radius.circular(30),
                      //                           bottomRight:
                      //                               Radius.circular(30)),
                      //                     ),
                      //                     child: DropdownButton<String>(
                      //                       value: dropdownFriendlinessValue,
                      //                       // icon: const Icon(Icons.arrow_downward),
                      //                       elevation: 5,
                      //                       style: TextStyle(
                      //                           color: AppConfig.tripColor),
                      //                       underline: Container(
                      //                         color: AppConfig.shadeColor,
                      //                       ),
                      //                       onChanged: (String? newValue) {
                      //                         setState(() {
                      //                           dropdownFriendlinessValue = newValue!;
                      //                         });
                      //                       },
                      //                       items: <String>[
                      //                         '1',
                      //                         '2',
                      //                         '3',
                      //                         '4',
                      //                         '5'
                      //                       ].map<DropdownMenuItem<String>>(
                      //                           (String value) {
                      //                         return DropdownMenuItem<String>(
                      //                           value: value,
                      //                           child: Text(value),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   )
                      //                 ],
                      //               )),
                      //           SizedBox(
                      //             width: 20,
                      //           ),
                      //           Container(
                      //               // padding: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                     color: AppConfig.shadeColor),
                      //                 color: AppConfig.whiteColor,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     width: 110,
                      //                     child: Text("Area Expert"),
                      //                   ),
                      //                   Container(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0, left: 5),
                      //                     decoration: BoxDecoration(
                      //                       color: AppConfig.shadeColor,
                      //                       borderRadius: BorderRadius.only(
                      //                           topRight: Radius.circular(30),
                      //                           bottomRight:
                      //                               Radius.circular(30)),
                      //                     ),
                      //                     child: DropdownButton<String>(
                      //                       value: dropdownAreaExpertValue,
                      //                       // icon: const Icon(Icons.arrow_downward),
                      //                       elevation: 5,
                      //                       style: TextStyle(
                      //                           color: AppConfig.tripColor),
                      //                       underline: Container(
                      //                         color: AppConfig.shadeColor,
                      //                       ),
                      //                       onChanged: (String? newValue) {
                      //                         setState(() {
                      //                           dropdownAreaExpertValue = newValue!;
                      //                         });
                      //                       },
                      //                       items: <String>[
                      //                         '1',
                      //                         '2',
                      //                         '3',
                      //                         '4',
                      //                         '5'
                      //                       ].map<DropdownMenuItem<String>>(
                      //                           (String value) {
                      //                         return DropdownMenuItem<String>(
                      //                           value: value,
                      //                           child: Text(value),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   )
                      //                 ],
                      //               )),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           // SizedBox(
                      //           //   width: 20,
                      //           // ),
                      //           Container(
                      //               // padding: EdgeInsets.all(5),
                      //               decoration: BoxDecoration(
                      //                 border: Border.all(
                      //                     color: AppConfig.shadeColor),
                      //                 color: AppConfig.whiteColor,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     width: 110,
                      //                     child: Text("Safety"),
                      //                   ),
                      //                   Container(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0, left: 5),
                      //                     decoration: BoxDecoration(
                      //                       color: AppConfig.shadeColor,
                      //                       borderRadius: BorderRadius.only(
                      //                           topRight: Radius.circular(30),
                      //                           bottomRight:
                      //                               Radius.circular(30)),
                      //                     ),
                      //                     child: DropdownButton<String>(
                      //                       value: dropdownSafetyValue,
                      //                       // icon: const Icon(Icons.arrow_downward),
                      //                       elevation: 5,
                      //                       style: TextStyle(
                      //                           color: AppConfig.tripColor),
                      //                       underline: Container(
                      //                         color: AppConfig.shadeColor,
                      //                       ),
                      //                       onChanged: (String? newValue) {
                      //                         setState(() {
                      //                           dropdownSafetyValue = newValue!;
                      //                         });
                      //                       },
                      //                       items: <String>[
                      //                         '1',
                      //                         '2',
                      //                         '3',
                      //                         '4',
                      //                         '5'
                      //                       ].map<DropdownMenuItem<String>>(
                      //                           (String value) {
                      //                         return DropdownMenuItem<String>(
                      //                           value: value,
                      //                           child: Text(value),
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   )
                      //                 ],
                      //               )),
                      //           SizedBox(
                      //             width: 50,
                      //           ),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.end,
                      //             children: [
                      //               Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     vertical: 8.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   children: [
                      //                     CustomBtn(
                      //                       "Send",
                      //                       30,
                      //                       AppConfig.hotelColor,
                      //                       textSize: AppConfig.f3,
                      //                       onPressed: () async {
                      //
                      //                         await WebServices.addHotelRatingItems(dropdownServiceValue,dropdownOrganizationValue,dropdownFriendlinessValue,dropdownAreaExpertValue,dropdownSafetyValue,"${widget.item!.id}");
                      //
                      //                         await WebServices.addHotelReviewItems(
                      //                             "${widget.item!.id}",
                      //                             _comments.text);
                      //
                      //                         Navigator.of(context)
                      //                             .pushReplacement(
                      //                           MaterialPageRoute(
                      //                               builder: (context) =>
                      //                                   HotelDetailAndBooking(
                      //                                     products: WebServices
                      //                                         .hotelItems(),
                      //                                     reviews: WebServices
                      //                                         .hotelReviewItem(
                      //                                         "${widget.item!.id}"),
                      //                                     item: widget.item,
                      //                                   )),
                      //                         );
                      //                       },
                      //                       height: 40,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
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
                                          padding: const EdgeInsets.all(10.0),
                                          width: _appConfig.rW(24),
                                          child: Text("Service",style:TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5),
                                          decoration: BoxDecoration(
                                            color: AppConfig.shadeColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30)),
                                          ),
                                          child: DropdownButton<String>(
                                            value: dropdownServiceValue,
                                            // icon: const Icon(Icons.arrow_downward),
                                            elevation: 5,
                                            style:
                                            TextStyle(color: AppConfig.tripColor),
                                            underline: Container(
                                              color: AppConfig.shadeColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownServiceValue = newValue!;
                                              });
                                            },
                                            items: <String>['1', '2', '3', '4', '5']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value,textScaleFactor: 1),
                                                  );
                                                }).toList(),
                                          ),
                                        )
                                      ],
                                    )),
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
                                          padding: const EdgeInsets.all(10.0),
                                          width: _appConfig.rW(24),
                                          child: Text("Organization",style:TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5),
                                          decoration: BoxDecoration(
                                            color: AppConfig.shadeColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30)),
                                          ),
                                          child: DropdownButton<String>(
                                            value: dropdownOrganizationValue,
                                            // icon: const Icon(Icons.arrow_downward),
                                            elevation: 5,
                                            style:
                                            TextStyle(color: AppConfig.tripColor),
                                            underline: Container(
                                              color: AppConfig.shadeColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownOrganizationValue = newValue!;
                                              });
                                            },
                                            items: <String>['1', '2', '3', '4', '5']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value,textScaleFactor: 1),
                                                  );
                                                }).toList(),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
                                          padding: const EdgeInsets.all(10.0),
                                          width: _appConfig.rW(24),
                                          child: Text("Friendliness",style:TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5),
                                          decoration: BoxDecoration(
                                            color: AppConfig.shadeColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30)),
                                          ),
                                          child: DropdownButton<String>(
                                            value: dropdownFriendlinessValue,
                                            // icon: const Icon(Icons.arrow_downward),
                                            elevation: 5,
                                            style:
                                            TextStyle(color: AppConfig.tripColor),
                                            underline: Container(
                                              color: AppConfig.shadeColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownFriendlinessValue = newValue!;
                                              });
                                            },
                                            items: <String>['1', '2', '3', '4', '5']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value,textScaleFactor: 1),
                                                  );
                                                }).toList(),
                                          ),
                                        )
                                      ],
                                    )),
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
                                          padding: const EdgeInsets.all(10.0),
                                          width: _appConfig.rW(24),
                                          child: Text("Area Expert",style:TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5),
                                          decoration: BoxDecoration(
                                            color: AppConfig.shadeColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30)),
                                          ),
                                          child: DropdownButton<String>(
                                            value: dropdownAreaExpertValue,
                                            // icon: const Icon(Icons.arrow_downward),
                                            elevation: 5,
                                            style:
                                            TextStyle(color: AppConfig.tripColor),
                                            underline: Container(
                                              color: AppConfig.shadeColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownAreaExpertValue = newValue!;
                                              });
                                            },
                                            items: <String>['1', '2', '3', '4', '5']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value,textScaleFactor: 1),
                                                  );
                                                }).toList(),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   width: 20,
                                // ),
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
                                          padding: const EdgeInsets.all(10.0),
                                          width: _appConfig.rW(24),
                                          child: Text("Safety",style:TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5),
                                          decoration: BoxDecoration(
                                            color: AppConfig.shadeColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                bottomRight: Radius.circular(30)),
                                          ),
                                          child: DropdownButton<String>(
                                            value: dropdownSafetyValue,
                                            // icon: const Icon(Icons.arrow_downward),
                                            elevation: 5,
                                            style:
                                            TextStyle(color: AppConfig.tripColor),
                                            underline: Container(
                                              color: AppConfig.shadeColor,
                                            ),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownSafetyValue = newValue!;
                                              });
                                            },
                                            items: <String>['1', '2', '3', '4', '5']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value,textScaleFactor: 1),
                                                  );
                                                }).toList(),
                                          ),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          CustomBtn(
                                            "Send",
                                            _appConfig.rW(6),
                                            AppConfig.hotelColor,
                                            textColor: AppConfig.tripColor,
                                            onPressed: () async {
                                              await WebServices.addHotelRatingItems(
                                                  dropdownServiceValue,
                                                  dropdownOrganizationValue,
                                                  dropdownFriendlinessValue,
                                                  dropdownAreaExpertValue,
                                                  dropdownSafetyValue,
                                                  "${widget.item!.id}");

                                              await WebServices.addHotelReviewItems(
                                                  "${widget.item!.id}",
                                                  _comments.text);
                                              await WebServices.addHotelRateItems("$totalRate","${widget.item!.id}");

                                              Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HotelDetailAndBooking(
                                                          products: WebServices
                                                              .hotelItems(),
                                                          reviews: WebServices
                                                              .hotelReviewItem(
                                                              "${widget.item!.id}"),
                                                          item: widget.item,
                                                        )),
                                              );
                                            },
                                            height: 30,
                                            textSize: AppConfig.f4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "More Hotels",
                          style: TextStyle(
                              fontSize: AppConfig.f3,
                              fontWeight: FontWeight.bold,
                              color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: _appConfig.rH(50),
                        child: FutureBuilder<List<HotelModel>>(
                          future: widget.products,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? HotelListItems(items: snapshot.data,itemLimit: limit,)

                            // return the ListView widget :
                                : Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                )

                // RoomDetailsCard(
                //   products: WebServices.hotelItems(),
                //   item: this.widget.item,
                // ),
              ],
            )
          ],
        ),
      ),
      drawer: const MyDrawer(),

    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('_tabController', _tabController));
  }
}

class HotelDetails extends StatelessWidget {
  final HotelModel? item;
  final Future<List<HotelModel>>? products;
  HotelDetails({Key? key, this.products, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lorem ipsum dollar",
            style: TextStyle(
                fontSize: AppConfig.f2,
                color: AppConfig.tripColor,
                fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(this.item!.description!,
                  style: TextStyle(
                      fontSize: AppConfig.f4, color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "More",
                style: TextStyle(color: AppConfig.carColor,fontFamily: AppConfig.fontFamilyRegular),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HotelReviewListItems extends StatelessWidget {
  final List<HotelReview>? items;
  HotelReviewListItems({Key? key, this.items});
  late AppConfig _appConfig;
  var limit=6;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items!.length< limit?  items!.length:limit,
      itemBuilder: (context, index) {
        return HotelReviewCard(item: items![index]);
      },
    );
  }
}

class HotelRoomItems extends StatelessWidget {
  final List<HotelRooms>? items;
  HotelRoomItems({Key? key, this.items});
  late AppConfig _appConfig;
  var limit=6;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items!.length< limit?  items!.length:limit,
      itemBuilder: (context, index) {
        return RoomCard(item: items![index]);
      },
    );
  }
}



class HotelReviewCard extends StatelessWidget {
  final HotelReview? item;
  final Future<List<HotelReview>>? products;
  HotelReviewCard({Key? key, this.products, this.item}) : super(key: key);
  final DateFormat? formatter = DateFormat('yyyy-MM-dd');
  // get rating => null;
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    final String formatted = formatter!.format(item!.date!);
    _appConfig = AppConfig(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    radius: 22,
                    backgroundImage: NetworkImage(
                      '${AppConfig.srcLink}${item!.image}',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item!.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: AppConfig.f3,
                            color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),
                      SizedBox(height: _appConfig.rH(1),),
                      Text(
                        "$formatted",
                        style: TextStyle(
                            fontSize: AppConfig.f5, color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      )
                    ],
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     RatingBarIndicator(
              //       rating: 4,
              //       itemBuilder: (context, index) => Icon(
              //         Icons.star,
              //         color: Colors.amber,
              //       ),
              //       itemCount: 5,
              //       itemSize: _appConfig.rW(5),
              //       unratedColor: Colors.amber.withAlpha(60),
              //       direction: Axis.horizontal,
              //     ),
              //     Text(
              //       "Very Good",
              //       style: TextStyle(fontSize: AppConfig.f6),textScaleFactor: 1,
              //     ),
              //   ],
              // )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(child: Text("${item!.comment}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,))
        ],
      ),
    );
  }
}

class MapLocation extends StatefulWidget {
  @override
  State<MapLocation> createState() => MapSampleState();
}

class MapSampleState extends State<MapLocation> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.79170162386614, 72.35990175528423),
    zoom: 14.4746,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(34.79170162386614, 72.35990175528423)),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.42796133580664, -120.085749655962),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
