import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/hotel_rooms.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_screen.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/checkout.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_booking_screen.dart';
import 'package:untitled/services/services.dart';

List priceHotelRoomsList = [];
var totalHotelRoomsPrice = 0;

class RoomDetailsCard extends StatefulWidget {
  final HotelModel? item;
  final Future<List<HotelModel>>? products;
  RoomDetailsCard({Key? key, this.products, this.item}) : super(key: key);
  @override
  _RoomDetailsCardState createState() => _RoomDetailsCardState();
}

class _RoomDetailsCardState extends State<RoomDetailsCard> {
  final List<String> imageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add("${AppConfig.srcLink}${widget.item!.image}");
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

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Container(
      child: Column(
        children: [
          // GFCarousel(
          //   items: imageList.map(
          //     (url) {
          //       return Container(
          //         margin: EdgeInsets.all(8.0),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
          //           child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
          //         ),
          //       );
          //     },
          //   ).toList(),
          //   onPageChanged: (index) {
          //     setState(() {
          //       index;
          //     });
          //   },
          // ),
          Divider(
            thickness: 2,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                // FittedBox(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         this.widget.item!.title!,
                //         style: TextStyle(
                //             fontSize: AppConfig.f4,
                //             fontWeight: FontWeight.bold,
                //             color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                //       ),
                //       const SizedBox(
                //         width: 40,
                //       ),
                //       Container(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //         margin:
                //             EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //         height: 25,
                //         width: 105,
                //         decoration: BoxDecoration(
                //             color: AppConfig.tripColor,
                //             borderRadius: BorderRadius.all(Radius.circular(18))),
                //         child: Row(
                //           children: [
                //             Text(
                //               '4.5',
                //               style: TextStyle(color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular),
                //             ),
                //             Icon(
                //               Icons.star,
                //               color: Colors.white,
                //               size: 15,
                //             ),
                //             SizedBox(
                //               width: 5,
                //             ),
                //             VerticalDivider(
                //               color: AppConfig.whiteColor,
                //               width: 10,
                //             ),
                //             SizedBox(
                //               width: 5,
                //             ),
                //             Text(
                //               '116',
                //               style: TextStyle(color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // Row(
                //   children: [
                //     Column(
                //       children: [
                //         Icon(
                //           Icons.people_outline,
                //           size: 30,
                //           color: AppConfig.tripColor,
                //         ),
                //         Text("Two People",
                //             style: TextStyle(
                //                 color: AppConfig.tripColor,
                //                 fontSize: AppConfig.f6,
                //                 fontWeight: FontWeight.w700,fontFamily: AppConfig.fontFamilyRegular))
                //       ],
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Column(children: [
                //       Icon(
                //         Icons.airline_seat_individual_suite,
                //         size: 30,
                //         color: AppConfig.tripColor,
                //       ),
                //       Text(
                //         "King Size Bed",
                //         style: TextStyle(
                //             color: AppConfig.tripColor,
                //             fontSize: AppConfig.f6,
                //             fontWeight: FontWeight.w700,fontFamily: AppConfig.fontFamilyRegular),
                //       )
                //     ]),
                //   ],
                // ),
                // SizedBox(
                //   height: 15,
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.wifi,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Free Wifi",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.free_breakfast,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Breakfast included",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.local_parking,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Parking facility",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.medical_services_outlined,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Medical Services",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
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
                            _endDate != null
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
                        Row(
                          children: [
                            Text(
                              "From Rs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConfig.f5,
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            Text(
                              " ${widget.item!.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConfig.f3,
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("8700",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppConfig.tripColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        Text(
                          "Per Night",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f5,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Rs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f3,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        ),
                        Text(
                          " ${widget.item!.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f3,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
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
                        var price=0;
                        var rooms = 0;
                        List noRooms =[];
                        for(var e in priceHotelRoomsList){
                          price = price + int.parse(e['price'].toString());
                          rooms = rooms + int.parse(e['no_rooms'].toString());
                          print(e);
                          for (var f in e['rooms']){
                            noRooms.add(f);

                          }
                          // noRooms.add(e['rooms']);
                        }
                        print("prices $price $rooms $noRooms");
                        if (_startDate != null && _endDate != null) {
                          // var tprice = price + int.parse("${widget.item!.price}");
                          // var tprice = price + int.parse("$_diff");

                          print("tprices $price");

                          await WebServices.addHotelBooking(
                                  "${widget.item!.id}",
                                  "${_diff * price}",
                                  "$_diff",
                                  "${noRooms.join(",")}",
                                  "$rooms",
                                  "$_startDate",
                                  "$_endDate")
                              .then((value) {
                            for (var element in value) {
                              orderId = element.lastid;
                              print("hello pk");
                              print(element.lastid);
                            }
                          });
                          print("$_diff ${_diff * price}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckOut(
                                      id: "${widget.item!.hotelId}",
                                      img:
                                          "${AppConfig.srcLink}${widget.item!.image}",
                                      name: "$name",
                                      contact: "$contact",
                                      type: "hotelbooking",
                                      bookingType:"hotel",
                                      title: "${widget.item!.title}",
                                      checkIn: "$_startDate",
                                      checkOut: "$_endDate",
                                      orderId: "$orderId",
                                      days: "$_diff",
                                      price: "$price",
                                      totalPrice:
                                          "${_diff * price}")));
                        }
                        else {
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoomCard extends StatefulWidget {
  final HotelRooms? item;
  final Future<List<HotelRooms>>? products;
  RoomCard({Key? key, this.products, this.item}) : super(key: key);
  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  final List<String> imageList = [];
  var diff;
  var orderId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add("${AppConfig.srcLink}${widget.item!.img1}");
    imageList.add("${AppConfig.srcLink}${widget.item!.img2}");
    imageList.add("${AppConfig.srcLink}${widget.item!.img3}");
  }

  var checkIn, checkOut, date1, date2;
  Future startDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    setState(() {
      date1 = newDate;
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
  String passengerDefalutValue = '0';

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Container(
      child: Column(
        children: [
          GFCarousel(
            items: imageList.map(
              (url) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              },
            ).toList(),
            onPageChanged: (index) {
              setState(() {
                index;
              });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Text(
                  this.widget.item!.title!,
                  style: TextStyle(
                      fontSize: AppConfig.f3,
                      fontWeight: FontWeight.bold,
                      color: AppConfig.tripColor,
                      fontFamily: AppConfig.fontFamilyRegular),
                  textScaleFactor: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Column(children: [
                      Icon(
                        Icons.airline_seat_individual_suite,
                        size: 30,
                        color: AppConfig.tripColor,
                      ),
                      Text(
                        "x${widget.item!.bed}",
                        style: TextStyle(
                            color: AppConfig.tripColor,
                            fontSize: AppConfig.f4,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConfig.fontFamilyRegular),
                      )
                    ]),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 30,
                          color: AppConfig.tripColor,
                        ),
                        Text("x${widget.item!.adult}",
                            style: TextStyle(
                                color: AppConfig.tripColor,
                                fontSize: AppConfig.f4,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConfig.fontFamilyRegular))
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.child_care_rounded,
                          size: 30,
                          color: AppConfig.tripColor,
                        ),
                        Text("x${widget.item!.children}",
                            style: TextStyle(
                                color: AppConfig.tripColor,
                                fontSize: AppConfig.f4,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConfig.fontFamilyRegular))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Room No:",
                        style: TextStyle(
                            color: AppConfig.textColor,
                            fontSize: AppConfig.f4,
                            fontFamily: AppConfig.fontFamilyRegular)),
                    SizedBox(
                      width: 15,
                    ),
                    Text("${widget.item!.numRoom}",
                        style: TextStyle(
                            color: AppConfig.textColor,
                            fontSize: AppConfig.f4,
                            fontFamily: AppConfig.fontFamilyRegular))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Attributes;",
                                  style: TextStyle(
                                      color: AppConfig.textColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular)),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text("${widget.item!.attribute}",
                                    style: TextStyle(
                                        color: AppConfig.textColor,
                                        fontSize: AppConfig.f5,
                                        fontFamily:
                                            AppConfig.fontFamilyRegular)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Check-In;",
                                  style: TextStyle(
                                      color: AppConfig.textColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular)),
                              SizedBox(
                                width: 15,
                              ),
                              Text("${widget.item!.checkin}",
                                  style: TextStyle(
                                      color: AppConfig.textColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Check-Out:",
                                  style: TextStyle(
                                      color: AppConfig.textColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular)),
                              SizedBox(
                                width: 15,
                              ),
                              Text("${widget.item!.checkout}",
                                  style: TextStyle(
                                      color: AppConfig.textColor,
                                      fontSize: AppConfig.f5,
                                      fontFamily: AppConfig.fontFamilyRegular))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          // Container(
                          //   child: Center(
                          //     child: priceHotelRoomsList
                          //                 .toString()
                          //                 .contains("${widget.item!.id}") !=
                          //             true
                          //         ? IconButton(
                          //             icon: new Icon(Icons.add),
                          //             onPressed: () {
                          //               var item = {};
                          //               setState(() {
                          //                 b = true;
                          //                 item["id"] = widget.item!.id;
                          //                 item["price"] = int.parse(
                          //                         "${widget.item!.price}") *
                          //                     int.parse(passengerDefalutValue);
                          //                 if (priceHotelRoomsList
                          //                         .toString()
                          //                         .contains(
                          //                             "${widget.item!.id}") !=
                          //                     true) {
                          //                   priceHotelRoomsList.add(item);
                          //                   setState(() {
                          //                     totalHotelRoomsPrice =
                          //                         totalHotelRoomsPrice +
                          //                             int.parse(
                          //                                 "${widget.item!.price}");
                          //                   });
                          //                   // priceList.add(
                          //                   //     "${widget.items![index].price}");
                          //                   print(
                          //                       "trip id: $priceHotelRoomsList");
                          //                 }
                          //
                          //                 print("trips: $priceHotelRoomsList");
                          //                 ScaffoldMessenger.of(context)
                          //                     .showSnackBar(SnackBar(
                          //                   content: priceHotelRoomsList
                          //                               .length !=
                          //                           0
                          //                       ? Row(
                          //                           children: [
                          //                             Text('Yay! A SnackBar!'),
                          //                             // CustomBtn(
                          //                             //   "Book Now",
                          //                             //   _appConfig
                          //                             //       .rW(7),
                          //                             //   AppConfig
                          //                             //       .hotelColor,
                          //                             //   textColor:
                          //                             //   AppConfig
                          //                             //       .tripColor,
                          //                             //   onPressed:
                          //                             //       () {
                          //                             //     setState(
                          //                             //             () {
                          //                             //           ScaffoldMessenger.of(context)
                          //                             //               .removeCurrentSnackBar();
                          //                             //         });
                          //                             //     Navigator
                          //                             //         .push(
                          //                             //       context,
                          //                             //       MaterialPageRoute(
                          //                             //           builder: (context) => TripBookingDetailScreen(
                          //                             //             products: WebServices.tripItems(),
                          //                             //             reviews: WebServices.tripReviewItem("${widget.item!.id}"),
                          //                             //             item: this.widget.item,
                          //                             //           )),
                          //                             //     );
                          //                             //   },
                          //                             //   textSize:
                          //                             //   AppConfig
                          //                             //       .f5,
                          //                             // ),
                          //                           ],
                          //                         )
                          //                       : Text("dfsf"),
                          //                   duration: Duration(
                          //                     days: 1,
                          //                   ),
                          //                 ));
                          //               });
                          //             })
                          //         : TextButton(
                          //             onPressed: () {
                          //               print("start: $priceHotelRoomsList");
                          //
                          //               for (var e in priceHotelRoomsList) {
                          //                 if (e.toString().contains(
                          //                     "${widget.item!.price}")) {
                          //                   // b=false;
                          //                   setState(() {
                          //                     priceHotelRoomsList.remove(e);
                          //                     priceHotelRoomsList
                          //                         .remove("${widget.item!.id}");
                          //                     totalHotelRoomsPrice =
                          //                         totalHotelRoomsPrice -
                          //                             int.parse(
                          //                                 "${widget.item!.price}");
                          //                   });
                          //                 }
                          //               }
                          //             },
                          //             child: Text("UnSelect")),
                          //   ),
                          // ),
                        Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text("Select Rooms: ",
                                          style: TextStyle(
                                              color: AppConfig.textColor,
                                              fontSize: AppConfig.f4,
                                              fontFamily:
                                                  AppConfig.fontFamilyRegular)),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      color: AppConfig.shadeColor,
                                      child: DropdownButton<String>(
                                        value: passengerDefalutValue,

                                        // icon: const Icon(Icons.arrow_downward),
                                        elevation: 5,
                                        style: TextStyle(
                                            color: AppConfig.tripColor),
                                        underline: Container(
                                          color: AppConfig.shadeColor,
                                        ),
                                        onChanged: (String? newValue) {

                                            passengerDefalutValue = newValue!;
                                            var item = {};

                                            print("price: ${item['price']}");
                                          setState(() {
                                            // b = true;
                                            item["id"] = widget.item!.id;
                                            print(int.parse(
                                                "${widget.item!.price}") *
                                                int.parse(passengerDefalutValue));
                                            item["price"] =
                                                int.parse(
                                                "${widget.item!.price}") *
                                                int.parse(passengerDefalutValue);
                                            List rooms=[];
                                            for(var e=0 ;e<int.parse(passengerDefalutValue);e++){
                                              rooms.add(widget.item!.id);
                                            }
                                            item['rooms']=rooms;
                                            item['no_rooms']=passengerDefalutValue;
                                            if (priceHotelRoomsList
                                                .toString()
                                                .contains(
                                                "${widget.item!.id}") !=
                                                true) {
                                              priceHotelRoomsList.add(item);
                                              setState(() {
                                                totalHotelRoomsPrice =
                                                    totalHotelRoomsPrice +
                                                        int.parse(
                                                            "${widget.item!.price}");
                                              });
                                              // priceList.add(
                                              //     "${widget.items![index].price}");
                                              print(
                                                  "trip id: $priceHotelRoomsList");
                                            }
                                            else if(priceHotelRoomsList
                                                .toString()
                                                .contains(
                                                "${widget.item!.id}") ==
                                                true) {
                                              // priceHotelRoomsList.add(item);
                                              for(var e in priceHotelRoomsList){
                                                if(e.toString().contains("${widget.item!.id}")){
                                                  e['price']=   int.parse(
                                                      "${widget.item!.price}") *
                                                      int.parse(passengerDefalutValue);
                                                  e['rooms']=rooms;
                                                  e['no_rooms']=passengerDefalutValue;
                                                }
                                              }
                                              setState(() {
                                                totalHotelRoomsPrice =
                                                    totalHotelRoomsPrice +
                                                        int.parse(
                                                            "${widget.item!.price}");
                                              });
                                              // priceList.add(
                                              //     "${widget.items![index].price}");
                                              print(
                                                  "trip id: $priceHotelRoomsList");
                                            }
                                            //
                                            // else {
                                            // for (var e in priceHotelRoomsList) {
                                            //   if (e.toString().contains(
                                            //       "${widget.item!.price}")) {
                                            //     // b=false;
                                            //     setState(() {
                                            //       priceHotelRoomsList.remove(e);
                                            //       priceHotelRoomsList
                                            //           .remove("${widget.item!.id}");
                                            //       totalHotelRoomsPrice =
                                            //           totalHotelRoomsPrice -
                                            //               int.parse(
                                            //                   "${widget.item!.price}");
                                            //     });
                                            //   }
                                            // }
                                            // }
                                            print("trips: $priceHotelRoomsList");

                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //   content: priceHotelRoomsList
                                            //       .length !=
                                            //       0
                                            //       ? Row(
                                            //     children: [
                                            //       Text('Yay! A SnackBar!'),
                                            //       // CustomBtn(
                                            //       //   "Book Now",
                                            //       //   _appConfig
                                            //       //       .rW(7),
                                            //       //   AppConfig
                                            //       //       .hotelColor,
                                            //       //   textColor:
                                            //       //   AppConfig
                                            //       //       .tripColor,
                                            //       //   onPressed:
                                            //       //       () {
                                            //       //     setState(
                                            //       //             () {
                                            //       //           ScaffoldMessenger.of(context)
                                            //       //               .removeCurrentSnackBar();
                                            //       //         });
                                            //       //     Navigator
                                            //       //         .push(
                                            //       //       context,
                                            //       //       MaterialPageRoute(
                                            //       //           builder: (context) => TripBookingDetailScreen(
                                            //       //             products: WebServices.tripItems(),
                                            //       //             reviews: WebServices.tripReviewItem("${widget.item!.id}"),
                                            //       //             item: this.widget.item,
                                            //       //           )),
                                            //       //     );
                                            //       //   },
                                            //       //   textSize:
                                            //       //   AppConfig
                                            //       //       .f5,
                                            //       // ),
                                            //     ],
                                            //   )
                                            //       : Text("dfsf"),
                                            //   duration: Duration(
                                            //     days: 1,
                                            //   ),
                                            // ));
                                          });

                                          // setState(() {
                                          //   print(
                                          //       "hotels rooms $priceHotelRoomsList");
                                          //   passengerDefalutValue = newValue!;
                                          //   if (priceHotelRoomsList
                                          //       .toString()
                                          //       .contains(
                                          //           "${widget.item!.id}")) {
                                          //     for (var e
                                          //         in priceHotelRoomsList) {
                                          //       print(
                                          //           "index ${priceHotelRoomsList.indexOf(e.toString().contains("${widget.item!.id}"))}");
                                          //       priceHotelRoomsList[
                                          //                   priceHotelRoomsList
                                          //                       .indexOf(e
                                          //                           .toString()
                                          //                           .contains(
                                          //                               "${widget.item!.id}"))]
                                          //               ['no_rooms'] =
                                          //           passengerDefalutValue;
                                          //     }
                                          //     print(
                                          //         "hotels rooms $priceHotelRoomsList");
                                          //   }
                                          // }
                                          // );
                                        },
                                        items: <String>['4', '3', '2', '1', '0']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child:
                                                Text(value, textScaleFactor: 1),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            Text(
                              " ${widget.item!.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConfig.f3,
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("8700",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppConfig.tripColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        Text(
                          "Per Night",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f5,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class RoomRecommendedDetailsCard extends StatefulWidget {
  final HotelModel? item;
  final Future<List<HotelModel>>? products;
  RoomRecommendedDetailsCard({Key? key, this.products, this.item}) : super(key: key);
  @override
  _RoomRecommendedDetailsCardState createState() => _RoomRecommendedDetailsCardState();
}

class _RoomRecommendedDetailsCardState extends State<RoomRecommendedDetailsCard> {
  final List<String> imageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add("${AppConfig.srcLink}${widget.item!.image}");
  }

  var diff;
  var orderId;

  var checkIn, checkOut, date1, date2;
  Future startDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    setState(() {
      date1 = newDate;
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

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Container(
      child: Column(
        children: [
          Divider(
            thickness: 2,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.wifi,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Free Wifi",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.free_breakfast,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Breakfast included",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.local_parking,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Parking facility",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.medical_services_outlined,
                              size: 25,
                              color: AppConfig.textColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Medical Services",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Text(
                              "From Rs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConfig.f5,
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            Text(
                              " ${widget.item!.price}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConfig.f3,
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyRegular),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("8700",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppConfig.tripColor,
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular))
                          ],
                        ),
                        Text(
                          "Per Night",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f5,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Rs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f3,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        ),
                        Text(
                          " ${widget.item!.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f3,
                              color: AppConfig.tripColor,
                              fontFamily: AppConfig.fontFamilyRegular),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
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
                        var price=0;
                        var rooms = 0;
                        List noRooms =[];
                        for(var e in priceHotelRoomsList){
                          price = price + int.parse(e['price'].toString());
                          rooms = rooms + int.parse(e['no_rooms'].toString());
                          print(e);
                          for (var f in e['rooms']){
                            noRooms.add(f);

                          }
                          // noRooms.add(e['rooms']);
                        }
                        print("prices $price $rooms $noRooms");
                        Navigator
                            .push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripBookingDetailScreen(
                                products: WebServices.tripItems(),
                                reviews: WebServices.tripReviewItem("${widget.item!.id}"),
                                // item: this.widget.item,
                              )),
                        );
                        // if (checkIn != null && checkOut != null) {
                        //   // var tprice = price + int.parse("${widget.item!.price}");
                        //   var tprice = price + int.parse("$diff");
                        //
                        //   print("tprices $price");
                        //
                        //   await WebServices.addHotelBooking(
                        //       "${widget.item!.id}",
                        //       "${diff * (int.parse("${widget.item!.price}")+tprice)}",
                        //       "$diff",
                        //       "${noRooms.join(",")}",
                        //       "$rooms",
                        //       "$checkIn",
                        //       "$checkOut")
                        //       .then((value) {
                        //     for (var element in value) {
                        //       orderId = element.lastid;
                        //       print("hello pk");
                        //       print(element.lastid);
                        //     }
                        //   });
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => CheckOut(
                        //               id: "${widget.item!.hotelId}",
                        //               img:
                        //               "${AppConfig.srcLink}${widget.item!.image}",
                        //               name: "$name",
                        //               contact: "$contact",
                        //               type: "hotelbooking",
                        //               title: "${widget.item!.title}",
                        //               checkIn: "$checkIn",
                        //               checkOut: "$checkOut",
                        //               orderId: "$orderId",
                        //               days: "$diff",
                        //               price: "${widget.item!.price}",
                        //               totalPrice:
                        //               "${diff * (int.parse("${widget.item!.price}")+tprice)}")));
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}