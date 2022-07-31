import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/functions/rating.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/review_car.dart';
import 'package:untitled/models/Categories/review_guide.dart';
import 'package:untitled/models/Categories/review_trip.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_screen.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/checkout.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Cars/recommended_cars.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Guides/recommended_guides.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Hotels/recommended_hotels.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_list.dart';
import 'package:untitled/services/services.dart';

import '../HotelScreen/room_details_card.dart';

class TripBookingDetailScreen extends StatefulWidget {
  final TripListModel? item;
  final Future<List<TripListModel>>? products;
  final Future<List<TripReviews>>? reviews;
  TripBookingDetailScreen({Key? key, this.products, this.reviews, this.item})
      : super(key: key);
  @override
  _TripBookingDetailScreenState createState() =>
      _TripBookingDetailScreenState();
}

class _TripBookingDetailScreenState extends State<TripBookingDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController, _recommendedController;
  var limit = 7;

  String? service;
  String? organization;
  String? friendliness;
  String? areaExpert;
  String? safety;
  String? totalRate;

  getTripRating() async {
    // isLoading = true;
    await WebServices.tripRating(widget.item!.id).then((ratings) {
      for (var element in ratings) {
        print("servicesss: ${element.service}");
        setState(() {
          service = element.service;
          organization = element.organization;
          friendliness = element.friendliness;
          areaExpert = element.areaExpert;
          safety = element.safety;
        });
        totalRate = ((double.parse(service.toString()) +
                    double.parse(organization.toString()) +
                    double.parse(friendliness.toString()) +
                    double.parse(areaExpert.toString()) +
                    double.parse(safety.toString())) /
                5)
            .roundToDouble()
            .toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getTripRating();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _recommendedController =
        TabController(length: 3, vsync: this, initialIndex: 0);
    priceCarList.clear();
    priceGuideList.clear();
  }

  var orderId;
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
      }
    });
  }

  late AppConfig _appConfig;

  TextEditingController _comments = TextEditingController();

  String dropdownServiceValue = '5';
  String dropdownOrganizationValue = '5';
  String dropdownFriendlinessValue = '5';
  String dropdownAreaExpertValue = '5';
  String dropdownSafetyValue = '5';
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);

    return Scaffold(
      appBar: preferredSizeAppbar("${widget.item!.title}", context),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Container(
        //   // height: 200,
        //   margin:
        //   const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
        //   padding: const EdgeInsets.all(20),
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.all(Radius.circular(30)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black12,
        //         offset: Offset(0, 5),
        //         blurRadius: 10,
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     children: [
        //       Container(
        //           decoration: const BoxDecoration(
        //             // color: AppConfig.primaryColor,
        //             borderRadius: BorderRadius.all(Radius.circular(30)),
        //           ),
        //           child: ClipRRect(
        //             borderRadius: const BorderRadius.all(
        //               Radius.circular(20),
        //             ),
        //             child: Image.network(
        //               "${AppConfig.srcLink}${widget.item!.image}",
        //               height: _appConfig.rH(12),
        //               width: double.infinity,
        //               fit: BoxFit.fill,
        //             ),
        //           )),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             "${widget.item!.title}",
        //             style: TextStyle(
        //               fontSize: AppConfig.f3,
        //                 fontWeight: FontWeight.bold, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
        //           ),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               Row(
        //                 children: [
        //                   Text(
        //                       "Rs",
        //                       style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: AppConfig.f5,
        //                           color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
        //                   ),
        //                   Text(
        //                       " ${this.widget.item!.price}",
        //                       style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: AppConfig.f3,
        //                           color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
        //                   ),
        //                   SizedBox(
        //                     width: 5,
        //                   ),
        //                   Text("8700",
        //                       style: TextStyle(
        //                           decoration: TextDecoration.lineThrough,
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
        //                 ],
        //               ),
        //               Text(
        //                   "Inclusive Tax",
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: AppConfig.f5,
        //                       color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
        //               )
        //             ],
        //           ),
        //
        //         ],
        //       ),
        //
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text(
            "Your Selected Trips",
            style: TextStyle(
                fontSize: AppConfig.f2,
                fontWeight: FontWeight.bold,
                color: AppConfig.tripColor,
                fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: _appConfig.rH(25),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: selectedTrips.length,
            itemBuilder: (context, index) {
              return SelectedTripCard(item: selectedTrips[index]);
            },
          ),
        ),
        SizedBox(
          height: _appConfig.rH(2),
        ),
        Divider(
          height: 1,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Row(
              //   children: [
              //     Text(
              //         "Total:",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: AppConfig.f3,
              //             color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
              //     ),
              //
              //     SizedBox(width: 10,),
              //
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           children: [
              //             Text(
              //                 "Rs",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: AppConfig.f5,
              //                     color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
              //             ),
              //             Text(
              //                 // " ${this.widget.item!.price}",
              //               "$totalCarPrice",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: AppConfig.f3,
              //                     color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             // Text("8700",
              //             //     style: TextStyle(
              //             //         decoration: TextDecoration.lineThrough,
              //             //         color: AppConfig.tripColor,
              //             //         fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
              //           ],
              //         ),
              //         Text(
              //             "Inclusive Tax",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: AppConfig.f5,
              //                 color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
              //         )
              //       ],
              //     ),
              //   ],
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Row(
              //       children: [
              //         Text("CheckIn:",
              //             style: TextStyle(
              //                 color: AppConfig.tripColor,
              //                 fontSize: AppConfig.f5,
              //                 fontFamily: AppConfig.fontFamilyRegular),
              //             textScaleFactor: 1),
              //         SizedBox(
              //           width: 5,
              //         ),
              //         _startDate != null
              //             ? Text("$_startDate",
              //             style: TextStyle(
              //                 color: AppConfig.tripColor,
              //                 fontSize: AppConfig.f5,
              //                 fontFamily:
              //                 AppConfig.fontFamilyRegular),
              //             textScaleFactor: 1)
              //             : Text("PickDate",
              //             style: TextStyle(
              //                 color: AppConfig.tripColor,
              //                 fontSize: AppConfig.f5,
              //                 fontFamily:
              //                 AppConfig.fontFamilyRegular),
              //             textScaleFactor: 1),
              //         IconButton(
              //           onPressed: () {
              //             showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return Container(
              //                     color: AppConfig.whiteColor,
              //                     margin: EdgeInsets.symmetric(
              //                         horizontal: _appConfig.rW(10),
              //                         vertical: _appConfig.rH(25)),
              //                     child: SfDateRangePicker(
              //                       onSelectionChanged: _onSelectionChanged,
              //                       selectionMode:
              //                       DateRangePickerSelectionMode.range,
              //                       initialSelectedRange: PickerDateRange(
              //                           DateTime.now().subtract(
              //                               const Duration(days: 4)),
              //                           DateTime.now()
              //                               .add(const Duration(days: 3))),
              //                     ),
              //                   );
              //                 });
              //             // endDate(context);
              //             // setState(() {
              //             //   // diff = daysBetween(date1, date2);
              //             //   diff = date2.difference(date1).inDays;
              //             //
              //             // });
              //           },
              //           icon: Icon(Icons.calendar_today_sharp),
              //         )
              //       ],
              //     ),
              //     // SizedBox(height: 10,),
              //     Row(
              //       children: [
              //         Text("CheckOut:",
              //             style: TextStyle(
              //                 color: AppConfig.tripColor,
              //                 fontSize: AppConfig.f5,
              //                 fontFamily: AppConfig.fontFamilyRegular),
              //             textScaleFactor: 1),
              //         SizedBox(
              //           width: 5,
              //         ),
              //         _startDate != null
              //             ? Text("$_endDate",
              //             style: TextStyle(
              //                 color: AppConfig.tripColor,
              //                 fontSize: AppConfig.f5,
              //                 fontFamily:
              //                 AppConfig.fontFamilyRegular),
              //             textScaleFactor: 1)
              //             : Text("PickDate",
              //             style: TextStyle(
              //                 color: AppConfig.tripColor,
              //                 fontSize: AppConfig.f5,
              //                 fontFamily:
              //                 AppConfig.fontFamilyRegular),
              //             textScaleFactor: 1),
              //         IconButton(
              //           onPressed: () {
              //             showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return Container(
              //                     color: AppConfig.whiteColor,
              //                     margin: EdgeInsets.symmetric(
              //                         horizontal: _appConfig.rW(10),
              //                         vertical: _appConfig.rH(25)),
              //                     child: SfDateRangePicker(
              //                       onSelectionChanged: _onSelectionChanged,
              //                       selectionMode:
              //                       DateRangePickerSelectionMode.range,
              //                       initialSelectedRange: PickerDateRange(
              //                           DateTime.now().subtract(
              //                               const Duration(days: 4)),
              //                           DateTime.now()
              //                               .add(const Duration(days: 3))),
              //                     ),
              //                   );
              //                 });
              //             // endDate(context);
              //             // setState(() {
              //             //   // diff = daysBetween(date1, date2);
              //             //   diff = date2.difference(date1).inDays;
              //             //
              //             // });
              //           },
              //           icon: Icon(Icons.calendar_today_sharp),
              //         )
              //       ],
              //     ),
              //
              //   ],
              // ),

              CustomBtn(
                "Book Now",
                _appConfig.rW(6),
                AppConfig.hotelColor,
                textColor: AppConfig.tripColor,
                textSize: AppConfig.f5,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var name = prefs.getString("name");
                  var contact = prefs.getString("contact");

                  List orderIds = [];
                  List orderTypes = [];
                  var total = 0;
                  for (var c in selectedTrips) {
                    total = total + int.parse(c['price'].toString());
                    print("total trips: $total");
                    orderIds.add(c['id']);
                    orderTypes.add('trip');
                  }
                  for (var h in priceHotelRoomsList) {
                    total =
                        // total + (int.parse(h['price'].toString()) * hotelDays);
                    total + (int.parse(h['price'].toString()));

                    print("total hotelrooms: $total");
                    orderIds.add(h['id']);
                    orderTypes.add('hotel');
                  }
                  print("orders $orderIds $orderTypes");
                  for (var c in priceCarList) {
                    total =
                        // total + (int.parse(c['price'].toString()) * carDays);
                    total + (int.parse(c['price'].toString()));

                    print("total cars: $total");
                    orderIds.add(c['id']);
                    orderTypes.add('car');
                  }
                  for (var g in priceGuideList) {
                    total =
                        // total + (int.parse(g['price'].toString()) * guideDays);
                    total + (int.parse(g['price'].toString()));

                    print("total guides: $total");
                    orderIds.add(g['id']);
                    orderTypes.add('guide');
                  }
                  var str = "";
                  for (var s in selectedTrips) {
                    str = "$str" + "${s['title']}";
                  }
                  print("orders $orderIds $orderTypes");

                  String orders = orderIds.toString().substring(1, orderIds.toString().length - 1);
                  String ordersTypes = orderTypes.toString().substring(1, orderTypes.toString().length - 1);

                  print("orders ids$orders");
                  print(" detail $total $str");

                  for (var e in selectedTrips) {
                    await WebServices.addTourBooking(
                        "${e['id']}", "${e['price']}");

                  }

                  for (var e in priceHotelRoomsList) {
                    var price = 0;
                    var rooms = 0;
                    List noRooms = [];
                    for (var e in priceHotelRoomsList) {
                      price = price + int.parse(e['price'].toString());
                      rooms = rooms + int.parse(e['no_rooms'].toString());
                      print(e);
                      for (var f in e['rooms']) {
                        noRooms.add(f);
                      }
                      // noRooms.add(e['rooms']);
                    }
                    // var tprice = price + int.parse("$_diff");

                    print("tprices $price");

                    await WebServices.addHotelBooking(
                        "${widget.item!.id}",
                        // "${_diff * (int.parse("${widget.item!.price}")+tprice)}",
                        "$price",
                        "$_diff",
                        "${noRooms.join(",")}",
                        "$rooms",
                        "$_startDate",
                        "$_endDate");
                  }

                  for (var e in priceCarList) {
                    await WebServices.addCarBooking(
                        "${e['id']}",
                        // "${_diff * int.parse(e['price'])}",
                        "${e['price']}",
                        "$_startDate",
                        "$_endDate",
                        "4");
                  }
                  for (var e in priceGuideList) {
                    await WebServices.addGuideBooking(
                        "${e['id']}",
                        // "${_diff * int.parse(e['price'])}",
                        "${e['price']}",
                        "$_startDate",
                        "$_endDate");
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOut(
                              id: "${widget.item!.id}",
                              img: "${AppConfig.srcLink}${widget.item!.image}",
                              name: "$name",
                              contact: "$contact",
                              type: "tripbooking",
                              bookingType: "trip",
                              title: "${widget.item!.title}",
                              orderId: "$orderId",
                              orderIds: orders,
                              orderTypes: ordersTypes,
                              // days: "$_diff",
                              price: "${widget.item!.price}",
                              totalPrice: "$total")));

                  // if (_startDate != null && _endDate != null) {
                  //   for (var e in selectedTrips) {
                  //     await WebServices.addTourBooking(
                  //         "${e['id']}", "${e['price']}");
                  //   }
                  //
                  //   for (var e in priceHotelRoomsList) {
                  //     var price=0;
                  //     var rooms = 0;
                  //     List noRooms =[];
                  //     for(var e in priceHotelRoomsList){
                  //       price = price + int.parse(e['price'].toString());
                  //       rooms = rooms + int.parse(e['no_rooms'].toString());
                  //       print(e);
                  //       for (var f in e['rooms']){
                  //         noRooms.add(f);
                  //
                  //       }
                  //       // noRooms.add(e['rooms']);
                  //     }
                  //     // var tprice = price + int.parse("${widget.item!.price}");
                  //     var tprice = price + int.parse("$_diff");
                  //
                  //     print("tprices $price");
                  //
                  //     await WebServices.addHotelBooking(
                  //         "${widget.item!.id}",
                  //         "${_diff * (int.parse("${widget.item!.price}")+tprice)}",
                  //         "$_diff",
                  //         "${noRooms.join(",")}",
                  //         "$rooms",
                  //         "$_startDate",
                  //         "$_endDate");
                  //
                  //   }
                  //
                  //   for (var e in priceCarList) {
                  //     await WebServices.addCarBooking(
                  //         "${e['id']}", "${_diff*int.parse(e['price'])}", "$_startDate", "$_endDate", "4");
                  //   }
                  //   for (var e in priceGuideList) {
                  //     await WebServices.addGuideBooking(
                  //         "${e['id']}", "${_diff*int.parse(e['price'])}", "$_startDate", "$_endDate");
                  //   }
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => CheckOut(
                  //               id: "${widget.item!.id}",
                  //               img:
                  //               "${AppConfig.srcLink}${widget.item!.image}",
                  //               name: "$name",
                  //               contact: "$contact",
                  //               type: "tripbooking",
                  //               title: "${widget.item!.title}",
                  //               orderId:"$orderId",
                  //               days: "$_diff",
                  //
                  //               price: "${widget.item!.price}",
                  //               totalPrice: "$total")));
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
              )
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Rules:",
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 children: [
        //                   Text("Check In: ",
        //                       style: TextStyle(
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
        //                   SizedBox(
        //                     width: 15,
        //                   ),
        //                   Text("${widget.item!.checkin}",
        //                       style: TextStyle(
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Text("Check Out: ",
        //                       style: TextStyle(
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
        //                   SizedBox(
        //                     width: 15,
        //                   ),
        //                   Text("${widget.item!.checkout}",
        //                       style: TextStyle(
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Text(
        //                 "Policies:",
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
        //               ),
        //               Row(
        //                 children: [
        //                   Text("${widget.item!.policyTitle}",
        //                       style: TextStyle(
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
        //                   SizedBox(
        //                     width: 15,
        //                   ),
        //                   Text("${widget.item!.policyContent}",
        //                       style: TextStyle(
        //                           color: AppConfig.tripColor,
        //                           fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
        //                 ],
        //               ),
        //             ],
        //           ),
        //
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 children: [
        //                   Row(
        //                     children: [
        //                       Text(
        //                           "Rs",
        //                           style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: AppConfig.f5,
        //                               color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
        //                       ),
        //                       Text(
        //                           " ${this.widget.item!.price}",
        //                           style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: AppConfig.f3,
        //                               color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
        //                       ),
        //                       SizedBox(
        //                         width: 5,
        //                       ),
        //                       Text("8700",
        //                           style: TextStyle(
        //                               decoration: TextDecoration.lineThrough,
        //                               color: AppConfig.tripColor,
        //                               fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
        //                     ],
        //                   ),
        //                   Text(
        //                       "Inclusive Tax",
        //                       style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: AppConfig.f5,
        //                           color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
        //                   )
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: 5,
        //               ),
        //               CustomBtn(
        //                 "Book Now",
        //                 _appConfig.rW(6),
        //                 AppConfig.hotelColor,
        //                 textColor: AppConfig.tripColor,
        //                 textSize: AppConfig.f5,
        //                 onPressed: ()async{
        //                   SharedPreferences prefs =
        //                   await SharedPreferences.getInstance();
        //                   var name = prefs.getString("name");
        //                   var contact = prefs.getString("contact");
        //                   await WebServices.addTourBooking(
        //                       "${widget.item!.id}", "${widget.item!.price}").then((value){
        //
        //                     for(var element in value){
        //                       orderId = element.lastid;
        //                       print("hello pk");
        //                       print(element.lastid);
        //                     }
        //                   });
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => CheckOut(
        //                               id: "${widget.item!.id}",
        //                               img:
        //                               "${AppConfig.srcLink}${widget.item!.image}",
        //                               name: "$name",
        //                               contact: "$contact",
        //                               type: "tripbooking",
        //                               title: "${widget.item!.title}",
        //                               orderId:"$orderId",
        //                               days: "$diff",
        //
        //                               price: "${widget.item!.price}",
        //                               totalPrice: "${widget.item!.price}")));
        //
        //                 },
        //               )
        //
        //             ],
        //           )
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          thickness: 2,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 0),
          height: _appConfig.rW(100),
          child: Column(
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                width: double.infinity,
                alignment: Alignment.center,
                child: TabBar(
                  isScrollable: true,
                  controller: _recommendedController,
                  unselectedLabelColor: AppConfig.tripColor,
                  labelColor: Colors.white,
                  indicatorWeight: 3,
                  indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: AppConfig.tripColor),
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "Car",
                        style:
                            TextStyle(fontFamily: AppConfig.fontFamilyRegular),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Hotel",
                        style:
                            TextStyle(fontFamily: AppConfig.fontFamilyRegular),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Guide",
                        style:
                            TextStyle(fontFamily: AppConfig.fontFamilyRegular),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _recommendedController,
                  children: <Widget>[
                    RecommendedCars(),
                    RecommendedHotelList(),
                    GuideRecommendedList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ])),
      drawer: const MyDrawer(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('_tabController', _tabController));
    properties.add(DiagnosticsProperty<TabController>(
        "_recommendedController", _recommendedController));
  }
}

class SelectedTripCard extends StatelessWidget {
  var item;
  SelectedTripCard({Key? key, this.item}) : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Container(
      // height: 200,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                // color: AppConfig.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.network(
                  "${AppConfig.srcLink}${item['image']}",
                  height: _appConfig.rH(12),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${item['title']}",
                style: TextStyle(
                    fontSize: AppConfig.f3,
                    fontWeight: FontWeight.bold,
                    color: AppConfig.tripColor,
                    fontFamily: AppConfig.fontFamilyRegular),
                textScaleFactor: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text("Rs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f5,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1),
                      Text(" ${item['price']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f3,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1),
                      SizedBox(
                        width: 5,
                      ),
                      Text("8700",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f5,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1)
                    ],
                  ),
                  Text("Inclusive Tax",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConfig.f5,
                          color: AppConfig.tripColor,
                          fontFamily: AppConfig.fontFamilyRegular),
                      textScaleFactor: 1)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TripReviewListItems extends StatelessWidget {
  final List<TripReviews>? items;
  var limit = 6;
  TripReviewListItems({Key? key, this.items});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items!.length < limit ? items!.length : limit,
      itemBuilder: (context, index) {
        return TripCardReview(item: items![index]);
      },
    );
  }
}

class TripCardReview extends StatelessWidget {
  final TripReviews? item;
  final Future<List<TripReviews>>? products;
  TripCardReview({Key? key, this.products, this.item}) : super(key: key);
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
                            color: AppConfig.tripColor,
                            fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        height: _appConfig.rH(1),
                      ),
                      Text("$formatted",
                          style: TextStyle(
                              fontSize: AppConfig.f5,
                              color: AppConfig.textColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1)
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
          Container(
              child: Text(
            "${item!.comment}",
            style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1,
          ))
        ],
      ),
    );
  }
}

class TripDetail extends StatelessWidget {
  final TripListModel? item;
  final Future<List<TripListModel>>? products;
  TripDetail({Key? key, this.products, this.item}) : super(key: key);
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
                fontSize: AppConfig.f3,
                color: AppConfig.tripColor,
                fontWeight: FontWeight.bold,
                fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${item!.description}",
            // overflow: TextOverflow.ellipsis,
            // maxLines: 7,
            style: TextStyle(
                fontSize: AppConfig.f4,
                color: AppConfig.textColor,
                fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "More",
                style: TextStyle(
                    color: AppConfig.carColor,
                    fontFamily: AppConfig.fontFamilyRegular),
                textScaleFactor: 1,
              )
            ],
          )
        ],
      ),
    );
  }
}
