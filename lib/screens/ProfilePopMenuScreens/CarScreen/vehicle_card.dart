import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_detail.dart';
import 'package:untitled/services/services.dart';

class BookVehicleCard extends StatefulWidget {
  final CarModel? item;

  var tour;
  BookVehicleCard({Key? key, this.item,this.tour}) : super(key: key);
  @override
  _BookVehicleCardState createState() => _BookVehicleCardState();
}

class _BookVehicleCardState extends State<BookVehicleCard> {
  late AppConfig _appConfig;
  bool isCarInWishList = false;
  bool isLoading = false;

  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getCarWishlist();
  }

  getCarWishlist() async {
    isLoading = true;
    await WebServices.checkCarInWishlist(widget.item!.id).then((wishlist) {
      // _categories = categories;
      print("categories in $wishlist");
      setState(() {
        isLoading = false;
        isCarInWishList = wishlist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            // height: 300,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppConfig.whiteColor,
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
                            height: _appConfig.rH(16),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: InkWell(
                        child: isCarInWishList?Icon(
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
                          showCustomToast();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          // prefs.remove('carId');
                          if (isCarInWishList) {
                            await prefs.setString(
                                'carId', "${widget.item!.id}");
                            await WebServices.removeCarWishlistItems()
                                .then((value) async {
                              await getCarWishlist();
                            });
                          } else {
                            await prefs.setString(
                                'carId', "${widget.item!.id}");
                            await WebServices.addCarWishlistItems()
                                .then((value) async {
                              await getCarWishlist();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _appConfig.rH(0.7),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                "${widget.item!.title}",
                                style: TextStyle(
                                    fontSize: AppConfig.f3,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.tripColor,
                                    fontFamily: AppConfig.fontFamilyRegular
                                ),
                                textScaleFactor: 1,
                              ),
                            ),
                            Text(
                              "Wagon",
                              style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1,
                            ),
                          ],
                        ),
                        RatingBarIndicator(
                          rating: double.parse("${widget.item!.brand}"),
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
                    SizedBox(
                      height: _appConfig.rH(0.7),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppConfig.textColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Facilities:",
                            style: TextStyle(
                              fontSize: AppConfig.f5,
                              color: AppConfig.whiteColor,
                                fontFamily: AppConfig.fontFamilyRegular
                            ),
                            textScaleFactor: 1,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.airline_seat_flat_angled,
                                size: _appConfig.rH(2),
                                color: AppConfig.whiteColor,
                              ),
                              Text(
                                "${this.widget.item!.passenger} Seater",
                                style: TextStyle(
                                  fontSize: AppConfig.f5,
                                  color: AppConfig.whiteColor,
                                    fontFamily: AppConfig.fontFamilyRegular
                                ),
                                textScaleFactor: 1,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: _appConfig.rH(2),
                                color: AppConfig.whiteColor,
                              ),
                              Text(
                                "${this.widget.item!.baggage} Bags",
                                style: TextStyle(
                                  fontSize: AppConfig.f5,
                                  color: AppConfig.whiteColor,
                                    fontFamily: AppConfig.fontFamilyRegular
                                ),
                                textScaleFactor: 1,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.airline_seat_flat,
                                size: _appConfig.rH(2),
                                color: AppConfig.whiteColor,
                              ),
                              Text(
                                "AC",
                                style: TextStyle(
                                  fontSize: AppConfig.f5,
                                  color: AppConfig.whiteColor,
                                    fontFamily: AppConfig.fontFamilyRegular
                                ),
                                textScaleFactor: 1,
                              )
                            ],
                          )
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
                                    Text(
                                      "RS-",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),
                                      textScaleFactor: 1,
                                    ),
                                    Text(
                                      " ${this.widget.item!.price}",
                                      style: TextStyle(
                                          fontSize: AppConfig.f3,
                                          fontWeight: FontWeight.bold,
                                          color: AppConfig.tripColor,
                                          fontFamily: AppConfig.fontFamilyRegular
                                      ),
                                      textScaleFactor: 1,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Inclusive of Tax",
                                  style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                                  textScaleFactor: 1,
                                )
                              ],
                            ),
                            Text(
                              'Rs- 12,125',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: AppConfig.f4,
                                  color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                              textScaleFactor: 1,
                            ),
                          ],
                        ),
                        widget.tour==null?CustomBtn(
                          "Book Now",
                          _appConfig.rW(6),
                          AppConfig.hotelColor,
                          textColor: AppConfig.tripColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehicleDetails(
                                        products: WebServices.carItems(),
                                        reviews: WebServices.carReviewItem(
                                            "${widget.item!.id}"),
                                        item: this.widget.item,
                                      )),
                            );
                          },
                          textSize: AppConfig.f5,
                        ):SizedBox()
                      ],
                    )
                  ],
                )
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
