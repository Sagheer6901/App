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
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_filters.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list.dart';
import 'package:untitled/services/services.dart';

List priceGuideList = [];
var totalGuidePrice=0;
var guideDays=1;
class GuideRecommendedList extends StatefulWidget {

  var limit=7;

  GuideRecommendedList({Key? key}) : super(key: key);
  @override
  _GuideRecommendedListState createState() => _GuideRecommendedListState();
}

class _GuideRecommendedListState extends State<GuideRecommendedList> {
  late AppConfig _appConfig;

  Future<List<TourGuideModel>> getTourGuideItems() {
    return WebServices.guideRecommendedItems(selectedTripIds);
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
        guideDays = guideDays+int.parse("${_diff}");
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("CheckIn:",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1),
                      SizedBox(
                        width: 5,
                      ),
                      _startDate != null
                          ? Text("$_startDate",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily:
                              AppConfig.fontFamilyRegular),
                          textScaleFactor: 1)
                          : Text("PickDate",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily:
                              AppConfig.fontFamilyRegular),
                          textScaleFactor: 1),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: AppConfig.whiteColor,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: _appConfig.rW(10),
                                      vertical: _appConfig.rH(25)),
                                  child: SfDateRangePicker(
                                    onSelectionChanged: _onSelectionChanged,
                                    selectionMode:
                                    DateRangePickerSelectionMode.range,
                                    initialSelectedRange: PickerDateRange(
                                        DateTime.now().subtract(
                                            const Duration(days: 4)),
                                        DateTime.now()
                                            .add(const Duration(days: 3))),
                                  ),
                                );
                              });
                          // endDate(context);
                          // setState(() {
                          //   // diff = daysBetween(date1, date2);
                          //   diff = date2.difference(date1).inDays;
                          //
                          // });
                        },
                        icon: Icon(Icons.calendar_today_sharp),
                      )
                    ],
                  ),
                  // SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("CheckOut:",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1),
                      SizedBox(
                        width: 5,
                      ),
                      _startDate != null
                          ? Text("$_endDate",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily:
                              AppConfig.fontFamilyRegular),
                          textScaleFactor: 1)
                          : Text("PickDate",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily:
                              AppConfig.fontFamilyRegular),
                          textScaleFactor: 1),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: AppConfig.whiteColor,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: _appConfig.rW(10),
                                      vertical: _appConfig.rH(25)),
                                  child: SfDateRangePicker(
                                    onSelectionChanged: _onSelectionChanged,
                                    selectionMode:
                                    DateRangePickerSelectionMode.range,
                                    initialSelectedRange: PickerDateRange(
                                        DateTime.now().subtract(
                                            const Duration(days: 4)),
                                        DateTime.now()
                                            .add(const Duration(days: 3))),
                                  ),
                                );
                              });
                          // endDate(context);
                          // setState(() {
                          //   // diff = daysBetween(date1, date2);
                          //   diff = date2.difference(date1).inDays;
                          //
                          // });
                        },
                        icon: Icon(Icons.calendar_today_sharp),
                      )
                    ],
                  ),

                ],
              ),
            ),

            Expanded(
              flex: 5,
              child: SizedBox(
                // height: 350,
                child: FutureBuilder<List<TourGuideModel>>(
                  future:     getTourGuideItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? TourGuideRecommendedItems(items: snapshot.data,itemLimit:widget.limit,date:_startDate)

                    // return the ListView widget :
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            SizedBox(
              height: _appConfig.rH(0.5),
            ),
            CustomBtn("See more", 30, AppConfig.hotelColor,textSize: AppConfig.f4,textColor: AppConfig.tripColor,onPressed: (){
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


class TourGuideRecommendedItems extends StatefulWidget {
  List<TourGuideModel>? items;
  var itemLimit,date;

  TourGuideRecommendedItems({Key? key, this.items,this.itemLimit,this.date});

  @override
  State<TourGuideRecommendedItems> createState() => _TourGuideRecommendedItemsState();
}

class _TourGuideRecommendedItemsState extends State<TourGuideRecommendedItems> {
  late AppConfig _appConfig;
  final _refreshController = RefreshController(
    initialRefresh: false,
  );
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
        final temp = await WebServices.guideRecommendedItems(selectedTripIds);
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
          return Stack(
            children: [
              GuideCard(item: widget.items![index],tour:"tour"),
              Positioned(
                  right: 50,
                  bottom: 50,
                  child: Container(
                    child: Center(
                      child: priceGuideList.toString().contains(
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
                              if (priceGuideList
                                  .toString()
                                  .contains(
                                  "${widget.items![index].id}") !=
                                  true) {
                                priceGuideList.add(item);
                                setState(() {
                                  totalGuidePrice = totalGuidePrice+ int.parse("${widget.items![index].price}");

                                });
                                // priceList.add(
                                //     "${widget.items![index].price}");
                                print(
                                    "trip id: $priceGuideList");
                              }
                              print(
                                  "trips: $priceGuideList");

                            });
                            // if(widget.date!=null){
                            //   var item = {};
                            //   setState(() {
                            //     item["id"] =
                            //         widget.items![index].id;
                            //     item["price"] =
                            //         widget.items![index].price;
                            //     if (priceGuideList
                            //         .toString()
                            //         .contains(
                            //         "${widget.items![index].id}") !=
                            //         true) {
                            //       priceGuideList.add(item);
                            //       setState(() {
                            //         totalGuidePrice = totalGuidePrice+ int.parse("${widget.items![index].price}");
                            //
                            //       });
                            //       // priceList.add(
                            //       //     "${widget.items![index].price}");
                            //       print(
                            //           "trip id: $priceGuideList");
                            //     }
                            //     print(
                            //         "trips: $priceGuideList");
                            //
                            //   });
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
                          })
                          : TextButton(
                          onPressed: () {
                            print(
                                "start: $priceGuideList");


                            for (var e in priceGuideList) {
                              if (e.toString().contains(
                                  "${widget.items![index].price}")) {
                                setState(() {
                                  priceGuideList.remove(e);
                                  priceGuideList.remove(
                                      "${widget.items![index].id}");
                                  totalGuidePrice = totalGuidePrice- int.parse("${widget.items![index].price}");


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
