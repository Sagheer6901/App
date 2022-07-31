import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
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
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_screen.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/checkout.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/services/services.dart';

class GuideDetails extends StatefulWidget {
  final TourGuideModel? item;
  final Future<List<TourGuideModel>>? products;
  final Future<List<GuideReview>>? reviews;
  GuideDetails({Key? key, this.products, this.reviews, this.item})
      : super(key: key);
  @override
  _GuideDetailsState createState() => _GuideDetailsState();
}

class _GuideDetailsState extends State<GuideDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var limit = 7;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
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
                                  "${AppConfig.srcLink}${widget.item!.gallery}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
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
                                  "${AppConfig.srcLink}${widget.item!.gallery}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
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
                                  "${AppConfig.srcLink}${widget.item!.gallery}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                      ),
                    ],
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
                        color: AppConfig.tripColor,
                        fontFamily: AppConfig.fontFamilyRegular),
                    textScaleFactor: 1,
                  ),
                  // Text(
                  //   "Wagon",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: AppConfig.f4,
                  //       color: AppConfig.tripColor),textScaleFactor: 1,
                  // ),
                  RatingBarIndicator(
                    rating: double.parse("${widget.item!.rating}"),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    unratedColor: Colors.amber.withAlpha(60),
                    direction: Axis.horizontal,
                  )
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
              //         style: TextStyle(color: AppConfig.whiteColor),textScaleFactor: 1,
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
              //         style: TextStyle(color: AppConfig.whiteColor),textScaleFactor: 1,
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
          // height: _appConfig.rW(65),
          child: TourGuideDetails(
            products: WebServices.tourGuideItems(),
            item: this.widget.item,
          ),
        ),
        SizedBox(
          height: 10,
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
                "Guide Details:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConfig.tripColor,
                    fontFamily: AppConfig.fontFamilyRegular, fontSize: AppConfig.f3),
                textScaleFactor: 1,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Location: ",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1),
                          SizedBox(
                            width: 15,
                          ),
                          Text("${widget.item!.location}",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Name: ",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1),
                          SizedBox(
                            width: 15,
                          ),
                          Text("${widget.item!.title}",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Age: ",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1),
                          SizedBox(
                            width: 15,
                          ),
                          Text("30 Years",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Experience: ",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1),
                          SizedBox(
                            width: 15,
                          ),
                          Text("30 Years",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("CheckIn: ",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1),
                          SizedBox(
                            width: 15,
                          ),
                          Text("${widget.item!.checkin}",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("CheckOut: ",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1),
                          SizedBox(
                            width: 15,
                          ),
                          Text("${widget.item!.checkout}",
                              style: TextStyle(
                                  color: AppConfig.tripColor,
                                  fontSize: AppConfig.f5,
                                  fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      fontFamily: AppConfig.fontFamilyRegular),
                                  textScaleFactor: 1)
                              : Text("PickDate",
                                  style: TextStyle(
                                      color: AppConfig.tripColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular),
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
                      SizedBox(
                        height: 10,
                      ),
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
                          _endDate != null
                              ? Text("$_endDate",
                                  style: TextStyle(
                                      color: AppConfig.tripColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular),
                                  textScaleFactor: 1)
                              : Text("PickDate",
                                  style: TextStyle(
                                      color: AppConfig.tripColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular),
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
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(" ${this.widget.item!.price}",
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
                          textScaleFactor: 1),
                    ],
                  ),
                  CustomBtn(
                    "Book Now",
                    _appConfig.rW(6),
                    AppConfig.hotelColor,
                    textColor: AppConfig.tripColor,
                    textSize: AppConfig.f5,
                    onPressed: () async {
                      print("diff $_diff   ${_diff*int.parse('${widget.item!.price}')}");

                      if (_startDate != null && _endDate != null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var name = prefs.getString("name");
                        var contact = prefs.getString("contact");
                        var totalPrice =   _diff==0?"${widget.item!.price}":"${(_diff+1)*int.parse('${widget.item!.price}')}";

                        await WebServices.addGuideBooking(
                                "${widget.item!.id}",
                                "$totalPrice",
                                "$_startDate",
                                "$_endDate")
                            .then((value) {
                          for (var element in value) {
                            orderId = element.lastid;
                            print("hello pk$orderId");
                            print(element.lastid);
                          }
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckOut(
                                    id: "${widget.item!.guideId}",
                                    img:
                                        "${AppConfig.srcLink}${widget.item!.image}",
                                    name: "$name",
                                    contact: "$contact",
                                    type: "guidebooking",
                                    bookingType:"guide",
                                    title: "${widget.item!.title}",
                                    checkIn: "$_startDate",
                                    checkOut: "$_endDate",
                                    orderId: "$orderId",
                                    days: "${_diff+1}",
                                    price: "${widget.item!.price}",
                                    totalPrice:"$totalPrice"
                                    // _startDate.toString().contains(_endDate.toString())?"${widget.item!.price}":"${_diff*int.parse('${widget.item!.price}')}"
                                ),
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: 'Invalid',
                                subtitle: 'PickDate plz',
                                primaryAction: () {
                                  Navigator.pop(context);
                                },
                                primaryActionText: 'Okay',
                              );
                            });
                      }
                    },
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
        FutureBuilder<List<GuideReview>>(
          future: widget.reviews,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? GuideReviewListItems(items: snapshot.data)

                // return the ListView widget :
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
                    color: AppConfig.tripColor,
                    fontFamily: AppConfig.fontFamilyRegular),
                textScaleFactor: 1,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomBtn(
                          "Send",
                          _appConfig.rW(6),
                          AppConfig.hotelColor,
                          textColor: AppConfig.tripColor,
                          onPressed: () async {
                            // await WebServices.addCarRatingItems(
                            //     dropdownServiceValue,
                            //     dropdownOrganizationValue,
                            //     dropdownFriendlinessValue,
                            //     dropdownAreaExpertValue,
                            //     dropdownSafetyValue,
                            //     "${widget.item!.id}");

                            await WebServices.addGuideReviewItems(
                                "${widget.item!.id}", _comments.text);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => GuideDetails(
                                        products: WebServices.tourGuideItems(),
                                        reviews: WebServices.guideReviewItem(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "More Guides",
            style: TextStyle(
                fontSize: AppConfig.f3,
                fontWeight: FontWeight.bold,
                color: AppConfig.tripColor,
                fontFamily: AppConfig.fontFamilyRegular),
            textScaleFactor: 1,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: _appConfig.rH(50),
          child: FutureBuilder<List<TourGuideModel>>(
            future: widget.products,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? TourGuideItems(
                      items: snapshot.data,
                      itemLimit: limit,
                    )

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
  }
}

class GuideReviewListItems extends StatelessWidget {
  final List<GuideReview>? items;
  var limit = 6;
  GuideReviewListItems({Key? key, this.items});
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
        return GuideCardReview(item: items![index]);
      },
    );
  }
}

class GuideCardReview extends StatelessWidget {
  final GuideReview? item;
  final Future<List<GuideReview>>? products;
  GuideCardReview({Key? key, this.products, this.item}) : super(key: key);
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

class TourGuideDetails extends StatefulWidget {
  final TourGuideModel? item;
  final Future<List<TourGuideModel>>? products;
  TourGuideDetails({Key? key, this.products, this.item}) : super(key: key);

  @override
  State<TourGuideDetails> createState() => _TourGuideDetailsState();
}

class _TourGuideDetailsState extends State<TourGuideDetails> {
  bool isReadmore=false;

  @override
  Widget build(BuildContext context) {
    final  maxLines =isReadmore?null:5;
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
          //       fontWeight: FontWeight.bold,
          //       fontFamily: AppConfig.fontFamilyRegular),
          //   textScaleFactor: 1,
          // ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ReadMoreText(
                "${widget.item!.description}",
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
              //     builBtn()
              //   ],
              // )

            ],
          ),
        ],
      ),
    );
  }
  Widget builBtn(){
    return                   TextButton(
      onPressed: (){
        setState(() {
          isReadmore !=isReadmore;

        });
      },
      child: Text(
        isReadmore?"Read Less":"Read More",
        style: TextStyle(
            color: AppConfig.carColor,
            fontFamily: AppConfig.fontFamilyRegular),
        textScaleFactor: 1,
      ),
    );

  }
}
