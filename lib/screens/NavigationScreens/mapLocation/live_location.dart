import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/NavigationScreens/mapLocation/location_service.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MapLocation extends StatefulWidget {
  @override
  State<MapLocation> createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _searchOriginController = TextEditingController();
  TextEditingController _searchDestinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();

  List<LatLng> polygonLatlng = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  Timer? timer;
  var uuid =Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList =[];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchOriginController.addListener(() { onChange(_searchOriginController.text);});
    _searchDestinationController.addListener(() { onChange(_searchDestinationController.text);});
    _setMarker(LatLng(37.42796133580664, -122.085749655962));
  }

  void onChange(controllerText){
    if(_sessionToken==null){
      setState(() {
        _sessionToken =uuid.v4();
      });
    }
    getSuggestion(controllerText);
  }

  Future<void> getSuggestion(input) async {
    final String key = "AIzaSyCl23apLBSkhrTjrY-mg1JprhmtmClrZm0";

    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = "$url?input=$input&key=$key&sessiontoken=$_sessionToken";

    var response= await http.get(Uri.parse(request));
    print(response);
    if(response.statusCode==200){
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    }
    else{
      throw Exception("failed to load");
    }
  }

  void _setMarker(LatLng point){
    setState(() {
      _markers.add(
          Marker(markerId: MarkerId('marker'),position: point,)
      );
    });
  }

  void _setPolygon(){
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add(
        Polygon(polygonId: PolygonId(polygonIdVal), points: polygonLatlng,strokeWidth: 2,fillColor: Colors.transparent)
    );
  }

  void _setPolyline(List<PointLatLng> points){
    print("points $points");
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;
    _polylines.add(
        Polyline(polylineId: PolylineId(polylineIdVal),width: 2,color: Colors.blueAccent,
          points: points.map(
                  (point)=> LatLng(point.latitude, point.longitude)
          ).toList(),
        )
    );
  }


  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  //
  // static final Marker _kGooglePlexMarker = Marker(markerId: MarkerId("_kGooglePlex"),infoWindow: InfoWindow(title: "Google Plex"), icon: BitmapDescriptor.defaultMarker,position:  LatLng(37.42,-122.08));
  // static final Marker _kLakeMarker = Marker(markerId: MarkerId("_lLakeMarker"),infoWindow: InfoWindow(title: "Lake"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),position: LatLng(37.42796133580664, -122.085749655962),);
  //
  // static final Polyline _kPolyline = Polyline(polylineId: PolylineId("_kPolyline"), points: [
  //   LatLng(37.42796133580664, -122.085749655962),    LatLng(37.42,-122.08),
  // ],
  // width: 5
  // );
  // static final Polygon _kPolygon = Polygon(polygonId: PolygonId('_kPolygon'), points: [
  //   LatLng(37.42796133580664, -122.085749655962),    LatLng(37.42,-122.08),
  //   LatLng(37.38796133580664, -122.085749655962),    LatLng(37.35,-122.08),
  // ],
  // strokeWidth: 5
  // );

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace){
      print("error"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  //
  GetAddressFromLatLong(lat, lng)async {


    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    print(placemarks);
    Placemark place = placemarks[0];
    var address = '${place.name},${place.street}, ${place.subLocality}, ${place.locality},  ${place.country}';
    return address;
  }

  liveLocation() async {
    var position = getUserCurrentLocation();
    getUserCurrentLocation().then((value) async {
      print("my location");

      _markers.clear();
      var userAddress = await GetAddressFromLatLong(value.latitude,value.longitude);

      _setMarker(LatLng(value.latitude,value.longitude));
      _searchOriginController.text = "${userAddress}";
      userCurrentLocation['lat']= value.altitude.toDouble();
      userCurrentLocation['lng']= value.longitude.toDouble();
      print(userCurrentLocation);

      _polylines.clear();
      var directions = await LocationService().getDirections(_searchOriginController.text, _searchDestinationController.text);
      print("directions:"+directions.toString());
      // _goToPlace(userCurrentLocation.isNotEmpty?directions['start_location']['lat']:userCurrentLocation['lat'], userCurrentLocation.isNotEmpty?directions['start_location']['lng']:userCurrentLocation['lat'],directions['bounds_ne'],directions['bounds_sw']);
      _goToPlace(directions['start_location']['lat'],directions['start_location']['lng'],directions['bounds_ne'],directions['bounds_sw']);

      _setPolyline(directions['polyline_decoded']);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 30)));
      userLocation = userAddress;

      // setState(() async {
      //
      // });
      print(value.altitude.toString()+" "+value.longitude.toString());
    });

  }

  cancel(){
    timer?.cancel();

    setState(() {
      userLocation=null;
      getUserLocation=null;
    });
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  var userCurrentLocation = {};
   var userLocation;
   var getUserLocation;

   bool c=true;
   bool a=true;
   bool b=true;
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppConfig.tripColor
          //color set to transperent or set your own color
        )
    );
    return Scaffold(
      appBar: preferredSizeAppbar("Map", context),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Visibility(
                            visible: a,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: _searchOriginController,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(hintText: "Search From",filled: true,fillColor: AppConfig.shadeColor,border: InputBorder.none),
                                  onChanged: (value){
                                    print(value);
                                    // c = false;
                                    // b=false;
                                  },
                                ),
                         // c==false? Container(
                         //     constraints: BoxConstraints(
                         //       minHeight: _appConfig.rH(20),
                         //       maxHeight: _appConfig.rH(25),
                         //     ),
                         //      alignment: Alignment.center,
                         //      child: ListView.builder(
                         //          itemCount: _placesList.length,
                         //          itemBuilder: (context, index) {
                         //            return InkWell(onTap:(){
                         //              _searchOriginController.text = _placesList[index]['description'];
                         //              c= true;
                         //              b=true;
                         //
                         //            },child: ListTile(title: Text(_placesList[index]['description']),));
                         //          }),
                         //    ):SizedBox()

                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Visibility(
                            visible: b,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _searchDestinationController,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(hintText: "Search To",filled: true,fillColor: AppConfig.shadeColor,border: InputBorder.none),
                                  onChanged: (value){
                                    print(value);
                                    c = false;
                                    a = false;
                                  },
                                ),
                                c==false? Container(
                                  constraints: BoxConstraints(
                                    minHeight: _appConfig.rH(20),
                                    maxHeight: _appConfig.rH(25),
                                  ),
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                      itemCount: _placesList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(onTap:() async {
                                          _searchDestinationController.text = _placesList[index]['description'];
                                          c= true;
                                          a=true;

                                          _polylines.clear();
                                          var directions = await LocationService().getDirections(_searchOriginController.text, _searchDestinationController.text);
                                          print("directions:"+directions.toString());
                                          // _goToPlace(userCurrentLocation.isNotEmpty?directions['start_location']['lat']:userCurrentLocation['lat'], userCurrentLocation.isNotEmpty?directions['start_location']['lng']:userCurrentLocation['lat'],directions['bounds_ne'],directions['bounds_sw']);

                                          _setPolyline(directions['polyline_decoded']);

                                          setState(() {
                                            _goToPlace(directions['start_location']['lat'],directions['start_location']['lng'],directions['bounds_ne'],directions['bounds_sw']);
                                          });
                                        },child: ListTile(title: Text(_placesList[index]['description']),));
                                      }),
                                ):SizedBox()

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
    userLocation==null?Visibility(
      visible: c,
      child: IconButton(onPressed: ()async{


                        // var place = await LocationService().getPlace(_searchController.text);
                        // _goToPlace(place);
        print(" my location: ${_searchDestinationController.text}  ${_searchOriginController.text}");
                      }, icon: Icon(Icons.search)),
    ):SizedBox()
                  ],
                ),
              ),
              Visibility(
                visible: c,
                child: Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        markers: _markers,
                        // polygons: _polygons,
                        polylines: _polylines,
                        // markers: {_kGooglePlexMarker,
                        //   // _kLakeMarker
                        // },
                        // polylines: {_kPolyline},
                        // polygons: {_kPolygon},
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onTap: (point){
                          setState(() {
                            polygonLatlng.add(point);
                            _setPolygon();
                          });
                        },
                      ),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: ElevatedButton(
                            onPressed: (){
                              userCurrentLocation.clear();
                              getUserCurrentLocation().then((value){
                                print("my location");
                                setState(() async {

                                  _markers.clear();
                                  final GoogleMapController controller = await _controller.future;
                                  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 16)));
                                  _setMarker(LatLng(value.latitude,value.longitude));
                                  var userAddress = await GetAddressFromLatLong(value.latitude,value.longitude);
                                  print("address: $userAddress");
                                  _searchOriginController.text = "${userAddress}";
                                  userCurrentLocation['lat']= value.altitude.toDouble();
                                  userCurrentLocation['lng']= value.longitude.toDouble();
                                  print(userCurrentLocation);
                                  getUserLocation = userAddress;
                                });
                                print(value.altitude.toString()+" "+value.longitude.toString());
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.gps_fixed_sharp),
                                SizedBox(width: 5,),
                                Text("Get Location"),
                              ],
                            ),
                          ))

                    ],
                  ),
                ),
              ),

            ],
          ),
          getUserLocation!=null?Positioned(
              bottom: 20,
              left: 15,
              child: ElevatedButton(onPressed: () async {

            userLocation==null?timer = Timer.periodic(Duration(seconds: 15), (Timer t) => liveLocation()):cancel();

            // liveLocation();

          },
            child: userLocation==null?Text("Get Directions"):Text("Cancel"),)):SizedBox(),
        ],
      ),

    );
  }

  Future<void> _goToPlace(lat, lng, boundsNe, boundsSw) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];


    final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,lng),zoom: 12)));

    controller.animateCamera(CameraUpdate.newLatLngBounds(

        LatLngBounds(
          southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
          northeast: LatLng(boundsNe['lat'],boundsNe['lng']),
        ),25

    ));

    _setMarker(LatLng(lat, lng));
  }

}