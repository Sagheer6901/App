import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/popular_cities_model.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/home_page.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/popular_cities_card.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_card.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/services/services.dart';

class HotelPlace extends StatefulWidget {
  final PopularCitiesModel? item;

  HotelPlace({Key? key, this.item,}) : super(key: key);
  @override
  _HotelPlaceState createState() => _HotelPlaceState();
}

class _HotelPlaceState extends State<HotelPlace> {
  late AppConfig _appConfig;
  var limit=7;

  @override
  void initState() {
    super.initState();
    // fetchPopularCities();
    // fetchPopularHotels();
  }

  Future<List<PopularCitiesModel>>? fetchPopularCities(){
    return WebServices.getPopularCities();
  }
  fetchPopularHotels(){
    return WebServices.hotelItems();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);

    return Scaffold(
        appBar: preferredSizeAppbar("${widget.item!.slug}", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                (route) => false);
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                            decoration: const BoxDecoration(
                              // color: AppConfig.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              child: Image.network(
                                  "${AppConfig.srcLink}4.png",
                                height: _appConfig.rH(25),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                       SizedBox(
                        height: _appConfig.rH(1),
                      ),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${widget.item!.slug} Review",
                                      style: TextStyle(
                                          fontSize: AppConfig.f3,
                                          fontWeight: FontWeight.bold,
                                          color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyMedium),textScaleFactor: 1,
                                    ),
                                     SizedBox(
                                      width: _appConfig.rW(10),
                                    ),
                                    // SizedBox(
                                    //   height: 25,
                                    //   width: 95,
                                    //   child: ElevatedButton(
                                    //     onPressed: () {},
                                    //     style: ButtonStyle(
                                    //         backgroundColor:
                                    //             MaterialStateProperty.all<Color>(
                                    //           AppConfig.tripColor,
                                    //         ),
                                    //         shape: MaterialStateProperty.all<
                                    //                 RoundedRectangleBorder>(
                                    //             RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(18.0),
                                    //         ))),
                                    //     child: Row(
                                    //       children: const [
                                    //         Text(
                                    //           'Filter',
                                    //           style:
                                    //               TextStyle(color: Colors.white),
                                    //         ),
                                    //         SizedBox(
                                    //           width: 2,
                                    //         ),
                                    //         Image(
                                    //             image: AssetImage(
                                    //                 'assets/images/down-arrow.png'))
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: _appConfig.rW(5),
                                  itemPadding: const EdgeInsets.symmetric(),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                 SizedBox(
                                  height: _appConfig.rH(1),
                                ),
                                Text(
                                  'Lorem Ipsem Doller',
                                  style: TextStyle(
                                      fontSize: AppConfig.f3,
                                      fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyMedium),textScaleFactor: 1,
                                ),
                                SizedBox(
                                  height: _appConfig.rH(0.5),
                                ),
                                Container(
                                  width: _appConfig.rW(75),
                                  // height: _appConfig.rH(25),
                                  child: Text(
                                    '${widget.item!.description}',
                                    style: TextStyle(
                                        fontSize: AppConfig.f4,
                                        color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                SizedBox(
                  height: _appConfig.rH(1),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sawat Hotels',
                        style: TextStyle(
                          color: AppConfig.carColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConfig.f2,
                            fontFamily: AppConfig.fontFamilyMedium
                        ),textScaleFactor:1,
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          color: AppConfig.textColor,
                          fontSize: AppConfig.f5,
                            fontFamily: AppConfig.fontFamilyRegular
                        ),textScaleFactor: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _appConfig.rH(45),
                  child: FutureBuilder<List<HotelModel>>(
                    future: fetchPopularHotels(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? HotelListItems(items: snapshot.data,itemLimit: limit,)

                          // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
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
                SizedBox(
                  height: _appConfig.rH(1),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Swat Spots',
                        style: TextStyle(
                          color: AppConfig.carColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConfig.f3,
                            fontFamily: AppConfig.fontFamilyMedium
                        ),textScaleFactor: 1,
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          color: AppConfig.textColor,
                          fontSize: AppConfig.f5,
                            fontFamily: AppConfig.fontFamilyRegular
                        ),textScaleFactor: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  height: _appConfig.rH(32),
                  child: FutureBuilder<List<PopularCitiesModel>>(
                    future: fetchPopularCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? PopularCitiesListItems(items: snapshot.data)

                      // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  ),),
              ],
            ),
          ),
        ),
      drawer: const MyDrawer(),

    );
  }
}

class HotelListItems extends StatelessWidget {
  final List<HotelModel>? items;
  var itemLimit;

  HotelListItems({Key? key, this.items,this.itemLimit});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items!.length< itemLimit?  items!.length:itemLimit,
      itemBuilder: (context, index) {
        return HotelBookingCard(item: items![index]);
      },
    );
  }
}
