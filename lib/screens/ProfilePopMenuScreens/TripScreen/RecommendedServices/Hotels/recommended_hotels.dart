import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/car_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_detail_and_booking.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/room_details_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Hotels/recommended_hotel_details.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_card.dart';
import 'package:untitled/services/services.dart';

var hotelDays = 0;

class RecommendedHotelList extends StatefulWidget {
  // final Future<List<HotelModel>>? products;
  var limit = 7;

  RecommendedHotelList({Key? key}) : super(key: key);
  @override
  _RecommendedHotelListState createState() => _RecommendedHotelListState();
}

class _RecommendedHotelListState extends State<RecommendedHotelList> {
  late AppConfig _appConfig;

  getHotels() {
    return WebServices.hotelRecommendedItems(selectedTripIds);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  dynamic? _diff = '';
  String? _startDate, _endDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _startDate = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)}';
        // ignore: lines_longer_than_80_chars
        _endDate =
            ' ${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
        _diff = daysBetween(args.value.startDate, args.value.endDate);
        hotelDays = hotelDays + int.parse("${_diff}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Container(
      height: _appConfig.rH(80),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           Text("CheckIn:",
          //               style: TextStyle(
          //                   color: AppConfig.tripColor,
          //                   fontSize: AppConfig.f5,
          //                   fontFamily: AppConfig.fontFamilyRegular),
          //               textScaleFactor: 1),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           _startDate != null
          //               ? Text("$_startDate",
          //                   style: TextStyle(
          //                       color: AppConfig.tripColor,
          //                       fontSize: AppConfig.f5,
          //                       fontFamily: AppConfig.fontFamilyRegular),
          //                   textScaleFactor: 1)
          //               : Text("PickDate",
          //                   style: TextStyle(
          //                       color: AppConfig.tripColor,
          //                       fontSize: AppConfig.f5,
          //                       fontFamily: AppConfig.fontFamilyRegular),
          //                   textScaleFactor: 1),
          //           IconButton(
          //             onPressed: () {
          //               showDialog(
          //                   context: context,
          //                   builder: (BuildContext context) {
          //                     return Container(
          //                       color: AppConfig.whiteColor,
          //                       margin: EdgeInsets.symmetric(
          //                           horizontal: _appConfig.rW(10),
          //                           vertical: _appConfig.rH(25)),
          //                       child: SfDateRangePicker(
          //                         onSelectionChanged: _onSelectionChanged,
          //                         selectionMode:
          //                             DateRangePickerSelectionMode.range,
          //                         initialSelectedRange: PickerDateRange(
          //                             DateTime.now()
          //                                 .subtract(const Duration(days: 4)),
          //                             DateTime.now()
          //                                 .add(const Duration(days: 3))),
          //                       ),
          //                     );
          //                   });
          //               // endDate(context);
          //               // setState(() {
          //               //   // diff = daysBetween(date1, date2);
          //               //   diff = date2.difference(date1).inDays;
          //               //
          //               // });
          //             },
          //             icon: Icon(Icons.calendar_today_sharp),
          //           )
          //         ],
          //       ),
          //       // SizedBox(height: 10,),
          //       Row(
          //         children: [
          //           Text("CheckOut:",
          //               style: TextStyle(
          //                   color: AppConfig.tripColor,
          //                   fontSize: AppConfig.f5,
          //                   fontFamily: AppConfig.fontFamilyRegular),
          //               textScaleFactor: 1),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           _startDate != null
          //               ? Text("$_endDate",
          //                   style: TextStyle(
          //                       color: AppConfig.tripColor,
          //                       fontSize: AppConfig.f5,
          //                       fontFamily: AppConfig.fontFamilyRegular),
          //                   textScaleFactor: 1)
          //               : Text("PickDate",
          //                   style: TextStyle(
          //                       color: AppConfig.tripColor,
          //                       fontSize: AppConfig.f5,
          //                       fontFamily: AppConfig.fontFamilyRegular),
          //                   textScaleFactor: 1),
          //           IconButton(
          //             onPressed: () {
          //               showDialog(
          //                   context: context,
          //                   builder: (BuildContext context) {
          //                     return Container(
          //                       color: AppConfig.whiteColor,
          //                       margin: EdgeInsets.symmetric(
          //                           horizontal: _appConfig.rW(10),
          //                           vertical: _appConfig.rH(25)),
          //                       child: SfDateRangePicker(
          //                         onSelectionChanged: _onSelectionChanged,
          //                         selectionMode:
          //                             DateRangePickerSelectionMode.range,
          //                         initialSelectedRange: PickerDateRange(
          //                             DateTime.now()
          //                                 .subtract(const Duration(days: 4)),
          //                             DateTime.now()
          //                                 .add(const Duration(days: 3))),
          //                       ),
          //                     );
          //                   });
          //               // endDate(context);
          //               // setState(() {
          //               //   // diff = daysBetween(date1, date2);
          //               //   diff = date2.difference(date1).inDays;
          //               //
          //               // });
          //             },
          //             icon: Icon(Icons.calendar_today_sharp),
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 5,
            child: SizedBox(
              // height: _appConfig.rH(65),
              child: FutureBuilder<List<HotelModel>>(
                future: getHotels(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? HotelListItems(
                          items: snapshot.data, itemLimit: widget.limit,date: _startDate,)

                      // return the ListView widget :
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rH(0.5),
          ),
          CustomBtn("See more", 30, AppConfig.hotelColor,
              textSize: AppConfig.f4,
              textColor: AppConfig.tripColor, onPressed: () {
            setState(() {
              widget.limit = widget.limit + 7;
            });
          }),
          SizedBox(
            height: _appConfig.rH(1),
          ),
        ],
      ),
    );
  }
}

