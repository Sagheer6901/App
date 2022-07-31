import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_filters.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_booking_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_details.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_filters.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list.dart';
import 'package:untitled/services/services.dart';

class TripList extends StatefulWidget {
  // final Future<List<TourGuideModel>>? products;
  var limit = 7;
  List<TripListModel>? allTrip;

  TripList({
    Key? key,this.allTrip
  }) : super(key: key);
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  late AppConfig _appConfig;

  List<TripListModel> allTrips = [];
  List<TripListModel> filteredTrips = [];
  getTrips() {
    return WebServices.tripItems();
  }

  getFiltered() {
    WebServices.tripItems().then((value) {
      allTrips = value;
      filteredTrips = allTrips;
      var i;

      setState(() {
        for (i in selectedTripFilters) {
          filteredTrips = filteredTrips.where((element) {
            return selectedTripFilters.contains(element.title) ||
                selectedTripFilters.contains(element.rating);
          }).toList();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrips();
    getFiltered();
    // WebServices.carItems().then((value) {
    //   setState(() {
    //     allCars = value;
    //     fileteredCars = allCars;
    //     var i;
    //     for (i in selectedFilters){
    //       print("cars $i");
    //       fileteredCars =  fileteredCars.where((element) => (element.title!.toLowerCase().contains(i.toString().toLowerCase())) ).toList();
    //       // fileteredCars =  fileteredCars.where((element) => (element.title!.toLowerCase().contains(i)) ).toList();
    //
    //     }
    //     // for (i in selectedFilters){
    //     //   print("cars $i");
    //     //   fileteredCars =  fileteredCars.where((element) => (element.id!.toLowerCase().contains(i.toString().toLowerCase())) ).toList();
    //     //   // fileteredCars =  fileteredCars.where((element) => (element.title!.toLowerCase().contains(i)) ).toList();
    //     //
    //     // }
    //   });
    // });
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TripFilters.selectFilters.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    const snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
    );
    return Scaffold(
      appBar: preferredSizeAppbar("Trips", context),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
              (route) => false);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Container(
            height: _appConfig.rH(80),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(
                            horizontal: _appConfig.rWP(5),
                            vertical: _appConfig.rHP(2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Results",
                              style: TextStyle(
                                  fontSize: AppConfig.f2,
                                  fontWeight: FontWeight.bold,
                                  color: AppConfig.tripColor,
                                  fontFamily: AppConfig.fontFamilyMedium),
                            ),
                            SizedBox(
                              height: 25,
                              width: 95,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TripFilters(
                                              filterCategories: WebServices
                                                  .filterTripAtrributes(),
                                            )),
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AppConfig.tripColor,
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Center(
                                    child: Text(
                                      'Filter',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              AppConfig.fontFamilyMedium),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _appConfig.rH(2)),
                      child: Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: _appConfig.rH(2)),
                        child: CupertinoSearchTextField(
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppConfig.shadeColor,
                            size: _appConfig.rH(3),
                          ),
                          onChanged: (String) {
                            setState(() {
                              filteredTrips = allTrips
                                  .where((element) => (element.title!
                                      .toLowerCase()
                                      .contains(String.toLowerCase())))
                                  .toList();
                            });
                          },
                          backgroundColor: AppConfig.whiteColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    // height: 350,
                    child: FutureBuilder<List<TripListModel>>(
                      future: getTrips(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? TripItems(
                                items: widget.allTrip==null?filteredTrips:widget.allTrip,
                                itemLimit: widget.limit,
                              )

                            // return the ListView widget :
                            : Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: _appConfig.rH(0.5),
                ),
                CustomBtn("See more", 30, AppConfig.hotelColor,
                    textSize: AppConfig.f4,
                    textColor: AppConfig.tripColor, onPressed: () {
                  setState(() {
                    widget.limit = widget.limit + 7;
                  });
                }),
                SizedBox(
                  height: _appConfig.rH(1),
                ),
              ],
            ),
          ),
        ),
      ),

      drawer: const MyDrawer(),


    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Yay! A SnackBar!'),
      duration: Duration(
        days: 1,
      ),
    ));
  }

}

class TripItems extends StatefulWidget {
  List<TripListModel>? items;
  var itemLimit;
  TripItems({Key? key, this.items, this.itemLimit});

  @override
  State<TripItems> createState() => _TripItemsState();
}

class _TripItemsState extends State<TripItems> {
  late AppConfig _appConfig;
  final _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return SmartRefresher(
        // enablePullDown: true,
        // enablePullUp: true,
        controller: _refreshController,
        onLoading: () {
          log('Loading');
        },
        footer: null,
        onRefresh: () async {
          final temp = await WebServices.tripItems();
          setState(() {
            widget.items = temp;
          });
          // await Future.delayed(const Duration(milliseconds: 1000));
          // if failed,use refreshFailed()
          _refreshController.refreshCompleted();
        },
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.items!.length < widget.itemLimit
              ? widget.items!.length
              : widget.itemLimit,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: (){
                  Navigator
                      .push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripDetails(
                          products: WebServices.tripItems(),
                          reviews: WebServices.tripReviewItem("${widget.items![index].id}"),
                          item: this.widget.items![index],
                        )),
                  );
                },
                child: TripCard(item: widget.items![index]));
          },
        ));
  }
}
