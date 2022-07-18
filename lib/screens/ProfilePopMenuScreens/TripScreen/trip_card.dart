import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_booking_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_details.dart';
import 'package:untitled/services/services.dart';

List selectedTrips = [];
List selectedTripIds = [];

class TripCard extends StatefulWidget {
  final TripListModel? item;
  final Future<List<TripListModel>>? products;

  TripCard({Key? key, this.products, this.item}) : super(key: key);
  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  late AppConfig _appConfig;
  late FToast fToast;
  bool isTripInWishlist = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getTripWishlist();
  }

  getTripWishlist() async {
    isLoading = true;
    await WebServices.checkTripInWishlist(widget.item!.id).then((wishlist) {
      // _categories = categories;
      print("categories in $wishlist");
      setState(() {
        isLoading = false;
        isTripInWishlist = wishlist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    // setState(() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('guideId','${widget.item!.id}');
    // });
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            // height: _appConfig.rH(27),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.only(right: 10),
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
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppConfig.tripColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        child: Image.network(
                          "${AppConfig.srcLink}${widget.item!.image}",
                          height: _appConfig.rH(26),
                          width: _appConfig.rW(30),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TripDetails(
                                                        products: WebServices
                                                            .tripItems(),
                                                        reviews: WebServices
                                                            .tripReviewItem(
                                                                "${widget.item!.id}"),
                                                        item: this.widget.item,
                                                      )),
                                            );
                                          },
                                          child: Text(
                                            "${widget.item!.title}",
                                            style: TextStyle(
                                                fontSize: AppConfig.f3,
                                                color: AppConfig.tripColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: AppConfig
                                                    .fontFamilyRegular),
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text("Age", style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                        //     Text("30 Years",
                                        //         style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Text("Experience",
                                        //         style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                        //     Text("30 Years",
                                        //         style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    InkWell(
                                      child: isTripInWishlist
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.redAccent,
                                              size: _appConfig.rH(4),
                                            )
                                          : Icon(
                                              Icons.favorite_outline_sharp,
                                              color: Colors.redAccent,
                                              size: _appConfig.rH(4),
                                            ),
                                      onTap: () async {
                                        showCustomToast();
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        // prefs.remove('carId');
                                        if (isTripInWishlist) {
                                          await prefs.setString(
                                              'tripId', "${widget.item!.id}");
                                          await WebServices
                                                  .removeTripWishlistItems()
                                              .then((value) async {
                                            await getTripWishlist();
                                          });
                                        } else {
                                          await prefs.setString(
                                              'tripId', "${widget.item!.id}");
                                          await WebServices
                                                  .addTripWishlistItems()
                                              .then((value) async {
                                            await getTripWishlist();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _appConfig.rH(1),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: _appConfig.rH(2.5),
                                          color: AppConfig.textColor,
                                        ),
                                        Text(
                                          "${widget.item!.address}",
                                          style: TextStyle(
                                              color: AppConfig.textColor,
                                              fontFamily:
                                                  AppConfig.fontFamilyRegular),
                                          textScaleFactor: 1,
                                        )
                                      ],
                                    ),
                                    RatingBarIndicator(
                                      rating: double.parse(
                                          "${widget.item!.rating}"),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: _appConfig.rW(5),
                                      unratedColor: Colors.amber.withAlpha(60),
                                      direction: Axis.horizontal,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _appConfig.rH(1),
                            ),
                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Rs ",
                                      style: TextStyle(
                                          color: AppConfig.tripColor,
                                          fontFamily:
                                              AppConfig.fontFamilyRegular),
                                      textScaleFactor: 1,
                                    ),
                                    Text(
                                      "${widget.item!.price}/-",
                                      style: TextStyle(
                                          fontSize: AppConfig.f4,
                                          fontWeight: FontWeight.bold,
                                          color: AppConfig.tripColor,
                                          fontFamily:
                                              AppConfig.fontFamilyRegular),
                                      textScaleFactor: 1,
                                    ),
                                    SizedBox(
                                      width: _appConfig.rW(20),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text("Per Day",
                                    //     style: TextStyle(color: AppConfig.tripColor),textScaleFactor: 1,),
                                    SizedBox(),

                                    // CustomBtn(
                                    //   "Book Now",
                                    //   _appConfig.rW(7),
                                    //   AppConfig.hotelColor,
                                    //   textColor: AppConfig.tripColor,
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               TripBookingDetailScreen(
                                    //                 products: WebServices.tripItems(),
                                    //                 reviews: WebServices.tripReviewItem(
                                    //                     "${widget.item!.id}"),
                                    //                 item: this.widget.item,
                                    //               )),
                                    //     );
                                    //   },                    textSize: AppConfig.f5,
                                    //
                                    // ),

                                    Container(
                                      child: Center(
                                        child: selectedTrips.toString().contains(
                                                    "${widget.item!.title}") !=
                                                true
                                            ? IconButton(
                                                icon: new Icon(Icons.add),
                                                onPressed: () {
                                                  var item = {};
                                                  setState(() {

                                                    item["id"] =
                                                        widget.item!.id;
                                                    item['title'] =
                                                        widget.item!.title;
                                                    item["description"] = widget
                                                        .item!.description;
                                                    item["video_link"] =
                                                        widget.item!.videoLink;
                                                    item["rating"] =
                                                        widget.item!.rating;
                                                    item["policy_title"] =
                                                        widget
                                                            .item!.policyTitle;
                                                    item["policy_content"] =
                                                        widget.item!
                                                            .policyContent;
                                                    item["address"] =
                                                        widget.item!.address;
                                                    item["checkin"] =
                                                        widget.item!.checkin;
                                                    item["checkout"] =
                                                        widget.item!.checkout;
                                                    item["location"] =
                                                        widget.item!.location;
                                                    item["duration"] =
                                                        widget.item!.duration;
                                                    item["price"] =
                                                        widget.item!.price;
                                                    item["availability"] =
                                                        widget
                                                            .item!.availability;
                                                    item["terms"] =
                                                        widget.item!.terms;
                                                    item["image"] =
                                                        widget.item!.image;
                                                    item["gallery"] =
                                                        widget.item!.gallery;
                                                    item["booked"] =
                                                        widget.item!.booked;
                                                    item["vender"] =
                                                        widget.item!.vender;
                                                    if (selectedTrips
                                                            .toString()
                                                            .contains(
                                                                "${widget.item!.title}") !=
                                                        true) {
                                                      selectedTrips.add(item);
                                                      selectedTripIds.add(
                                                          "${widget.item!.id}");
                                                      print(
                                                          "trip id: $selectedTripIds");
                                                    }
                                                    print(
                                                        "trips: $selectedTrips");
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content:
                                                          selectedTrips
                                                                      .length !=
                                                                  0
                                                              ? Row(
                                                                  children: [
                                                                    Text(
                                                                        'Yay! A SnackBar!'),
                                                                    CustomBtn(
                                                                      "Book Now",
                                                                      _appConfig
                                                                          .rW(7),
                                                                      AppConfig
                                                                          .hotelColor,
                                                                      textColor:
                                                                          AppConfig
                                                                              .tripColor,
                                                                      onPressed:
                                                                          () {
                                                                            ScaffoldMessenger.of(context)
                                                                                .removeCurrentSnackBar();
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => TripBookingDetailScreen(
                                                                                    products: WebServices.tripItems(),
                                                                                    reviews: WebServices.tripReviewItem("${widget.item!.id}"),
                                                                                    item: this.widget.item,
                                                                                  )),
                                                                        );
                                                                      },
                                                                      textSize:
                                                                          AppConfig
                                                                              .f5,
                                                                    ),
                                                                  ],
                                                                )
                                                              : Text("dfsf"),
                                                      duration: Duration(
                                                        days: 1,
                                                      ),
                                                    ));
                                                  });
                                                })
                                            : TextButton(
                                                onPressed: () {
                                                  print(
                                                      "start: $selectedTrips");

                                                  for (var e in selectedTrips) {
                                                    if (e.toString().contains(
                                                        "${widget.item!.title}")) {
                                                      setState(() {
                                                        selectedTrips.remove(e);
                                                        selectedTripIds.remove(
                                                            "${widget.item!.id}");
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
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: _appConfig.rH(1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppConfig.shadeColor,
      ),
      child: Text(
        "Marked Favourite",
        textScaleFactor: 1,
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 1),
    );
  }
}
