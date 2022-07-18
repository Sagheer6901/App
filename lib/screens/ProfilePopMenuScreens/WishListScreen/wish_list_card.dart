import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list.dart';
import 'package:untitled/services/services.dart';


class RemoveVehicleCard extends StatefulWidget {
  final CarModel? item;
  var category;
  final Future<List<CarModel>>? products;
  RemoveVehicleCard({Key? key, this.products, this.item,this.category}) : super(key: key);
  @override
  _RemoveVehicleCardState createState() => _RemoveVehicleCardState();
}

class _RemoveVehicleCardState extends State<RemoveVehicleCard> {
  late AppConfig _appConfig;
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  // Widget build(BuildContext context) {
  //   _appConfig = AppConfig(context);
  //
  //   return Container(
  //     height: 300,
  //     margin: const EdgeInsets.all(20),
  //     padding: const EdgeInsets.all(20),
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(30)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 5),
  //           blurRadius: 10,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Stack(
  //           children: [
  //             Container(
  //                 decoration: const BoxDecoration(
  //                   // color: AppConfig.primaryColor,
  //                   borderRadius: BorderRadius.all(Radius.circular(30)),
  //                 ),
  //                 child: ClipRRect(
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(20),
  //                   ),
  //                   child: Image.network(
  // "${AppConfig.srcLink}${widget.item!.image}",
  //                     height: _appConfig.rH(15),
  //                     width: double.infinity,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 )),
  //             // Positioned(
  //             //     right: 20,
  //             //     top: 20,
  //             //     child: InkWell(
  //             //         child:  Icon(Icons.favorite,color: _iconColor,),
  //             //         onTap: _iconColor == Colors.grey ? :(){}
  //             //     ))
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "${widget.item!.title}",
  //                   style: TextStyle(
  //                       fontSize: AppConfig.f3,
  //                       fontWeight: FontWeight.bold,
  //                       color: AppConfig.tripColor),
  //                 ),
  //                 Text(
  //                   "Wagon",
  //                   style: TextStyle(color: AppConfig.tripColor),
  //                 )
  //               ],
  //             ),
  //             const SizedBox(
  //               height: 5,
  //             ),
  //             Container(
  //               padding:
  //               const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
  //               decoration: BoxDecoration(
  //                 color: AppConfig.textColor,
  //                 borderRadius: BorderRadius.all(Radius.circular(30)),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text("Facilities",
  //                       style: TextStyle(
  //                         fontSize: AppConfig.f6,
  //                         color: AppConfig.whiteColor,
  //                       )),
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.airline_seat_flat_angled,
  //                         size: 15,
  //                         color: AppConfig.whiteColor,
  //                       ),
  //                       Text(
  //                         "${this.widget.item!.passenger} Seater",
  //                         style: TextStyle(
  //                           fontSize: AppConfig.f6,
  //                           color: AppConfig.whiteColor,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.shopping_bag,
  //                         size: 15,
  //                         color: AppConfig.whiteColor,
  //                       ),
  //                       Text("${this.widget.item!.baggage} Bags",
  //                           style: TextStyle(
  //                             fontSize: AppConfig.f6,
  //                             color: AppConfig.whiteColor,
  //                           ))
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         Icons.airline_seat_flat,
  //                         size: 15,
  //                         color: AppConfig.whiteColor,
  //                       ),
  //                       Text("AC",
  //                           style: TextStyle(
  //                             fontSize: AppConfig.f6,
  //                             color: AppConfig.whiteColor,
  //                           ))
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Text("RS-"),
  //                             Text(
  //                               " ${this.widget.item!.price}",
  //                               style: TextStyle(
  //                                   fontSize: AppConfig.f3,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: AppConfig.tripColor),
  //                             ),
  //                           ],
  //                         ),
  //                         Text(
  //                           "Inclusive of Tax",
  //                           style: TextStyle(color: AppConfig.tripColor),
  //                         )
  //                       ],
  //                     ),
  //                     Text('Rs- 12,125',
  //                         style: TextStyle(
  //                             decoration: TextDecoration.lineThrough,
  //                             fontSize: AppConfig.f4,
  //                             color: AppConfig.tripColor)),
  //                   ],
  //                 ),
  //                 CustomBtn(
  //                   "Remove",
  //                   30,
  //                   AppConfig.hotelColor,
  //                   textColor: AppConfig.tripColor,
  //                   onPressed: ()async{
  //                     SharedPreferences prefs = await SharedPreferences.getInstance();
  //                     // prefs.remove('carId');
  //                     prefs.setString('carId',"${widget.item!.wishlistId}");
  //                     WebServices.removeCarWishlistItems().then((value) async {
  //                       print("response: $value");
  //                       // Profile(userName: _newController.text,);
  //                       // if (value == "name_change_success") {
  //                       //   Navigator.of(context).pushReplacement(
  //                       //     MaterialPageRoute(
  //                       //         builder: (context) => Profile()),
  //                       //   );
  //                       // }
  //                     });
  //                     // setState(() {
  //                     //   if (_iconColor == Colors.grey)    _iconColor = Colors.red;
  //                     //   else _iconColor = Colors.grey;
  //                     // });
  //
  //
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => WishList(hireACarW: WebServices.carWishlistItems(),
  //                             hotelBooking: WebServices.hotelWishlistItems(),
  //                             tourGuide: WebServices.tourGuideWishlistItems(),
  //                             trip: WebServices.tripWishlistItems(),)),
  //                     );
  //                   }
  //
  //
  //                   //     () {
  //                   //   Navigator.push(
  //                   //     context,
  //                   //     MaterialPageRoute(
  //                   //         builder: (context) => VehicleDetails(
  //                   //           products: WebServices.carItems(),
  //                   //           item: this.widget.item,
  //                   //         )),
  //                   //   );
  //                   // },
  //                 )
  //               ],
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Container(
      // height: 300,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration:  BoxDecoration(
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
              // Positioned(
              //     right: 20,
              //     top: 20,
              //     child: InkWell(
              //
              //         child: Icon(Icons.favorite_outline_sharp,color:Colors.redAccent,size: _appConfig.rH(4),),
              //         onTap: () async {
              //           // showCustomToast();
              //           SharedPreferences prefs = await SharedPreferences
              //               .getInstance();
              //           // prefs.remove('carId');
              //           prefs.setString('carId', "${widget.item!.id}");
              //           WebServices.addCarWishlistItems().then((value) async {
              //             print("Car added to wishlist");
              //             // Profile(userName: _newController.text,);
              //             // if (value == "name_change_success") {
              //             //   Navigator.of(context).pushReplacement(
              //             //     MaterialPageRoute(
              //             //         builder: (context) => Profile()),
              //             //   );
              //             // }
              //           });
              //         }
              //     ))
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
                              color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                        ),
                      ),
                      Text(
                        "Wagon",
                        style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                      ),

                    ],
                  ),
                  RatingBarIndicator(
                    rating: double.parse("${widget.item!.brand}"),
                    itemBuilder: (context, index) =>
                        Icon(
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
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: AppConfig.textColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Facilities:",
                        style: TextStyle(
                          fontSize: AppConfig.f5,
                          color: AppConfig.whiteColor,
                        ),textScaleFactor: 1,),
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
                            color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular
                          ),textScaleFactor: 1,
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
                        Text("${this.widget.item!.baggage} Bags",
                            style: TextStyle(
                              fontSize: AppConfig.f5,
                              color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular
                            ),textScaleFactor: 1,)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.airline_seat_flat,
                          size: _appConfig.rH(2),
                          color: AppConfig.whiteColor,
                        ),
                        Text("AC",
                            style: TextStyle(
                              fontSize: AppConfig.f5,
                              color: AppConfig.whiteColor,fontFamily: AppConfig.fontFamilyRegular
                            ),textScaleFactor: 1,)
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
                              Text("RS-",textScaleFactor: 1,),
                              Text(
                                " ${this.widget.item!.price}",
                                style: TextStyle(
                                    fontSize: AppConfig.f3,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                              ),
                            ],
                          ),
                          Text(
                            "Inclusive of Tax",
                            style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                          )
                        ],
                      ),
                      Text('Rs- 12,125',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: AppConfig.f4,
                              color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                    ],
                  ),
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
                  //               VehicleDetails(
                  //                 products: WebServices.carItems(),
                  //                 reviews: WebServices.carReviewItem(
                  //                     "${widget.item!.id}"),
                  //                 item: this.widget.item,
                  //               )),
                  //     );
                  //   },
                  //   textSize: AppConfig.f5,
                  // )

                  CustomBtn(
                      "Remove",
                    _appConfig.rW(7),
                    AppConfig.hotelColor,
                    textColor: AppConfig.tripColor,
                      onPressed: ()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.remove('carId');
                        prefs.setString('carId',"${widget.item!.id}");
                        WebServices.removeCarWishlistItems().then((value) async {
                          print("Car removed");
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishList(
                                category: widget.category,)),
                        );
                      },
                    textSize: AppConfig.f5,


