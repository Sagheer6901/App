import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/car_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_card.dart';
import 'package:untitled/services/services.dart';

List priceCarList = [];
var totalCarPrice=0;
var carDays=1;
class RecommendedCars extends StatefulWidget {
  var limit = 7;

  RecommendedCars({Key? key,}) : super(key: key);
  @override
  _RecommendedCarsState createState() => _RecommendedCarsState();
}

class _RecommendedCarsState extends State<RecommendedCars> {
  late AppConfig _appConfig;

  Future<List<CarModel>> getCars() {
    return WebServices.carRecommendedItems(selectedTripIds);
  }

  List<CarModel> allCars = [];
  List<CarModel> fileteredCars = [];

  // filterCars() {
  //   WebServices.carRecommendedItems(widget.location).then((value) {
  //     allCars = value;
  //     fileteredCars = allCars;
  //     var i;
  //
  //     setState(() {
  //       fileteredCars = allCars
  //           .where((element) => (element.location!
  //           .contains(widget.location)))
  //           .toList();
  //     });
  //
  //
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // filterCars();
    // getCars();
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
        carDays= carDays +int.parse("${_diff}");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // CarFilters.selectFilters.clear();
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        ));
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
          //               style: TextStyle(
          //                   color: AppConfig.tripColor,
          //                   fontSize: AppConfig.f5,
          //                   fontFamily:
          //                   AppConfig.fontFamilyRegular),
          //               textScaleFactor: 1)
          //               : Text("PickDate",
          //               style: TextStyle(
          //                   color: AppConfig.tripColor,
          //                   fontSize: AppConfig.f5,
          //                   fontFamily:
          //                   AppConfig.fontFamilyRegular),
          //               textScaleFactor: 1),
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
          //                         DateRangePickerSelectionMode.range,
          //                         initialSelectedRange: PickerDateRange(
          //                             DateTime.now().subtract(
          //                                 const Duration(days: 4)),
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
          //               style: TextStyle(
          //                   color: AppConfig.tripColor,
          //                   fontSize: AppConfig.f5,
          //                   fontFamily:
          //                   AppConfig.fontFamilyRegular),
          //               textScaleFactor: 1)
          //               : Text("PickDate",
          //               style: TextStyle(
          //                   color: AppConfig.tripColor,
          //                   fontSize: AppConfig.f5,
          //                   fontFamily:
          //                   AppConfig.fontFamilyRegular),
          //               textScaleFactor: 1),
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
          //                         DateRangePickerSelectionMode.range,
          //                         initialSelectedRange: PickerDateRange(
          //                             DateTime.now().subtract(
          //                                 const Duration(days: 4)),
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
          //
          //     ],
          //   ),
          // ),

          Expanded(
            flex: 5,
            child: SizedBox(
              // height: _appConfig.rH(65),
              child: FutureBuilder<List<CarModel>>(
                future: getCars(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                  }
                  return snapshot.hasData
                      ? RecommendedCarsItems(
                    items: snapshot.data,
                    itemLimit: widget.limit,
                    date: _startDate,
                  )

                  // return the ListView widget :
                      : const Center(
                      child: const CircularProgressIndicator());
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

class RecommendedCarsItems extends StatefulWidget {
  List<CarModel>? items;
  var itemLimit,date;

  RecommendedCarsItems({
    Key? key,
    this.items,
    this.itemLimit,this.date
  }) : super(key: key);

  @override
  State<RecommendedCarsItems> createState() => _RecommendedCarsItemsState();
}

class _RecommendedCarsItemsState extends State<RecommendedCarsItems> {
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return SmartRefresher(
      // enablePullDown: true,
      // enablePullUp: true,
      controller: _refreshController,
      onLoading: () {
        log('Loading');
      },
      footer: null,
      onRefresh: () async {
        final temp = await WebServices.carRecommendedItems(selectedTripIds);
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
        itemBuilder: (context, index) {
          return Stack(
            children: [
              BookVehicleCard(item: widget.items![index],tour: "tour",),
              Positioned(
                  right: 50,
                  bottom: 50,
                  child: Container(
                child: Center(
                  child: priceCarList.toString().contains(
                      "${widget.items![index].id}") !=
                      true
                      ? IconButton(
                      icon: new Icon(Icons.add),
                      onPressed: () {
                        var item = {};
                        setState(() {
                          item["id"] =
                              widget.items![index].id;
                          item["price"] =
                              widget.items![index].price;
                          if (priceCarList
                              .toString()
                              .contains(
                              "${widget.items![index].id}") !=
                              true) {
                            priceCarList.add(item);
                            setState(() {
                              totalCarPrice = totalCarPrice +
                                  int.parse("${widget.items![index].price}");
                            });
                            // priceList.add(
                            //     "${widget.items![index].price}");
                            print(
                                "trip id: $priceCarList");
                          }

                          print(
                              "trips: $priceCarList");
                        });
                        // if (widget.date!=null) {
                        //   var item = {};
                        //   setState(() {
                        //     item["id"] =
                        //         widget.items![index].id;
                        //     item["price"] =
                        //         widget.items![index].price;
                        //     if (priceCarList
                        //         .toString()
                        //         .contains(
                        //         "${widget.items![index].id}") !=
                        //         true) {
                        //       priceCarList.add(item);
                        //       setState(() {
                        //         totalCarPrice = totalCarPrice +
                        //             int.parse("${widget.items![index].price}");
                        //       });
                        //       // priceList.add(
                        //       //     "${widget.items![index].price}");
                        //       print(
                        //           "trip id: $priceCarList");
                        //     }
                        //
                        //     print(
                        //         "trips: $priceCarList");
                        //   });
                        // }
                        //
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
                      })
                      : TextButton(
                      onPressed: () {
                        print(
                            "start: $priceCarList");


                        for (var e in priceCarList) {
                          if (e.toString().contains(
                              "${widget.items![index].price}")) {
                            setState(() {
                              priceCarList.remove(e);
                              priceCarList.remove(
                                  "${widget.items![index].id}");
                              totalCarPrice = totalCarPrice- int.parse("${widget.items![index].price}");


                            });
                          }
                        }
                        if (selectedTrips.length ==
                            0) {
                          setState(() {
                            ScaffoldMessenger.of(
                                context)
                                .removeCurrentSnackBar();
                          });
                        }
                        print("end: $selectedTrips");
                      },
                      child: Text("UnSelect")),
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
