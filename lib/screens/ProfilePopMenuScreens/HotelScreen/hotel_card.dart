import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_detail_and_booking.dart';
import 'package:untitled/services/services.dart';

class HotelBookingCard extends StatefulWidget {
  final HotelModel item;

  var tour;
  HotelBookingCard({Key? key, this.tour, required this.item}) : super(key: key);
  @override
  _HotelBookingCardState createState() => _HotelBookingCardState();
}

class _HotelBookingCardState extends State<HotelBookingCard> {
  late AppConfig _appConfig;

  bool isHotelInWishList = false;
  bool isLoading = false;
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getHotelWishlist();
  }
  getHotelWishlist() async {
    isLoading = true;
    await WebServices.checkHotelInWishlist(widget.item.id).then((wishlist) {
      // _categories = categories;
      print("categories in $wishlist");
      setState(() {
        isLoading = false;
        isHotelInWishList = wishlist;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return  isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
      height: _appConfig.rH(30),
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
                    "${AppConfig.srcLink}${widget.item.image}",
                    height: _appConfig.rH(30),
                    width: _appConfig.rW(30),
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: FittedBox(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    this.widget.item.title!,
                                    style: TextStyle(
                                        fontSize: AppConfig.f2,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                  ),
                                  SizedBox(
                                    height: _appConfig.rH(1),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: _appConfig.rW(5),
                                        color: AppConfig.textColor,
                                      ),
                                      Container(
                                          width: _appConfig.rW(40),
                                          child: Text("${widget.item.address}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(color: AppConfig.textColor,fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,))
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(width: _appConfig.rW(2),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: isHotelInWishList?Icon(
                            Icons.favorite,
                            color: Colors.redAccent
                            ,
                            size: _appConfig.rH(4),
                          ):Icon(
                            Icons.favorite_outline_sharp,
                            color:  Colors.redAccent,

                            size: _appConfig.rH(4),
                          ),
                          onTap: () async {
                            // showCustomToast();
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            // prefs.remove('carId');
                            if (isHotelInWishList) {
                              // showCustomToast("Removed from Wishlist");

                              await prefs.setString(
                                  'hotelId', "${widget.item.id}");
                              await WebServices.removeHotelWishlistItems()
                                  .then((value) async {
                                await getHotelWishlist();
                              });
                            } else {
                              // showCustomToast("Marked Favourite");
                              await prefs.setString(
                                  'hotelId', "${widget.item.id}");
                              await WebServices.addHotelWishlistItems()
                                  .then((value) async {
                                await getHotelWishlist();
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  RatingBarIndicator(
                    rating: double.parse("${widget.item.rating}"),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: _appConfig.rW(5),

                    unratedColor: Colors.amber.withAlpha(60),
                    direction:  Axis.horizontal,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amenities: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppConfig.f5,
                              color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                        ),
                        Expanded(
                          child: Container(
                              // height: 35,
                              // width: 120,
                              child: Text(
                                this.widget.item.terms!,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: AppConfig.f5,
                                    color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                              )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                    " ${widget.item.price}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConfig.f3,
                                        color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                                  )
                                ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Per Night",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppConfig.f5,
                                    color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              widget.tour==null?CustomBtn(
                                "Book Now",
                                _appConfig.rW(7),
                                AppConfig.hotelColor,
                                textColor: AppConfig.tripColor,
                                onPressed: () async {
                                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                                  // var hotelId = prefs.setString("hotelId", '${widget.item.hotelId}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HotelDetailAndBooking(
                                              products: WebServices.hotelItems(),
                                              reviews: WebServices.hotelReviewItem("${widget.item.id}"),
                                              item: this.widget.item,
                                            )),
                                  );
                                },
                                textSize: AppConfig.f5,

                              ):SizedBox()
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  showCustomToast(text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppConfig.shadeColor,
      ),
      child: Text(text),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 1),
    );
  }
}



class HotelCard extends StatefulWidget {
  final HotelModel? item;
  final Future<List<HotelModel>>? products;
  HotelCard({Key? key, this.products, this.item}) : super(key: key);
  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    // setState(() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('hotelId','${widget.item!.id}');
    // });
    return Container(
      height: 300,
      margin: const EdgeInsets.all(20),
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
          Stack(
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
                      "${AppConfig.srcLink}${widget.item!.image}",
                      height: _appConfig.rH(15),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )),
              const Positioned(
                  right: 20, top: 20, child: const Icon(Icons.favorite))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.item!.title}",
                    style: TextStyle(
                        fontSize: AppConfig.f3,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.tripColor),
                  ),
                  Text(
                    "Wagon",
                    style: TextStyle(color: AppConfig.tripColor),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: AppConfig.textColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Facilities",
                        style: TextStyle(
                          fontSize: AppConfig.f6,
                          color: AppConfig.whiteColor,
                        )),
                    Text("${widget.item!.terms}",
                        style: TextStyle(
                          fontSize: AppConfig.f6,
                          color: AppConfig.whiteColor,
                        )),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.airline_seat_flat_angled,
                    //       size: 15,
                    //       color: AppConfig.whiteColor,
                    //     ),
                    //     Text(
                    //       "${this.widget.item!.passenger!} Seater",
                    //       style: TextStyle(
                    //         fontSize: AppConfig.f6,
                    //         color: AppConfig.whiteColor,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.shopping_bag,
                    //       size: 15,
                    //       color: AppConfig.whiteColor,
                    //     ),
                    //     Text("${this.widget.item!.baggage!} Bags",
                    //         style: TextStyle(
                    //           fontSize: AppConfig.f6,
                    //           color: AppConfig.whiteColor,
                    //         ))
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.airline_seat_flat,
                    //       size: 15,
                    //       color: AppConfig.whiteColor,
                    //     ),
                    //     Text("AC",
                    //         style: TextStyle(
                    //           fontSize: AppConfig.f6,
                    //           color: AppConfig.whiteColor,
                    //         ))
                    //   ],
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("RS-"),
                              Text(
                                " ${widget.item!.price}",
                                style: TextStyle(
                                    fontSize: AppConfig.f3,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.tripColor),
                              ),
                            ],
                          ),
                          Text(
                            "Inclusive of Tax",
                            style: TextStyle(color: AppConfig.tripColor),
                          )
                        ],
                      ),
                      Text('Rs- 12,125',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: AppConfig.f4,
                              color: AppConfig.tripColor)),
                    ],
                  ),
                  CustomBtn(
                    "Book Now",
                    30,
                    AppConfig.hotelColor,
                    textColor: AppConfig.tripColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HotelDetailAndBooking(
                              products: WebServices.hotelItems(),
                              item: this.widget.item,
                            )),
                      );
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

