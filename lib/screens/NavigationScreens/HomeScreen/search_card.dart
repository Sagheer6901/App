import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/vehicle_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_list.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel.dart';
import 'package:untitled/services/services.dart';

class SearchCard extends StatefulWidget {
  String? type;
  SearchCard({Key? key, this.type}) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  List<TourGuideModel> allGuides = [];
  List<HotelModel> allHotel = [];
  List<CarModel> allCar = [];

  // filterGuides(search)async{
  //
  // }
  //
  String? _startDate, _endDate;
  // final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    // final DateTime today = DateTime.now();
    // final f = DateFormat('yyyy-MM-dd hh:mm');
    // _startDate = DateFormat('dd, MMMM yyyy').format(today).toString();
    // _endDate = DateFormat('dd, MMMM yyyy')
    //     .format(today.add(Duration(days: 3)))
    //     .toString();
    // _controller.selectedRange = PickerDateRange(today, today.add(Duration(days: 3)));
    super.initState();
  }

  // void selectionChanged( args) {
  //   setState(() {
  //     _startDate =
  //         DateFormat('dd, MMMM yyyy').format(args.value.startDate).toString();
  //     _endDate =
  //         DateFormat('dd, MMMM yyyy').format(args.value.endDate ?? args.value.startDate).toString();
  //   });
  // }
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String? _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _startDate = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
        // ignore: lines_longer_than_80_chars
        _endDate =
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  late AppConfig _appConfig;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: _appConfig.rH(24),
      // width: _appConfig.rW(90),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   height: 10,
          // ),
          SizedBox(
            height: _appConfig.rH(5),
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
          ),
          SizedBox(
            height: _appConfig.rH(1.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
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
                                    DateTime.now()
                                        .subtract(const Duration(days: 4)),
                                    DateTime.now()
                                        .add(const Duration(days: 3))),
                              ),
                            );
                          });
                    },
                    child: Column(
                      children: [
                        Text(
                          "From-To ",
                          style: TextStyle(
                              fontSize: AppConfig.f5,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1,
                        ),
                        _startDate == null
                            ? Text(
                                "Pick Date",
                                style: TextStyle(
                                    fontSize: AppConfig.f5,
                                    fontFamily: AppConfig.fontFamilyRegular),
                                textScaleFactor: 1,
                              )
                            : Row(
                                children: [
                                  Text(
                                    "$_startDate - ",
                                    style: TextStyle(
                                        fontSize: AppConfig.f5,
                                        fontFamily:
                                            AppConfig.fontFamilyRegular),
                                    textScaleFactor: 1,
                                  ),
                                  Text(
                                    "$_endDate",
                                    style: TextStyle(
                                        fontSize: AppConfig.f5,
                                        fontFamily:
                                            AppConfig.fontFamilyRegular),
                                    textScaleFactor: 1,
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: _appConfig.rW(5),
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 10,
                color: AppConfig.textColor,
                width: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: _appConfig.rW(5),
                  ),
                  Column(
                    children: [
                      Text(
                        "From-To",
                        style: TextStyle(
                            fontSize: AppConfig.f5,
                            fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      ),
                      Text(
                        "Round Trip",
                        style: TextStyle(
                            fontSize: AppConfig.f5,
                            fontFamily: AppConfig.fontFamilyRegular),
                        textScaleFactor: 1,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomBtn(
            "Search",
            _appConfig.rW(7),
            AppConfig.hotelColor,
            textColor: AppConfig.tripColor,
            textSize: AppConfig.f4,
            onPressed: () async {
              if (widget.type == "car") {
                await WebServices.searchCarItems(_searchController.text.trim())
                    .then((value) {
                  setState(() {
                    allCar = value;
                  });
                });
                print("$allCar");
                setState(() {
                  if (allCar.toString() != '[]'&&_searchController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VehicleList(
                                allCar: allCar,
                              )),
                    );
                  }
                  else if(_startDate==null){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Pick Date',
                            subtitle: 'Pick date please!',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                            primaryActionText: 'Okay',
                          );
                        });
                  }

                  else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Not Found',
                            subtitle: 'Item not found in our Cars!',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                            primaryActionText: 'Okay',
                          );
                        });
                  }
                });
              } else if (widget.type == "hotel") {
                await WebServices.searchHotelItems(_searchController.text.trim())
                    .then((value) {
                  setState(() {
                    allHotel = value;
                  });
                });
                print("$allHotel");
                setState(() {
                  if (allHotel.toString() != '[]'&&_searchController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HotelList(
                                allHotel: allHotel,
                              )),
                    );
                  }
                  else if(_startDate==null){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Pick Date',
                            subtitle: 'Pick date please!',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                            primaryActionText: 'Okay',
                          );
                        });
                  }

                  else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Not Found',
                            subtitle: 'Item not found in our Hotels!',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                            primaryActionText: 'Okay',
                          );
                        });
                  }
                });
              } else if (widget.type == "guide") {
                await WebServices.searchGuideItems(_searchController.text.trim())
                    .then((value) {
                  setState(() {
                    allGuides = value;
                  });
                });
                print("$allGuides");
                setState(() {
                  if (allGuides.toString() != '[]'&&_searchController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GuideList(
                                allGuide: allGuides,
                              )),
                    );
                  }
                  else if(_startDate==null){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Pick Date',
                            subtitle: 'Pick date please!',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                            primaryActionText: 'Okay',
                          );
                        });
                  }
                  else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: 'Not Found',
                            subtitle: 'Item not found in our Guides!',
                            primaryAction: () {
                              Navigator.pop(context);
                            },
                            primaryActionText: 'Okay',
                          );
                        });
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // contentBox(context) {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
  //         margin: EdgeInsets.only(top: 20),
  //         decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.grey, offset: Offset(0, 10), blurRadius: 10),
  //             ]),
  //         child: Card(
  //           // margin: const EdgeInsets.fromLTRB(50, 40, 50, 100),
  //           child: SfDateRangePicker(
  //             controller: _controller,
  //             selectionMode: DateRangePickerSelectionMode.range,
  //             onSelectionChanged: selectionChanged,
  //             allowViewNavigation: false,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

}

//
//
// class AddOnOptionAlertBox extends StatefulWidget {
//   @override
//   _AddOnOptionAlertBoxState createState() => _AddOnOptionAlertBoxState();
// }
//
// class _AddOnOptionAlertBoxState extends State<AddOnOptionAlertBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }
//
//   contentBox(context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
//           margin: EdgeInsets.only(top: 20),
//           decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey, offset: Offset(0, 10), blurRadius: 10),
//               ]),
//          child: Card(
//            margin: const EdgeInsets.fromLTRB(50, 40, 50, 100),
//            child: SfDateRangePicker(
//              controller: _controller,
//              selectionMode: DateRangePickerSelectionMode.range,
//              onSelectionChanged: selectionChanged,
//              allowViewNavigation: false,
//            ),
//          ),
//         ),
//       ],
//     );
//   }
// }
