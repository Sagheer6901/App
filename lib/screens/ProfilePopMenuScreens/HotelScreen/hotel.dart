import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/car_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_filter.dart';
import 'package:untitled/services/services.dart';

import 'room_details_card.dart';

class HotelList extends StatefulWidget {
  // final Future<List<HotelModel>>? products;
  var limit=7;
  List<HotelModel>? allHotel;
  HotelList({Key? key,this.allHotel}) : super(key: key);
  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  late AppConfig _appConfig;
  List<HotelModel> allHotels = [];
  List<HotelModel> fileteredHotels = [];

  getHotels(){
    return WebServices.hotelItems();
  }
  filterHotels(){
    WebServices.hotelItems().then((value) {
      allHotels = value;
      fileteredHotels = allHotels;
      var i;


      setState(() { for (i in selectedHotelFilters) {
        fileteredHotels =  fileteredHotels.where((element) {
          return selectedHotelFilters.contains(element.title) || selectedHotelFilters.contains(element.rating);
        }).toList();
      }});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterHotels();
    getHotels();
    priceHotelRoomsList.clear();
    totalHotelRoomsPrice=0;
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
    HotelFilters.selectFilters.clear();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
        appBar: preferredSizeAppbar("Hotels", context),
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
                                    color: AppConfig.carColor,fontFamily: AppConfig.fontFamilyMedium),
                              ),
                              SizedBox(
                                height: 25,
                                width: 95,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HotelFilters(filterCategories: WebServices.filterHotelAtrributes(),)),
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
                                            borderRadius:
                                            BorderRadius.circular(18.0),
                                          ))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Center(
                                      child: Text(
                                        'Filter',
                                        style: TextStyle(color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Padding(          padding: EdgeInsets.symmetric(horizontal: _appConfig.rH(2)),
                        child: Container(
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
                          padding: EdgeInsets.symmetric(horizontal: _appConfig.rH(2)),
                          child: CupertinoSearchTextField(
                            prefixIcon:  Icon(
                              Icons.search,
                              color: AppConfig.shadeColor,
                              size: _appConfig.rH(3),
                            ),
                            onChanged: (String){
                              setState(() {
                                fileteredHotels =  allHotels.where((element) => (element.title!.toLowerCase().contains(String.toLowerCase())) ).toList();
                              });
                            },              backgroundColor: AppConfig.whiteColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: _appConfig.rH(0.5),
                      // )
                    ],
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      // height: _appConfig.rH(65),
                      child: FutureBuilder<List<HotelModel>>(
                        future: getHotels(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? HotelListItems(items: widget.allHotel==null?fileteredHotels:widget.allHotel, itemLimit: widget.limit)

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
                      }),                  SizedBox(
                    height: _appConfig.rH(1),
                  ),
                ],
              ),
            ),
          ),
        ),
      drawer: const MyDrawer(),
    );
  }
}



class HotelListItems extends StatefulWidget {
  List<HotelModel>? items;
  var itemLimit;
  HotelListItems({Key? key, this.items,this.itemLimit});

  @override
  State<HotelListItems> createState() => _HotelListItemsState();
}

class _HotelListItemsState extends State<HotelListItems> {
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
    final temp = await WebServices.hotelItems();
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
    // itemCount: widget.items!.length< widget.itemLimit?  widget.items!.length:widget.itemLimit,
    itemBuilder: (context, index) {
        return HotelBookingCard(item: widget.items![index]);
      },
    ));
  }
}
