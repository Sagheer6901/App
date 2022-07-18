import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_filters.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list.dart';
import 'package:untitled/services/services.dart';

class GuideList extends StatefulWidget {
  List<TourGuideModel>? allGuide;
  var limit=7;
  GuideList({Key? key,this.allGuide}) : super(key: key);
  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  late AppConfig _appConfig;

  Future<List<TourGuideModel>> getTourGuideItems() {
    return WebServices.tourGuideItems();
  }

  List<TourGuideModel> allGuides = [];
  List<TourGuideModel> fileteredGuides = [];

  filterGuides(){
    WebServices.tourGuideItems().then((value) {
      allGuides = value;
      fileteredGuides = allGuides;
      var i;

      setState(() { for (i in selectedGuideFilters) {
        fileteredGuides =  fileteredGuides.where((element) {
          return selectedGuideFilters.contains(element.title) || selectedGuideFilters.contains(element.rating);
        }).toList();
      }});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterGuides();
    getTourGuideItems();
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
    GuideFilters.selectFilters.clear();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _appConfig = AppConfig(context);
    _appConfig.statusBar();

    return Scaffold(
        appBar: preferredSizeAppbar("Guides", context),
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
                                          builder: (context) => GuideFilters(filterCategories: WebServices.filterGuideAtrributes(),)),
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
                                fileteredGuides =  allGuides.where((element) => (element.title!.toLowerCase().contains(String.toLowerCase()))).toList();
                              });
                            },              backgroundColor: AppConfig.whiteColor,
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
                      child: FutureBuilder<List<TourGuideModel>>(
                        future:     getTourGuideItems(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? TourGuideItems(items: widget.allGuide==null?fileteredGuides:widget.allGuide,itemLimit:widget.limit,)

                              // return the ListView widget :
                              : Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _appConfig.rH(0.5),
                  ),
                  CustomBtn("See more", 30, AppConfig.hotelColor,textSize: AppConfig.f4,textColor: AppConfig.tripColor,onPressed: (){
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


class TourGuideItems extends StatefulWidget {
  List<TourGuideModel>? items;
  var itemLimit;
  TourGuideItems({Key? key, this.items,this.itemLimit});

  @override
  State<TourGuideItems> createState() => _TourGuideItemsState();
}

class _TourGuideItemsState extends State<TourGuideItems> {
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
        final temp = await WebServices.tourGuideItems();
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
          return GuideCard(item: widget.items![index]);
        },
      ),
    );
  }
}