//     () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => VehicleDetails(
//           products: WebServices.carItems(),
//           item: this.widget.item,
//         )),
//   );
// },
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








class RemoveHotelBookingCard extends StatefulWidget {
  final HotelModel item;
  final Future<List<HotelModel>>? products;
  final String? category;
  RemoveHotelBookingCard({Key? key, this.products, required this.item, this.category}) : super(key: key);
  @override
  _RemoveHotelBookingCardState createState() => _RemoveHotelBookingCardState();
}

class _RemoveHotelBookingCardState extends State<RemoveHotelBookingCard> {
  late AppConfig _appConfig;

  @override
  // Widget build(BuildContext context) {
  //   _appConfig = AppConfig(context);
  //   return Container(
  //     height: _appConfig.rH(22),
  //     margin: const EdgeInsets.all(20),
  //     padding: const EdgeInsets.only(right: 10),
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(30)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 5),
  //           blurRadius: 10,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //               decoration: BoxDecoration(
  //                 color: AppConfig.tripColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     bottomLeft: Radius.circular(30)),
  //               ),
  //               child: ClipRRect(
  //                 borderRadius: const BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     bottomLeft: Radius.circular(30)),
  //                 child: Image.network(
  //                   "${AppConfig.srcLink}${widget.item.image}",
  //                   height: _appConfig.rH(22),
  //                   width: _appConfig.rW(30),
  //                   fit: BoxFit.cover,
  //                 ),
  //               )),
  //         ),
  //         Expanded(
  //           flex: 4,
  //           child: Container(
  //             margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "${widget.item.title}",
  //                       style: TextStyle(
  //                           fontSize: AppConfig.f4,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.location_on_outlined,
  //                           size: 20,
  //                           color: AppConfig.textColor,
  //                         ),
  //                         SizedBox(
  //                             width: 150,
  //                             child: Text("${widget.item.address}",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 maxLines: 1,
  //                                 style: TextStyle(color: AppConfig.textColor)))
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //                 RatingBar.builder(
  //                   initialRating: 4,
  //                   minRating: 1,
  //                   direction: Axis.horizontal,
  //                   allowHalfRating: true,
  //                   itemCount: 5,
  //                   itemSize: 15,
  //                   itemPadding: const EdgeInsets.symmetric(),
  //                   itemBuilder: (context, _) => const Icon(
  //                     Icons.star,
  //                     color: Colors.amber,
  //                   ),
  //                   onRatingUpdate: (rating) {
  //                     print(rating);
  //                     // return int.parse()this.widget.item!.rating!;
  //                   },
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       "Amenities: ",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: AppConfig.f6,
  //                           color: AppConfig.textColor),
  //                     ),
  //                     Container(
  //                         height: 35,
  //                         width: 120,
  //                         child: SingleChildScrollView(
  //                           child: Text("${widget.item.terms}",
  //                             overflow: TextOverflow.clip,
  //                             style: TextStyle(
  //                                 fontSize: AppConfig.f6,
  //                                 color: AppConfig.textColor),
  //                           ),
  //                         )),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text(
  //                                   "Rs",
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: AppConfig.f5,
  //                                       color: AppConfig.tripColor),
  //                                 ),
  //                                 Text(
  //                                   " ${this.widget.item.price}",
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: AppConfig.f3,
  //                                       color: AppConfig.tripColor),
  //                                 )
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               width: 5,
  //                             ),
  //                             Text("8700",
  //                                 style: TextStyle(
  //                                     decoration: TextDecoration.lineThrough,
  //                                     color: AppConfig.tripColor,
  //                                     fontSize: AppConfig.f5))
  //                           ],
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               "Per Night",
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: AppConfig.f5,
  //                                   color: AppConfig.tripColor),
  //                             ),
  //                             const SizedBox(
  //                               width: 25,
  //                             ),
  //                             CustomBtn(
  //                               "Remove",
  //                               30,
  //                               AppConfig.hotelColor,
  //                               textColor: AppConfig.tripColor,
  //                                 onPressed: ()async{
  //                                   SharedPreferences prefs = await SharedPreferences.getInstance();
  //                                   // prefs.remove('carId');
  //                                   prefs.setString('hotelId',"${widget.item.wishlistId}");
  //                                   WebServices.removeHotelWishlistItems().then((value) async {
  //                                     print("response: $value");
  //                                     // Profile(userName: _newController.text,);
  //                                     // if (value == "name_change_success") {
  //                                     //   Navigator.of(context).pushReplacement(
  //                                     //     MaterialPageRoute(
  //                                     //         builder: (context) => Profile()),
  //                                     //   );
  //                                     // }
  //                                   });
  //                                   // setState(() {
  //                                   //   if (_iconColor == Colors.grey)    _iconColor = Colors.red;
  //                                   //   else _iconColor = Colors.grey;
  //                                   // });
  //
  //
  //                                   Navigator.push(
  //                                     context,
  //                                     MaterialPageRoute(
  //                                         builder: (context) => WishList(hireACarW: WebServices.carWishlistItems(),
  //                                           hotelBooking: WebServices.hotelWishlistItems(),
  //                                           tourGuide: WebServices.tourGuideWishlistItems(),
  //                                           trip: WebServices.tripWishlistItems(),)),
  //                                   );
  //                                 },
  //                             )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Container(
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
                                        fontSize: AppConfig.f3,
                                        fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                  ),
                                  SizedBox(
                                    height: _appConfig.rH(1),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: _appConfig.rH(2),
                                        color: AppConfig.textColor,
                                      ),
                                      Container(
                                          width: _appConfig.rW(40),
                                          child: Text("${widget.item.address}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(color: AppConfig.textColor,fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,))
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(width: _appConfig.rW(2),),
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: InkWell(
                      //       child:  Padding(
                      //         padding: const EdgeInsets.only(right: 10.0),
                      //         child: Icon(Icons.favorite_outline_sharp,color:Colors.redAccent,size: _appConfig.rH(4),),
                      //       ),
                      //       onTap: ()async{
                      //         // showCustomToast();
                      //
                      //         SharedPreferences prefs = await SharedPreferences.getInstance();
                      //         // prefs.remove('carId');
                      //         prefs.setString('hotelId',"${widget.item.id}");
                      //         WebServices.addHotelWishlistItems().then((value) async {
                      //           print("response: ${widget.item.id}");
                      //           // Profile(userName: _newController.text,);
                      //           // if (value == "name_change_success") {
                      //           //   Navigator.of(context).pushReplacement(
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) => Profile()),
                      //           //   );
                      //           // }
                      //         });
                      //       }
                      //   ),
                      // )
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
                              color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
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
                                    color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
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
                                        color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                  ),
                                  Text(
                                    " ${widget.item.price}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConfig.f3,
                                        color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
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
                                      fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
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
                                    color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              // CustomBtn(
                              //   "Book Now",
                              //   _appConfig.rW(7),
                              //   AppConfig.hotelColor,
                              //   textColor: AppConfig.tripColor,
                              //   onPressed: () async {
                              //     // SharedPreferences prefs = await SharedPreferences.getInstance();
                              //     // var hotelId = prefs.setString("hotelId", '${widget.item.hotelId}');
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               HotelDetailAndBooking(
                              //                 products: WebServices.hotelItems(),
                              //                 reviews: WebServices.hotelReviewItem("${widget.item.id}"),
                              //                 item: this.widget.item,
                              //               )),
                              //     );
                              //   },
                              // )

                              CustomBtn(
                                "Remove",
                                _appConfig.rW(7),
                                AppConfig.hotelColor,
                                textColor: AppConfig.tripColor,
                                onPressed: ()async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.remove('carId');
                                  prefs.setString('hotelId',"${widget.item.id}");
                                  WebServices.removeHotelWishlistItems().then((value) async {
                                    print("Hotel removed${widget.item.id}");
// Profile(userName: _newController.text,);
// if (value == "name_change_success") {
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//         builder: (context) => Profile()),
//   );
// }
                                  });
// setState(() {
//   if (_iconColor == Colors.grey)    _iconColor = Colors.red;
//   else _iconColor = Colors.grey;
// });


                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WishList(
                                          category: widget.category,)),
                                  );
                                },
                                textSize: AppConfig.f5,

                              )

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

}





