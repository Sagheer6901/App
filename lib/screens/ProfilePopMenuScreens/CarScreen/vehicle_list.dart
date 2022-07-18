import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/car_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_card.dart';
import 'package:untitled/services/services.dart';

class VehicleList extends StatefulWidget {
  List<CarModel>? allCar;

  var limit = 7;
  VehicleList({Key? key,this.allCar}) : super(key: key);
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  late AppConfig _appConfig;

  Future<List<CarModel>> getCars() {
    return WebServices.carItems();
  }

  List<CarModel> allCars = [];
  List<CarModel> fileteredCars = [];

  filterCars() {
    WebServices.carItems().then((value) {
      allCars = value;
      fileteredCars = allCars;
      var i;

      setState(() {
        for (i in selectedCarFilters) {
          fileteredCars = fileteredCars.where((element) {
            return selectedCarFilters.contains(element.title) ||
                selectedCarFilters.contains(element.brand);
          }).toList();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    filterCars();
    getCars();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    CarFilters.selectFilters.clear();
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return Scaffold(
      appBar: preferredSizeAppbar("Cars", context),
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
                                        builder: (context) => CarFilters(
                                              filterCategories: WebServices
                                                  .filterCarAtrributes(),
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
                                child:  Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: Text(
                                      'Filter',
                                      style:
                                           TextStyle(color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            const BoxShadow(
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
                              fileteredCars = allCars
                                  .where((element) => (element.title!
                                      .toLowerCase()
                                      .contains(String.toLowerCase())))
                                  .toList();
                              // fileteredCars =  allCars.where((element) => (element.id!.toLowerCase().contains(String.toLowerCase()))).toList();
                            });
                          },
                          backgroundColor: AppConfig.whiteColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _appConfig.rH(1),
                    )
                  ],
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    // height: _appConfig.rH(65),
                    child: FutureBuilder<List<CarModel>>(
                      future: getCars(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          log(snapshot.error.toString());
                        }
                        return snapshot.hasData
                            ? CarListItems(
                                items: widget.allCar==null?fileteredCars:widget.allCar,
                                itemLimit: widget.limit,
                              )

                            // return the ListView widget :
                            : const Center(
                                child: const CircularProgressIndicator());
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
  }
}

class CarListItems extends StatefulWidget {
  List<CarModel>? items;
  final int itemLimit;
  CarListItems({
    Key? key,
    this.items,
    required this.itemLimit,
  }) : super(key: key);

  @override
  State<CarListItems> createState() => _CarListItemsState();
}

class _CarListItemsState extends State<CarListItems> {
  late AppConfig _appConfig;

  final _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return SmartRefresher(
      // enablePullDown: true,
      // enablePullUp: true,
      controller: _refreshController,
      onLoading: () {
        log('Loading');
      },
      footer: null,
      onRefresh: () async {
        final temp = await WebServices.carItems();
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
          return BookVehicleCard(item: widget.items![index]);
        },
      ),
    );
  }
}
