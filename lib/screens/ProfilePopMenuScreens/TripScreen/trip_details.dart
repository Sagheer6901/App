import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:untitled/screens/NavigationScreens/map.dart';

import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_screen.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/checkout.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_detail_and_booking.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Cars/recommended_cars.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Guides/recommended_guides.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Hotels/recommended_hotels.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_list.dart';
import 'package:untitled/services/services.dart';

class TripDetails extends StatefulWidget {
  final TripListModel? item;
  final Future<List<TripListModel>>? products;
  final Future<List<TripReviews>>? reviews;
  TripDetails({Key? key, this.products, this.reviews, this.item})
      : super(key: key);
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails>
    with TickerProviderStateMixin {
  late TabController _tabController,_recommendedController;
  var limit=7;

  String? service;
  String? organization;
  String? friendliness;
  String? areaExpert;
  String? safety;
  String? totalRate;

  getTripRating() async {
    // isLoading = true;
    await WebServices.tripRating(widget.item!.id).then((ratings) {
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
    getTripRating();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _recommendedController = TabController(length: 3, vsync: this, initialIndex: 0);

  }
  var orderId;

  var checkIn,checkOut,date1,date2;
  var diff;

  Future startDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    setState(() {
      date1= newDate;
      checkIn = "${newDate!.year}-${newDate.month}-${newDate.day}";

    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Profile()),
    // );
  }
  Future endDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    setState(() {
      date2 = newDate;
      checkOut = "${newDate!.year}-${newDate.month}-${newDate.day}";

    });
    diff = date2.difference(date1).inDays;

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Profile()),
    // );
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
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
              Container(
                height: 200,
                margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
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
                        height: _appConfig.rH(12),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.item!.title}",
                          style: TextStyle(
                              fontSize: AppConfig.f3,
                              fontWeight: FontWeight.bold,
                              color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                        ),
                        // Text(
                        //   "Wagon",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: AppConfig.f4,
                        //       color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                        // ),
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
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    //   height: 25,
                    //   width: 105,
                    //   decoration: BoxDecoration(
                    //       color: AppConfig.tripColor,
                    //       borderRadius: BorderRadius.all(Radius.circular(18))),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         '${widget.item!.rating}',
                    //         style: TextStyle(color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                    //       ),
                    //       Icon(
                    //         Icons.star,
                    //         color: Colors.white,
                    //         size: _appConfig.rW(5),
                    //       ),
                    //       SizedBox(
                    //         width: 5,
                    //       ),
                    //       VerticalDivider(
                    //         color: AppConfig.whiteColor,
                    //         width: 10,
                    //       ),
                    //       SizedBox(
                    //         width: 5,
                    //       ),
                    //       Text(
                    //         '116',
                    //         style: TextStyle(color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
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
                            child: Text("Details",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                          ),
                          Tab(
                            child: Text("Review",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                          ),


                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          SingleChildScrollView(
                            child: TripDetail(
                              products: WebServices.tripItems(),
                              item: this.widget.item,
                            ),
                          ),
                          totalRate!=null?Rating(service: service,organization: organization,friendliness: friendliness,areaExpert: areaExpert,safety: safety,):Center(child: SizedBox(),),


                        ],
                      ),
                    ),
                  ],
                ),
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
                height: 15,
              ),
              Divider(
                height: 1,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rules:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Check In: ",
                                    style: TextStyle(
                                        color: AppConfig.tripColor,
                                        fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("${widget.item!.checkin}",
                                    style: TextStyle(
                                        color: AppConfig.tripColor,
                                        fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Check Out: ",
                                    style: TextStyle(
                                        color: AppConfig.tripColor,
                                        fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("${widget.item!.checkout}",
                                    style: TextStyle(
                                        color: AppConfig.tripColor,
                                        fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Policies:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                            ),
                            Row(
                              children: [
                                Text("${widget.item!.policyTitle}",
                                    style: TextStyle(
                                        color: AppConfig.tripColor,
                                        fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("${widget.item!.policyContent}",
                                    style: TextStyle(
                                        color: AppConfig.tripColor,
                                        fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
                              ],
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "Rs",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppConfig.f5,
                                            color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                    ),
                                    Text(
                                        " ${this.widget.item!.price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppConfig.f3,
                                            color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("8700",
                                        style: TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            color: AppConfig.tripColor,
                                            fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1)
                                  ],
                                ),
                                Text(
                                    "Inclusive Tax",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConfig.f5,
                                        color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // CustomBtn(
                            //   "Book Now",
                            //   _appConfig.rW(6),
                            //   AppConfig.hotelColor,
                            //   textColor: AppConfig.tripColor,
                            //   textSize: AppConfig.f5,
                            //   onPressed: ()async{
                            //     SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            //     var name = prefs.getString("name");
                            //     var contact = prefs.getString("contact");
                            //     await WebServices.addTourBooking(
                            //         "${widget.item!.id}", "${widget.item!.price}").then((value){
                            //
                            //       for(var element in value){
                            //         orderId = element.lastid;
                            //         print("hello pk");
                            //         print(element.lastid);
                            //       }
                            //     });
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => CheckOut(
                            //                 id: "${widget.item!.id}",
                            //                 img:
                            //                 "${AppConfig.srcLink}${widget.item!.image}",
                            //                 name: "$name",
                            //                 contact: "$contact",
                            //                 type: "tripbooking",
                            //                 title: "${widget.item!.title}",
                            //                 orderId:"$orderId",
                            //                 days: "$diff",
                            //
                            //                 price: "${widget.item!.price}",
                            //                 totalPrice: "${widget.item!.price}")));
                            //
                            //   },
                            // )

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),

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
              FutureBuilder<List<TripReviews>>(
                future: widget.reviews,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? TripReviewListItems(items: snapshot.data)

                  // return the ListView widget
                      : Center(child: CircularProgressIndicator());
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comment here",
                      style: TextStyle(
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.w700,
                          color: AppConfig.tripColor),textScaleFactor: 1,
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
                                            await WebServices.addTripRatingItems(
                                                dropdownServiceValue,
                                                dropdownOrganizationValue,
                                                dropdownFriendlinessValue,
                                                dropdownAreaExpertValue,
                                                dropdownSafetyValue,
                                                "${widget.item!.id}");

                                            await WebServices.addTripReviewItems(
                                                "${widget.item!.id}",
                                                _comments.text);
                                            await WebServices.addTripRateItems("$totalRate","${widget.item!.id}");

                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TripDetails(
                                                        products:
                                                        WebServices.tripItems(),
                                                        reviews: WebServices
                                                            .tripReviewItem(
                                                            "${widget.item!.id}"),
                                                        item: this.widget.item,
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Padding(
                    //       padding:
                    //       const EdgeInsets.symmetric(vertical: 8.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         children: [
                    //           CustomBtn(
                    //             "Send",
                    //             _appConfig.rW(6),
                    //             AppConfig.hotelColor,
                    //             textColor: AppConfig.tripColor,
                    //             onPressed: () async {
                    //               // await WebServices.addCarRatingItems(
                    //               //     dropdownServiceValue,
                    //               //     dropdownOrganizationValue,
                    //               //     dropdownFriendlinessValue,
                    //               //     dropdownAreaExpertValue,
                    //               //     dropdownSafetyValue,
                    //               //     "${widget.item!.id}");
                    //
                    //               await WebServices.addTripReviewItems(
                    //                   "${widget.item!.id}",
                    //                   _comments.text);
                    //
                    //               Navigator.of(context).pushReplacement(
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         TripDetails(
                    //                           products:
                    //                           WebServices.tripItems(),
                    //                           reviews: WebServices
                    //                               .tripReviewItem(
                    //                               "${widget.item!.id}"),
                    //                           item: this.widget.item,
                    //                         )),
                    //               );
                    //             },
                    //             height: 30,
                    //             textSize: AppConfig.f4,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "More Trips",
                  style: TextStyle(
                      fontSize: AppConfig.f3,
                      fontWeight: FontWeight.bold,
                      color: AppConfig.tripColor),textScaleFactor: 1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: _appConfig.rH(50),
                child: FutureBuilder<List<TripListModel>>(
                  future: widget.products,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? TripItems(items: snapshot.data,itemLimit: limit,)

                    // return the ListView widget :
                        : Center(child: CircularProgressIndicator());
                  },
                ),
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
    // properties.add(DiagnosticsProperty<TabController>("_recommendedController", _recommendedController));
  }
}

class TripReviewListItems extends StatelessWidget {
  final List<TripReviews>? items;
   var limit=6;
  TripReviewListItems({Key? key, this.items});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items!.length< limit?  items!.length:limit,
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
                      '${item!.image}'.contains('http')?'${item!.image}':'${AppConfig.srcLink}${item!.image}',
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
                              fontSize: AppConfig.f5, color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
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

class TripDetail extends StatelessWidget {
  final TripListModel? item;
  final Future<List<TripListModel>>? products;
  TripDetail({Key? key, this.products, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final maxLines= 5;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Lorem ipsum dollar",
          //   style: TextStyle(
          //       fontSize: AppConfig.f3,
          //       color: AppConfig.tripColor,
          //       fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
          // ),
          SizedBox(
            height: 10,
          ),
          ReadMoreText(
            "${item!.description}",
            // overflow: TextOverflow.ellipsis,
            trimLines: maxLines!=null?maxLines:2,
            trimCollapsedText: 'Read More',
            trimExpandedText: 'Read Less',
            style: TextStyle(
                fontSize: AppConfig.f4,
                color: AppConfig.textColor,
                fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Text(
          //       "More",
          //       style: TextStyle(color: AppConfig.carColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