class RemoveGuideCard extends StatefulWidget {
  final TourGuideModel? item;
  final Future<List<TourGuideModel>>? products;
  final String? category;
  RemoveGuideCard({Key? key, this.products, this.item, this.category}) : super(key: key);
  @override
  _RemoveGuideCardState createState() => _RemoveGuideCardState();
}

class _RemoveGuideCardState extends State<RemoveGuideCard> {
  late AppConfig _appConfig;

  @override
  // Widget build(BuildContext context) {
  //   _appConfig = AppConfig(context);
  //   // setState(() async {
  //   //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   prefs.setString('guideId','${widget.item!.id}');
  //   // });
  //   return Container(
  //     height: _appConfig.rH(22),
  //     margin: const EdgeInsets.all(20),
  //     padding: const EdgeInsets.only(right: 10),
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(30)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 5),
  //           blurRadius: 10,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //               decoration: BoxDecoration(
  //                 color: AppConfig.tripColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     bottomLeft: Radius.circular(30)),
  //               ),
  //               child: ClipRRect(
  //                 borderRadius: const BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     bottomLeft: Radius.circular(30)),
  //                 child: Image.network(
  //                   "${AppConfig.srcLink}${widget.item!.image}",
  //                   height: _appConfig.rH(22),
  //                   width: _appConfig.rW(30),
  //                   fit: BoxFit.cover,
  //                 ),
  //               )),
  //         ),
  //
  //         Expanded(
  //           flex: 4,
  //           child: Container(
  //             margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
  //             child: Column(
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "${widget.item!.title}",
  //                               style: TextStyle(
  //                                   fontSize: AppConfig.f3,
  //                                   color: AppConfig.tripColor,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                             Row(
  //                               children: [
  //                                 Text("Age", style: TextStyle(color: AppConfig.textColor)),
  //                                 Text("30 Years",
  //                                     style: TextStyle(color: AppConfig.textColor))
  //                               ],
  //                             ),
  //                             Row(
  //                               children: [
  //                                 Text("Experience",
  //                                     style: TextStyle(color: AppConfig.textColor)),
  //                                 Text("30 Years",
  //                                     style: TextStyle(color: AppConfig.textColor))
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                         // InkWell(
  //                         //     child:  Icon(Icons.favorite,color: Colors.red.shade300,size: 35,),
  //                         //     onTap:  ()async{
  //                         //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //                         //       // prefs.remove('carId');
  //                         //       prefs.setString('guideId',"${widget.item!.id}");
  //                         //       WebServices.addTourGuideWishlistItems().then((value) async {
  //                         //         print("response: $value");
  //                         //         // Profile(userName: _newController.text,);
  //                         //         // if (value == "name_change_success") {
  //                         //         //   Navigator.of(context).pushReplacement(
  //                         //         //     MaterialPageRoute(
  //                         //         //         builder: (context) => Profile()),
  //                         //         //   );
  //                         //         // }
  //                         //       });
  //                         //
  //                         //     }
  //                         // ),
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.location_on_outlined,
  //                                   size: 20,
  //                                   color: AppConfig.textColor,
  //                                 ),
  //                                 Text("${widget.item!.address}",
  //                                     style: TextStyle(color: AppConfig.textColor))
  //                               ],
  //                             ),
  //                             RatingBarIndicator(
  //                               rating: double.parse("${widget.item!.rating}"),
  //                               itemBuilder: (context, index) => Icon(
  //                                 Icons.star,
  //                                 color: Colors.amber,
  //                               ),
  //                               itemCount: 5,
  //                               itemSize: 20.0,
  //
  //                               unratedColor: Colors.amber.withAlpha(60),
  //                               direction:  Axis.horizontal,
  //                             )
  //                           ],
  //                         ),
  //                         Column(
  //                           // crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text(
  //                                   "Rs ",
  //                                   style: TextStyle(color: AppConfig.tripColor),
  //                                 ),
  //                                 Text("${widget.item!.price}/-",
  //                                     style: TextStyle(
  //                                         fontSize: AppConfig.f4,
  //                                         fontWeight: FontWeight.bold,
  //                                         color: AppConfig.tripColor)),
  //                                 const SizedBox(
  //                                   width: 25,
  //                                 ),
  //
  //                               ],
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Text("Per Day",
  //                                     style: TextStyle(color: AppConfig.tripColor)),
  //                                 CustomBtn(
  //                                   "Remove",
  //                                   30,
  //                                   AppConfig.hotelColor,
  //                                   textColor: AppConfig.tripColor,
  //                                   onPressed: ()async{
  //                                     SharedPreferences prefs = await SharedPreferences.getInstance();
  //                                     // prefs.remove('carId');
  //                                     prefs.setString('guideId',"${widget.item!.wishlistId}");
  //                                     WebServices.removeTouGuideWishlistItems().then((value) async {
  //                                       print("response: $value");
  //                                       // Profile(userName: _newController.text,);
  //                                       // if (value == "name_change_success") {
  //                                       //   Navigator.of(context).pushReplacement(
  //                                       //     MaterialPageRoute(
  //                                       //         builder: (context) => Profile()),
  //                                       //   );
  //                                       // }
  //                                     });
  //
  //
  //
  //                                     Navigator.push(
  //                                       context,
  //                                       MaterialPageRoute(
  //                                           builder: (context) => WishList(hireACarW: WebServices.carWishlistItems(),
  //                                             hotelBooking: WebServices.hotelWishlistItems(),
  //                                             tourGuide: WebServices.tourGuideWishlistItems(),
  //                                             trip: WebServices.tripWishlistItems(),)),
  //                                     );
  //                                   },
  //                                 ),
  //
  //                               ],
  //                             )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                   ],
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    // setState(() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('guideId','${widget.item!.id}');
    // });
    return Container(
      // height: _appConfig.rH(25),
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
              margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.item!.title}",
                                    style: TextStyle(
                                        fontSize: AppConfig.f3,
                                        color: AppConfig.tripColor,
                                        fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),
                                  ),
                                  Row(
                                    children: [
                                      Text("Age", style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                      Text("30 Years",
                                          style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Experience",
                                          style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                      Text("30 Years",
                                          style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                    ],
                                  ),
                                ],
                              ),
                              // InkWell(
                              //     child:  Padding(
                              //       padding: const EdgeInsets.only(right: 10.0),
                              //       child: Icon(Icons.favorite_outline_sharp,color:Colors.redAccent,size: _appConfig.rH(4),),
                              //     ),
                              //     onTap:  ()async{
                              //
                              //       SharedPreferences prefs = await SharedPreferences.getInstance();
                              //       // prefs.remove('carId');
                              //       prefs.setString('guideId',"${widget.item!.id}");
                              //       WebServices.addTourGuideWishlistItems().then((value) async {
                              //         print("response: ${widget.item!.id}");
                              //         // Profile(userName: _newController.text,);
                              //         // if (value == "name_change_success") {
                              //         //   Navigator.of(context).pushReplacement(
                              //         //     MaterialPageRoute(
                              //         //         builder: (context) => Profile()),
                              //         //   );
                              //         // }
                              //       });
                              //
                              //     }
                              // ),
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
                                  Expanded(
                                    child: Text("${widget.item!.address}",
                                        style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                  )
                                ],
                              ),
                              RatingBarIndicator(
                                rating: double.parse("${widget.item!.rating}"),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: _appConfig.rW(5),

                                unratedColor: Colors.amber.withAlpha(60),
                                direction:  Axis.horizontal,
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
                                style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                              ),
                              Text("${widget.item!.price}/-",
                                  style: TextStyle(
                                      fontSize: AppConfig.f4,
                                      fontWeight: FontWeight.bold,
                                      color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                              SizedBox(
                                width: _appConfig.rW(20),
                              ),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Per Day",
                                  style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                              // CustomBtn(
                              //   "Book Now",
                              //   _appConfig.rW(7),
                              //   AppConfig.hotelColor,
                              //   textColor: AppConfig.tripColor,
                              //   onPressed: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //       builder: (context) =>
                              //     //           HotelDetailAndBooking(
                              //     //             products: WebServices.hotelItems(),
                              //     //             item: this.widget.item,
                              //     //           )),
                              //     // );
                              //   },                    textSize: AppConfig.f5,
                              //
                              // ),

                              CustomBtn(
                                "Remove",
                                _appConfig.rW(7),
                                AppConfig.hotelColor,
                                textColor: AppConfig.tripColor,
                                onPressed: ()async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.remove('carId');
                                  prefs.setString('guideId',"${widget.item!.id}");
                                  WebServices.removeTouGuideWishlistItems().then((value) async {
                                    print("Guide removed");
// Profile(userName: _newController.text,);
// if (value == "name_change_success") {
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//         builder: (context) => Profile()),
//   );
// }
                                  });



                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WishList(category: widget.category,)),
                                  );
                                },
                                textSize: AppConfig.f5,
                              ),

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

}



