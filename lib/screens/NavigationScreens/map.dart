import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/popular_cities_card.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
      _appConfig = AppConfig(context);
      _appConfig.statusBar();

    return Scaffold(
        appBar: preferredSizeAppbar("Map", context),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tour Map",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConfig.tripColor),
              ),
              const SizedBox(
                width: 60,
              ),
              SizedBox(
                height: 25,
                width: 95,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppConfig.tripColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: Row(
                    children: const [
                      Text(
                        'Filter',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Image(image: AssetImage('assets/images/down-arrow.png'))
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomBtn("Search your Destination", 60, AppConfig.carColor),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 500,
            width: double.infinity,
            child: Locations(),
          ),
        ])),
      drawer: const MyDrawer(),

    );
  }
}

class Locations extends StatefulWidget {
  @override
  State<Locations> createState() => MapSampleState();
}

class MapSampleState extends State<Locations> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.79170162386614, 72.35990175528423),
    zoom: 8,
  );

  PopularPlaceCard _popularPlaceCard =PopularPlaceCard();
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(34.79170162386614, 72.35990175528423)),
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(35.91965032456741, 74.35427966814574)),
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(33.66146800303216, 73.0565999625137)),
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(34.148498575536436, 74.83457405896493)),
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(31.51646492101506, 74.32768179588643)),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.42796133580664, -120.085749655962),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