class HotelListItems extends StatefulWidget {
  List<HotelModel>? items;
  var itemLimit, date;

  HotelListItems({Key? key, this.items, this.itemLimit, this.date});

  @override
  State<HotelListItems> createState() => _HotelListItemsState();
}

class _HotelListItemsState extends State<HotelListItems> {
  late AppConfig _appConfig;
  final _refreshController = RefreshController(
    initialRefresh: false,
  );
  List h = [];
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return SmartRefresher(
        // enablePullDown: true,
        // enablePullUp: true,
        controller: _refreshController,
        onLoading: () {
          log('Loading');
        },
        footer: null,
        onRefresh: () async {
          final temp = await WebServices.hotelRecommendedItems(selectedTripIds);
          setState(() {
            widget.items = temp;
          });
          // await Future.delayed(const Duration(milliseconds: 1000));
          // if failed,use refreshFailed()
          _refreshController.refreshCompleted();
        },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.items!.length < widget.itemLimit
              ? widget.items!.length
              : widget.itemLimit,
          // itemCount: widget.items!.length< widget.itemLimit?  widget.items!.length:widget.itemLimit,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecommendedHotelDetailAndBooking(
                          products: WebServices.hotelItems(),
                          reviews: WebServices.hotelReviewItem(
                              "${widget.items![index].id}"),
                          item: this.widget.items![index],
                        )),
                  );

                  // if(widget.date!=null){
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => RecommendedHotelDetailAndBooking(
                  //           products: WebServices.hotelItems(),
                  //           reviews: WebServices.hotelReviewItem(
                  //               "${widget.items![index].id}"),
                  //           item: this.widget.items![index],
                  //         )),
                  //   );
                  // }
                  // else {
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return CustomDialog(
                  //           title: 'Invalid',
                  //           subtitle: 'PickDate plz',
                  //           primaryAction: () {
                  //             Navigator.pop(context);
                  //           },
                  //           primaryActionText: 'Okay',
                  //         );
                  //       });
                  // }


                },
                child: Stack(
                  children: [
                    HotelBookingCard(
                      item: widget.items![index],
                      tour: "tour",
                    ),
                    Positioned(
                        right: 50,
                        bottom: 50,
                        child: Container(
                          child: Center(
                            child: priceHotelRoomsList.toString().contains(
                                            "${widget.items![index].id}") !=
                                        true ||
                                    h
                                        .toString()
                                        .contains("${widget.items![index].id}")

                                // ? IconButton(
                                // icon: new Icon(Icons.add),
                                // onPressed: () {
                                //   setState(() {
                                //     h.add("${widget.items![index].id}");
                                //   });
                                // })
                                ? SizedBox()
                                : TextButton(
                                    onPressed: () {
                                      print("start: $priceHotelRoomsList");

                                      for (var e in priceHotelRoomsList) {
                                        if (e.toString().contains(
                                            "${widget.items![index].price}")) {
                                          setState(() {
                                            priceHotelRoomsList.remove(e);
                                            priceHotelRoomsList.remove(
                                                "${widget.items![index].id}");
                                            // totalCarPrice = totalCarPrice- int.parse("${widget.items![index].price}");
                                          });
                                        }
                                      }
                                      if (selectedTrips.length == 0) {
                                        setState(() {
                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                        });
                                      }
                                      print("end: $selectedTrips");
                                    },
                                    child: Text("UnSelect")),
                          ),
                        ))
                  ],
                ));
          },
        ));
  }
}