class RemoveTripCard extends StatefulWidget {
  final TripListModel? item;
  final Future<List<TripListModel>>? products;
  final String? category;
  RemoveTripCard({Key? key, this.products, this.item, this.category}) : super(key: key);
  @override
  _RemoveTripCardState createState() => _RemoveTripCardState();
}

class _RemoveTripCardState extends State<RemoveTripCard> {
  late AppConfig _appConfig;

  @override
  // Widget build(BuildContext context) {
  //   _appConfig = AppConfig(context);
  //   // setState(() async {
  //   //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   prefs.setString('guideId','${widget.item!.id}');
  //   // });
  //   return Container(
  //     height: _appConfig.rH(22),
  //     margin: const EdgeInsets.all(20),
  //     padding: const EdgeInsets.only(right: 10),
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(30)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black12,
  //           offset: Offset(0, 5),
  //           blurRadius: 10,
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //               decoration: BoxDecoration(
  //                 color: AppConfig.tripColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     bottomLeft: Radius.circular(30)),
  //               ),
  //               child: ClipRRect(
  //                 borderRadius: const BorderRadius.only(
  //                     topLeft: Radius.circular(30),
  //                     bottomLeft: Radius.circular(30)),
  //                 child: Image.network(
  //                   "${AppConfig.srcLink}${widget.item!.image}",
  //                   height: _appConfig.rH(22),
  //                   width: _appConfig.rW(30),
  //                   fit: BoxFit.cover,
  //                 ),
  //               )),
  //         ),
  //
  //         Expanded(
  //           flex: 4,
  //           child: Container(
  //             margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
  //             child: Column(
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "${widget.item!.title}",
  //                               style: TextStyle(
  //                                   fontSize: AppConfig.f3,
  //                                   color: AppConfig.tripColor,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                             Row(
  //                               children: [
  //                                 Text("Age", style: TextStyle(color: AppConfig.textColor)),
  //                                 Text("30 Years",
  //                                     style: TextStyle(color: AppConfig.textColor))
  //                               ],
  //                             ),
  //                             Row(
  //                               children: [
  //                                 Text("Experience",
  //                                     style: TextStyle(color: AppConfig.textColor)),
  //                                 Text("30 Years",
  //                                     style: TextStyle(color: AppConfig.textColor))
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                         // InkWell(
  //                         //     child:  Icon(Icons.favorite,color: Colors.red.shade300,size: 35,),
  //                         //     onTap:  ()async{
  //                         //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //                         //       // prefs.remove('carId');
  //                         //       prefs.setString('guideId',"${widget.item!.id}");
  //                         //       WebServices.addTourGuideWishlistItems().then((value) async {
  //                         //         print("response: $value");
  //                         //         // Profile(userName: _newController.text,);
  //                         //         // if (value == "name_change_success") {
  //                         //         //   Navigator.of(context).pushReplacement(
  //                         //         //     MaterialPageRoute(
  //                         //         //         builder: (context) => Profile()),
  //                         //         //   );
  //                         //         // }
  //                         //       });
  //                         //
  //                         //     }
  //                         // ),
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.location_on_outlined,
  //                                   size: 20,
  //                                   color: AppConfig.textColor,
  //                                 ),
  //                                 Text("${widget.item!.address}",
  //                                     style: TextStyle(color: AppConfig.textColor))
  //                               ],
  //                             ),
  //                             RatingBarIndicator(
  //                               rating: double.parse("${widget.item!.rating}"),
  //                               itemBuilder: (context, index) => Icon(
  //                                 Icons.star,
  //                                 color: Colors.amber,
  //                               ),
  //                               itemCount: 5,
  //                               itemSize: 20.0,
  //
  //                               unratedColor: Colors.amber.withAlpha(60),
  //                               direction:  Axis.horizontal,
  //                             )
  //                           ],
  //                         ),
  //                         Column(
  //                           // crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text(
  //                                   "Rs ",
  //                                   style: TextStyle(color: AppConfig.tripColor),
  //                                 ),
  //                                 Text("${widget.item!.price}/-",
  //                                     style: TextStyle(
  //                                         fontSize: AppConfig.f4,
  //                                         fontWeight: FontWeight.bold,
  //                                         color: AppConfig.tripColor)),
  //                                 const SizedBox(
  //                                   width: 25,
  //                                 ),
  //
  //                               ],
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Text("Per Day",
  //                                     style: TextStyle(color: AppConfig.tripColor)),
  //                                 CustomBtn(
  //                                   "Remove",
  //                                   30,
  //                                   AppConfig.hotelColor,
  //                                   textColor: AppConfig.tripColor,
  //                                   onPressed: ()async{
  //                                     SharedPreferences prefs = await SharedPreferences.getInstance();
  //                                     // prefs.remove('carId');
  //                                     prefs.setString('guideId',"${widget.item!.wishlistId}");
  //                                     WebServices.removeTouGuideWishlistItems().then((value) async {
  //                                       print("response: $value");
  //                                       // Profile(userName: _newController.text,);
  //                                       // if (value == "name_change_success") {
  //                                       //   Navigator.of(context).pushReplacement(
  //                                       //     MaterialPageRoute(
  //                                       //         builder: (context) => Profile()),
  //                                       //   );
  //                                       // }
  //                                     });
  //
  //
  //
  //                                     Navigator.push(
  //                                       context,
  //                                       MaterialPageRoute(
  //                                           builder: (context) => WishList(hireACarW: WebServices.carWishlistItems(),
  //                                             hotelBooking: WebServices.hotelWishlistItems(),
  //                                             tourGuide: WebServices.tourGuideWishlistItems(),
  //                                             trip: WebServices.tripWishlistItems(),)),
  //                                     );
  //                                   },
  //                                 ),
  //
  //                               ],
  //                             )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                   ],
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    // setState(() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('guideId','${widget.item!.id}');
    // });
    return Container(
      // height: _appConfig.rH(25),
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
            flex: 2,
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
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.item!.title}",
                                    style: TextStyle(
                                        fontSize: AppConfig.f3,
                                        color: AppConfig.tripColor,
                                        fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),
                                  ),
                                  Row(
                                    children: [
                                      Text("Age", style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                      Text("30 Years",
                                        style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Experience",
                                        style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                      Text("30 Years",
                                        style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                    ],
                                  ),
                                ],
                              ),
                              // InkWell(
                              //     child:  Padding(
                              //       padding: const EdgeInsets.only(right: 10.0),
                              //       child: Icon(Icons.favorite_outline_sharp,color:Colors.redAccent,size: _appConfig.rH(4),),
                              //     ),
                              //     onTap:  ()async{
                              //
                              //       SharedPreferences prefs = await SharedPreferences.getInstance();
                              //       // prefs.remove('carId');
                              //       prefs.setString('guideId',"${widget.item!.id}");
                              //       WebServices.addTourGuideWishlistItems().then((value) async {
                              //         print("response: ${widget.item!.id}");
                              //         // Profile(userName: _newController.text,);
                              //         // if (value == "name_change_success") {
                              //         //   Navigator.of(context).pushReplacement(
                              //         //     MaterialPageRoute(
                              //         //         builder: (context) => Profile()),
                              //         //   );
                              //         // }
                              //       });
                              //
                              //     }
                              // ),
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
                                  Text("${widget.item!.address}",
                                    style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                ],
                              ),
                              RatingBarIndicator(
                                rating: double.parse("${widget.item!.rating}"),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: _appConfig.rW(5),

                                unratedColor: Colors.amber.withAlpha(60),
                                direction:  Axis.horizontal,
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
                                style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                              ),
                              Text("${widget.item!.price}/-",
                                style: TextStyle(
                                    fontSize: AppConfig.f4,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                              SizedBox(
                                width: _appConfig.rW(20),
                              ),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Per Day",
                                style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                              // CustomBtn(
                              //   "Book Now",
                              //   _appConfig.rW(7),
                              //   AppConfig.hotelColor,
                              //   textColor: AppConfig.tripColor,
                              //   onPressed: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //       builder: (context) =>
                              //     //           HotelDetailAndBooking(
                              //     //             products: WebServices.hotelItems(),
                              //     //             item: this.widget.item,
                              //     //           )),
                              //     // );
                              //   },                    textSize: AppConfig.f5,
                              //
                              // ),

                              CustomBtn(
                                "Remove",
                                _appConfig.rW(7),
                                AppConfig.hotelColor,
                                textColor: AppConfig.tripColor,
                                onPressed: ()async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.remove('carId');
                                  prefs.setString('guideId',"${widget.item!.id}");
                                  WebServices.removeTripWishlistItems().then((value) async {
                                    print("Guide removed");
// Profile(userName: _newController.text,);
// if (value == "name_change_success") {
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(
//         builder: (context) => Profile()),
//   );
// }
                                  });



                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WishList(category: widget.category,)),
                                  );
                                },
                                textSize: AppConfig.f5,
                              ),

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

}