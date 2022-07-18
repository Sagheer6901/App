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
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_detail_and_booking.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_details.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list_card.dart';
import 'package:untitled/services/services.dart';

class WishList extends StatefulWidget {
  // final Future<List<CarModel>>? hireACarW;
  // final Future<List<HotelModel>>? hotelBooking;
  // final Future<List<TourGuideModel>>? tourGuide;
  // final Future<List<TripListModel>>? trip;
  final String? category;
  const WishList({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late AppConfig _appConfig;

  String? selectedValue;
  List<String> items = ["All", "Car", "Hotel", "Guide", "Trip"];

  getCarWishlist() {
    return WebServices.carWishlistItems();
  }

  getHotelWishlist() {
    return WebServices.hotelWishlistItems();
  }

  getGuideWishlist() {
    return WebServices.tourGuideWishlistItems();
  }

  getTripWishlist() {
    return WebServices.tripWishlistItems();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = widget.category != null ? widget.category : null;
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Scaffold(
      appBar: preferredSizeAppbar("WishList", context),
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
                          "Your Plans",
                          style: TextStyle(
                              fontSize: AppConfig.f4,
                              fontWeight: FontWeight.bold,
                              color: AppConfig.carColor,
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
                                      'Select Category',
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
                      FutureBuilder<List<CarModel>>(
                        future: getCarWishlist(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? RemoveCarListItem(
                                  items: snapshot.data,
                                  category: "All",
                                )

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder<List<HotelModel>>(
                        future: getHotelWishlist(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? RemoveHotelListItem(
                                  items: snapshot.data, category: "All")

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder<List<TourGuideModel>>(
                        future: getGuideWishlist(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? RemoveGuideTourListItem(
                                  items: snapshot.data, category: "All")

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder<List<TripListModel>>(
                        future: getTripWishlist(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? RemoveTripListItem(
                                  items: snapshot.data, category: "All")

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  )
                else if (selectedValue == "Car")
                  FutureBuilder<List<CarModel>>(
                    future: getCarWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? RemoveCarListItem(
                              items: snapshot.data,
                              category: "Car",
                            )

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  )
                else if (selectedValue == "Hotel")
                  FutureBuilder<List<HotelModel>>(
                    future: getHotelWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? RemoveHotelListItem(
                              items: snapshot.data, category: "Hotel")

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  )
                else if (selectedValue == "Guide")
                  FutureBuilder<List<TourGuideModel>>(
                    future: getGuideWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? RemoveGuideTourListItem(
                              items: snapshot.data, category: "Guide")

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  )
                else if (selectedValue == "Trip")
                  FutureBuilder<List<TripListModel>>(
                    future: getTripWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? RemoveTripListItem(
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

              // Container(
              //   // height: 300,
              //   margin: EdgeInsets.all(20),
              //   padding: EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: const BorderRadius.all(Radius.circular(30)),
              //     boxShadow: const [
              //       BoxShadow(
              //         color: Colors.black12,
              //         offset: Offset(0, 5),
              //         blurRadius: 10,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       InkWell(
              //         child: Stack(
              //           children: [
              //             Container(
              //                 decoration: BoxDecoration(
              //                   // color: AppConfig.primaryColor,
              //                   borderRadius:
              //                       const BorderRadius.all(Radius.circular(30)),
              //                 ),
              //                 child: ClipRRect(
              //                   borderRadius: const BorderRadius.all(
              //                     Radius.circular(20),
              //                   ),
              //                   child: Image.asset(
              //                     "assets/images/mingora.jpg",
              //                     height: 200,
              //                     width: double.infinity,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 )),
              //             Positioned(
              //                 right: 20, top: 20, child: Icon(Icons.favorite))
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: _appConfig.rH(1),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("Mingora",
              //                   style: TextStyle(
              //                       fontSize: AppConfig.f3,
              //                       fontWeight: FontWeight.bold,
              //                       color: AppConfig.tripColor),textScaleFactor: 1,),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Row(
              //                 children: [
              //                   Icon(
              //                     Icons.location_on_outlined,
              //                     size: 20,
              //                     color: AppConfig.textColor,
              //                   ),
              //                   Text("Swat,Pakistan",
              //                       style:
              //                           TextStyle(color: AppConfig.textColor),textScaleFactor: 1,)
              //                 ],
              //               )
              //             ],
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //               Text("Return Trip",
              //                   style: TextStyle(
              //                       fontSize: AppConfig.f4,
              //                       fontWeight: FontWeight.bold,
              //                       color: AppConfig.tripColor),textScaleFactor: 1,),
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.end,
              //                 children: [
              //                   Text("Rs",textScaleFactor: 1,),
              //                   Text(" 5000",
              //                       style: TextStyle(
              //                           fontSize: AppConfig.f4,
              //                           fontWeight: FontWeight.bold,
              //                           color: AppConfig.tripColor),textScaleFactor: 1,),
              //                   Text(" for 5 hours",textScaleFactor: 1,)
              //                 ],
              //               )
              //             ],
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 450,
              //   child: FutureBuilder<List<Trip>>(
              //     future: widget.trip,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) print(snapshot.error);
              //       return snapshot.hasData
              //           ? TripListItems(items: snapshot.data)
              //
              //       // return the ListView widget :
              //           : Center(child: CircularProgressIndicator());
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}

class RemoveCarListItem extends StatelessWidget {
  final List<CarModel>? items;
  var category;

  RemoveCarListItem({Key? key, this.items, this.category});
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
        return InkWell(
          child: RemoveVehicleCard(
            item: items![index],
            category: category,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CarDetails(item: items![index])),
            );
          },
        );
      },
    );
  }
}

class CarDetails extends StatelessWidget {
  final CarModel? item;
  final Future<List<CarModel>>? products;
  CarDetails({Key? key, this.products, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return VehicleDetails(
      products: WebServices.carItems(),
      reviews: WebServices.carReviewItem("${item!.id}"),
      item: this.item,
    );
  }
}

class RemoveHotelListItem extends StatelessWidget {
  final List<HotelModel>? items;
  final String? category;
  RemoveHotelListItem({Key? key, this.items, this.category});
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
            return InkWell(
              child: RemoveHotelBookingCard(
                  item: items![index], category: category),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelDetails(
                          products: WebServices.hotelItems(),
                          item: items![index])),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class HotelDetails extends StatelessWidget {
  final HotelModel? item;
  final Future<List<HotelModel>>? products;
  HotelDetails({Key? key, this.products, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HotelDetailAndBooking(
      products: WebServices.hotelItems(),
      reviews: WebServices.hotelReviewItem("${item!.id}"),
      item: this.item,
    );
  }
}

class RemoveGuideTourListItem extends StatelessWidget {
  final List<TourGuideModel>? items;
  final String? category;
  RemoveGuideTourListItem({Key? key, this.items, this.category});
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
            return InkWell(
              child: RemoveGuideCard(item: items![index], category: category),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GuideDetails(
                          products: WebServices.tourGuideItems(),
                          reviews: WebServices.guideReviewItem(
                              "${items![index].id}"),
                          item: items![index])),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class RemoveTripListItem extends StatelessWidget {
  final List<TripListModel>? items;
  final String? category;
  RemoveTripListItem({Key? key, this.items, this.category});
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
            return InkWell(
              child: RemoveTripCard(item: items![index], category: category),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TripDetails(
                            products: WebServices.tripItems(),
                            reviews: WebServices.tripReviewItem(
                                "${items![index].id}"),
                            item: items![index],
                          )),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

// class TourGuideDetails extends StatelessWidget {
//   final TourGuideModel? item;
//   final Future<List<TourGuideModel>>? products;
//   TourGuideDetails({Key? key, this.products, this.item}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return G(
//       products: WebServices.tourGuideItems(),
//       item: this.item,
//     );
//   }
// }
