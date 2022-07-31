import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/Categories/tour_guide.dart';

import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/models/order_history_model.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_detail_and_booking.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_details.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list_card.dart';
import 'package:untitled/services/services.dart';

class OrderHistoryList extends StatefulWidget {
  // final Future<List<CarModel>>? hireACarW;
  // final Future<List<HotelModel>>? hotelBooking;
  // final Future<List<TourGuideModel>>? tourGuide;
  // final Future<List<TripListModel>>? trip;
  final String? categoryFilter;
  const OrderHistoryList({
    Key? key,
    this.categoryFilter,
  }) : super(key: key);

  @override
  _OrderHistoryListState createState() => _OrderHistoryListState();
}

class _OrderHistoryListState extends State<OrderHistoryList> {
  late AppConfig _appConfig;

  String? selectedValue;
  List<String> items = ["All", "Car", "Hotel", "Guide", "Trip"];

  getOrderHistory(type) {
    return WebServices.orderHistoryByType(type);
  }
  getOrderCarHistory() {
    return WebServices.carOrderHistory();
  }
  getOrderHotelHistory() {
    return WebServices.hotelOrderHistory();
  }
  getOrderGuideHistory() {
    return WebServices.guideOrderHistory();
  }
  getOrderTripHistory() {
    return WebServices.tripOrderHistory();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = widget.categoryFilter != null ? widget.categoryFilter : null;
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Scaffold(
      appBar: preferredSizeAppbar("Order History", context),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
              (route) => false);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: _appConfig.rWP(5),
                      vertical: _appConfig.rHP(2)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Your Bookings",
                          style: TextStyle(
                              fontSize: AppConfig.f4,
                              fontWeight: FontWeight.bold,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyMedium),
                          textScaleFactor: 1,
                        ),
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppConfig.tripColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'All',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppConfig.whiteColor,
                                          fontFamily:
                                              AppConfig.fontFamilyMedium),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppConfig.whiteColor,
                                              fontFamily:
                                                  AppConfig.fontFamilyMedium),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: AppConfig.whiteColor,
                              iconDisabledColor: AppConfig.tripColor,
                              buttonHeight: 30,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                // border: Border.all(
                                //   color: Colors.black26,
                                // ),
                                color: AppConfig.tripColor,
                              ),
                              buttonElevation: 2,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 120,
                              dropdownWidth: 160,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppConfig.tripColor,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(children: [
                if (selectedValue == null || selectedValue == "All")
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      FutureBuilder<List<OrderHistory>>(
                        future: getOrderCarHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? CarOrderList(
                                  items: snapshot.data,
                                  category: "Car",
                                )

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder<List<OrderHistory>>(
                        future: getOrderHotelHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? HotelOrderList(
                                  items: snapshot.data, category: "Hotel")

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder<List<OrderHistory>>(
                        future: getOrderGuideHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? GuideOrderList(
                                  items: snapshot.data, category: "Guide")

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder<List<OrderHistory>>(
                        future: getOrderTripHistory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? TripOrderList(
                                  items: snapshot.data, category: "Trip")

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  )
                else if (selectedValue == "Car")
                  FutureBuilder<List<OrderHistory>>(
                    future: getOrderHistory("car"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? CarOrderList(
                              items: snapshot.data,
                              category: "Car",
                            )

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  )
                else if (selectedValue == "Hotel")
                  FutureBuilder<List<OrderHistory>>(
                    future: getOrderHistory("hotel"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? HotelOrderList(
                              items: snapshot.data, category: "Hotel")

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  )
                else if (selectedValue == "Guide")
                  FutureBuilder<List<OrderHistory>>(
                    future: getOrderHistory("guide"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? GuideOrderList(
                              items: snapshot.data, category: "Guide")

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  )
                else if (selectedValue == "Trip")
                  FutureBuilder<List<OrderHistory>>(
                    future: getOrderHistory("trip"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? TripOrderList(
                              items: snapshot.data, category: "Trip")

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
                // SizedBox(
                //   height: 5,
                // ),
                // CustomBtn(
                //   "See more",
                //   60,
                //   AppConfig.hotelColor,
                //   textColor: AppConfig.tripColor,
                // ),
                SizedBox(
                  height: 5,
                ),
              ]),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}

class CarOrderList extends StatelessWidget {
  final List<OrderHistory>? items;
  final String? category;

  CarOrderList({Key? key, this.items, this.category});
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items!.length,
      itemBuilder: (context, index) {
        // return RemoveVehicleCard(item: items![index], category: category,);
        return BookingOrderCard(item: items![index], category: category);
      },
    );
  }
}

class HotelOrderList extends StatelessWidget {
  final List<OrderHistory>? items;
  final String? category;
  HotelOrderList({Key? key, this.items, this.category});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: items!.length,
          itemBuilder: (context, index) {
            // return RemoveHotelBookingCard(item: items![index], category: category);
            return BookingOrderCard(item: items![index], category: category);
          },
        ),
      ],
    );
  }
}

class GuideOrderList extends StatelessWidget {
  final List<OrderHistory>? items;
  final String? category;
  GuideOrderList({Key? key, this.items, this.category});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: items!.length,
          itemBuilder: (context, index) {
            // return RemoveGuideCard(item: items![index], category: category);
            return BookingOrderCard(item: items![index], category: category);
          },
        ),
      ],
    );
  }
}

class TripOrderList extends StatelessWidget {
  final List<OrderHistory>? items;
  final String? category;
  TripOrderList({Key? key, this.items, this.category});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: items!.length,
          itemBuilder: (context, index) {
            // return RemoveTripCard(item: items![index], category: category);
            return BookingOrderCard(item: items![index], category: category);
          },
        ),
      ],
    );
  }
}

class BookingOrderCard extends StatelessWidget {
  final OrderHistory? item;
  var category;
  // final Future<List<CarModel>>? products;
  BookingOrderCard({Key? key, this.category, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: _appConfig.rH(80),
      child: Column(
        children: [
          Container(
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
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "${item!.title}",
                  style: TextStyle(
                      fontFamily: AppConfig.fontFamilyRegular,
                      fontSize: AppConfig.f3),
                  textScaleFactor: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Status:",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    ),
                    Text(
                      item!.paymentStatus=="0"?"In Progress":"Paid",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Id:",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    ),
                    Text(
                      "${item!.id}",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Type :",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    ),
                    Text(
                      "${category}",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amount:",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    ),
                    Text(
                      "${item!.price}",
                      style: TextStyle(
                          fontFamily: AppConfig.fontFamilyRegular,
                          fontSize: AppConfig.f4),
                      textScaleFactor: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
