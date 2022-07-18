
import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/filter_attributes.dart';
import 'package:untitled/models/filter_category.dart';
import 'package:untitled/models/filter_terms.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_detail.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel.dart';
import 'package:untitled/services/services.dart';


List selectedHotelFilters = [];

class HotelFilters extends StatefulWidget {
  final Future<List<FilterAttributes>>? filterCategories;
  static List selectFilters = [];

  HotelFilters({
    Key? key, this.filterCategories,
  }) : super(key: key);

  @override
  _HotelFiltersState createState() => _HotelFiltersState();
}

class _HotelFiltersState extends State<HotelFilters> {
  late AppConfig _appConfig;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // selectedFilters.add("2");
      // selectedFilters.add("Prado TB");
      // selectedHotelFilters.add("Hilton Palace");
      // selectedHotelFilters.add("4");
      HotelFilters.selectFilters.add("Hilton Palace");
      print("hotels ${HotelFilters.selectFilters}");
      // selectedFilters.add("3");

      // selectedFilters.add("Ferrari");
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(15)), // Set this height
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: _appConfig.rWP(5), vertical: _appConfig.rHP(5)),
              decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HotelList()),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppConfig.whiteColor,
                      size: _appConfig.rH(3),
                    ),
                  ),
                  SizedBox(
                    height: _appConfig.rW(5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Filters",
                      style: TextStyle(
                          fontSize: AppConfig.f2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),
                      textScaleFactor: 1,
                    ),
                  ),
                  // Text("Reset")
                ],
              )),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HotelList()),
                  (route) => false);
          return Future.value(false);
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: _appConfig.rWP(5),
                      vertical: _appConfig.rHP(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 95,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              HotelFilters.selectFilters.clear();
                              selectedHotelFilters.clear();
                            });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => HotelList(                                     products: WebServices.hotelItems(),
                            //       )),
                            // );
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
                                'Reset',
                                style: TextStyle(color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                        width: 95,
                        child: ElevatedButton(
                          onPressed: () {
                            print("hotels in ${HotelFilters.selectFilters}");
                            selectedHotelFilters = HotelFilters.selectFilters;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HotelList( )),
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
                                'Apply',
                                style: TextStyle(color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )),

              SizedBox(
                height: _appConfig.rH(70),
                child: FutureBuilder<List<FilterAttributes>>(
                  future: widget.filterCategories,

                  builder: (context, snapshot) {
                    print("${snapshot.data}");

                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? Categories(items: snapshot.data, )

                    // return the ListView widget :
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}



class Categories extends StatefulWidget {
  final List<FilterAttributes>? items;

  var itemLimit;
  Categories({Key? key, this.items,this.itemLimit});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items!.length,
      itemBuilder: (context, index) {
        return FilterCard(item: widget.items![index], terms: WebServices.filterHotelTerms("${widget.items![index].id}"),);
      },
    );
  }
}





class FilterCard extends StatefulWidget {
  final FilterAttributes? item;
  final Future<List<FilterTerms>>? terms;

  const FilterCard({Key? key, this.item, this.terms}) : super(key: key);

  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Container(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${widget.item!.attributeName}",style: TextStyle(color:AppConfig.tripColor,fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyBold),),
        ),
        Container(
          height: 350,
          margin: EdgeInsets.symmetric(horizontal: _appConfig.rW(20)),
          child: FutureBuilder<List<FilterTerms>>(
            future: widget.terms,

            builder: (context, snapshot) {
              print("${snapshot.data}");

              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? FilterItem(items: snapshot.data, )

              // return the ListView widget :
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),

      ],
    ));
  }
}


class FilterItem extends StatefulWidget {
  final List<FilterTerms>? items;

  const FilterItem({Key? key, this.items}) : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: widget.items!.length,
      itemBuilder: (context, index) {
        return Row(children: [
          // Expanded(child: SizedBox(width: 5,)),
          Expanded(child: Container(
            // color: AppConfig.whiteColor,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor:
              selectedHotelFilters.contains("${widget.items![index].termName}")?MaterialStateProperty.all<Color>(AppConfig.carColor):MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ))),
              onPressed:(){
                setState(() {
                  HotelFilters.selectFilters.contains("${widget.items![index].termName}")?
                  HotelFilters.selectFilters.remove("${widget.items![index].termName}"):selectedHotelFilters.add("${widget.items![index].termName}") ;
                });
              },child: Text("${widget.items![index].termName}",style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyMedium),),),
          )),
          // Expanded(child: Text("${widget.items![index].termName}"))
        ],);
      },
    );
  }
}


// if (selectedFilters.isNotEmpty){
// ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// content: Text('Yay! A SnackBar!'),
// duration: Duration(
// days: 1,
// ),
// ));
// }
// else {
// ScaffoldMessenger.of(context).removeCurrentSnackBar();
// }