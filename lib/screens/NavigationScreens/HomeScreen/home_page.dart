import 'dart:ui';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/notification_pop_menu.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/plans.dart';
import 'package:untitled/models/popular_cities_model.dart';

import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/google_auth.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/curve_item_cards.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/offers_card.dart';
import 'package:untitled/functions/nevigationbar.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/popular_cities_card.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/search_card.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/CarScreen/car_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_filters.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_filter.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/room_details_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/RecommendedServices/Cars/recommended_cars.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_card.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/TripScreen/trip_list.dart';
import 'package:untitled/services/services.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  // const MyHomePage({Key? key, required User user})
  //     : _user = user,
  //       super(key: key);

  // final User _user;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  int _currentIndex = 0;
  late AppConfig _appConfig;
  late TabController _tabController;

  UserProfile userProfile = UserProfile();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    fetchData();
    selectedCarFilters.clear();
    selectedHotelFilters.clear();
    selectedGuideFilters.clear();
    selectedTrips.clear();
    selectedTripIds.clear();
    priceCarList.clear();
    totalCarPrice= 0;
    priceHotelRoomsList.clear();
    totalHotelRoomsPrice=0;
  }

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    try {
      var url = Uri.parse(
          "${AppConfig.apiSrcLink}tApi.php?action=get_profile&user_email=$email");
      var response = await http.get(url);
      setState(() {
        print("Hello  ${response.body}");
        final jsonresponse = json.decode(response.body);
        userProfile = UserProfile.fromJson(jsonresponse[0]);
        print('Hello: ${userProfile.email}');
        loading = false;
      });
    } catch (error) {
      print(error);
      throw error;
    }
    prefs.setString("id", userProfile.id.toString());
    prefs.setString("name", userProfile.name.toString());
    prefs.setString("profileImage", userProfile.image.toString());
    prefs.setString("contact", userProfile.contact.toString());
  }

  Future<List<Plans>>? fetchPlans() {
    return WebServices.plansItems();
  }

  Future<List<PopularCitiesModel>>? fetchPopularCities() {
    return WebServices.getPopularCities();
  }

  final _inactiveColor = Colors.grey;
  final response = ResponseUI.instance;
  TextEditingController _searchController = TextEditingController();
  List<TripListModel> allTrip = [];

  @override
  Widget build(BuildContext context) {
    // print(Get.width.toString());
    // print(Get.height.toString());
    // print(context.width.toString());
    // print(context.height.toString());
    // print(MediaQuery.of(context).size.width.toString());
    // print(MediaQuery.of(context).size.height.toString());
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await fetchPlans();
          await fetchPopularCities();
          fetchData();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: const MyDrawer(),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(_appConfig.rH(50)), // Set this height
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      // FutureBuilder<List<PopularCitiesModel>>(
                      //   future: widget.popularCities,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasError) print(snapshot.error);
                      //     return snapshot.hasData
                      //         ? _tripTab(items: snapshot.data)
                      //
                      //     // return the ListView widget :
                      //         : Center(child: CircularProgressIndicator());
                      //   },
                      // )
                      _tripTab(userProfile.name, userProfile.email,
                          userProfile.image),
                      _categoryFilter(userProfile.name, userProfile.email,"car"),
                      _categoryFilter(userProfile.name, userProfile.email,"hotel"),
                      _categoryFilter(userProfile.name, userProfile.email,'guide'),
                    ],
                  ),
                ),
                SizedBox(
                  height: _appConfig.rH(2),
                ),
                Center(
                  child: Container(
                    height: _appConfig.rH(7),
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      // unselectedLabelColor: AppConfig.primaryColor,
                      // labelColor: Colors.white,
                      indicatorWeight: 4,
                      indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          color: Colors.white),
                      tabs: <Widget>[
                        Tab(
                          child: SizedBox(
                            height: _appConfig.rH(6),
                            width: _appConfig.rH(6),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/travel.png'),
                                    // scale: 1.8,
                                  ),
                                  color: AppConfig.tripColor,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            height: _appConfig.rH(6),
                            width: _appConfig.rH(6),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/car.png'),
                                  ),
                                  color: AppConfig.carColor,
                                  borderRadius: BorderRadius.circular(120)),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            height: _appConfig.rH(6),
                            width: _appConfig.rH(6),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/hotel.png',
                                    ),
                                    // scale: 0.7,
                                  ),
                                  color: AppConfig.hotelColor,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // SizedBox(width: 30,),
                //     Text(
                //       "Car",
                //       style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),
                //       textScaleFactor: 1,
                //     ),
                //     SizedBox(
                //       width: 50,
                //     ),
                //     Text(
                //       "Hotel",
                //       style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),
                //       textScaleFactor: 1,
                //     ),
                //     SizedBox(
                //       width: 50,
                //     ),
                //     Text(
                //       "Trip",
                //       style: TextStyle(fontFamily: AppConfig.fontFamilyMedium),
                //       textScaleFactor: 1,
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _appConfig.rH(2.5),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Offers',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConfig.f3,
                            fontFamily: AppConfig.fontFamilyMedium),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            color: AppConfig.textColor,
                            fontSize: AppConfig.f5,
                            fontFamily: AppConfig.fontFamilyRegular),
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(left:20 ),
                  height: _appConfig.rH(30),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: _appConfig.rW(80),
                        child: OfferCards(),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Cities',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConfig.f3,
                            fontFamily: AppConfig.fontFamilyMedium),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            color: AppConfig.textColor,
                            fontSize: AppConfig.f5,
                            fontFamily: AppConfig.fontFamilyRegular),
                      ),
                    ],
                  ).p8(),
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
                  ),
                ),
                // PopularPlaceCard(),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    height: _appConfig.rH(30),
                    child: FutureBuilder<List<Plans>>(
                      future: fetchPlans(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? PlansListItems(items: snapshot.data)

                            // return the ListView widget :
                            : Center(child: CircularProgressIndicator());
                      },
                    )),
                // child: ListView(
                //   scrollDirection: Axis.horizontal,
                //   children: [
                //
                //     CurveItemCard(
                //         "Room Booking",
                //         "2 double beds and fddf fsdf fdsfddfsdf ffdf",
                //         "545",
                //         AppConfig.tripColor),
                //     CurveItemCard(
                //         "Room Booking",
                //         "2 double beds and fddf fsdf fdsfddfsdf ffdf",
                //         "545",
                //         AppConfig.hotelColor),
                //     CurveItemCard(
                //         "Room Booking",
                //         "2 double beds and fddf fsdf fdsfddfsdf ffdf",
                //         "545",
                //         AppConfig.carColor),
                //   ],
                // ),

                SizedBox(
                  height: _appConfig.rH(1),
                )
                // SearResults()
              ],
            ),
          ),
          // bottomNavigationBar: _buildBottomBar(),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<TabController>('_tabController', _tabController));
    properties.add(DiagnosticsProperty<AppConfig>('_appConfig', _appConfig));
  }

  Widget _tripTab(name, email, image) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            // height: _appConfig.rH(40),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              image: DecorationImage(
                image: NetworkImage('${AppConfig.srcLink}t.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: _appConfig.rH(2),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _appConfig.rHP(2),
                    left: _appConfig.rHP(2.5),
                    right: _appConfig.rHP(2.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        name != null
                            ? FittedBox(
                                child: Text(
                                  "$name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConfig.f2,
                                      color: Colors.white,
                                      fontFamily: AppConfig.fontFamilyMedium),
                                  textScaleFactor: 1,
                                ),
                              )
                            : Text(
                                "--",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConfig.f2,
                                  color: Colors.white,
                                ),
                                textScaleFactor: 1,
                              ),
                        Text(
                          "${email}",
                          style: TextStyle(
                              fontSize: AppConfig.f5,
                              color: Colors.white,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        NotificationPopUp(),
                        PopUp()
                        // Builder(
                        //   builder: (context) => GestureDetector(
                        //     child: PopUpMenu(
                        //       menuList: [
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: Icon(
                        //               CupertinoIcons.person,
                        //             ),
                        //             title: Text('Profile'),
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) =>
                        //                          Profile()),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(Icons.message),
                        //             title: const Text('Blogs'),
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => MyBlogs(
                        //                           products: WebServices.blogItems(),
                        //                         )),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(Icons.car_rental),
                        //             title: const Text('Car'),
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => VehicleList(
                        //                           products: WebServices.carItems(),
                        //                         )),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(Icons.book),
                        //             title: const Text('Guide'),
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => GuideList(
                        //                         products: WebServices.tourGuideItems())),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(Icons.map),
                        //             title: const Text('Map'),
                        //             onTap: () {
                        //               Navigator.pushNamed(
                        //                   context, MyRoutes.map);
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(
                        //               CupertinoIcons.list_dash,
                        //             ),
                        //             title: const Text('Wish List'),
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => WishList(
                        //                           hireACar: WebServices.carWishlistItems(),
                        //                           hotelBooking: WebServices.hotelWishlistItems(),
                        //                       tourGuide: WebServices.tourGuideWishlistItems(),
                        //                       trip: WebServices.tripWishlistItems(),
                        //                         )),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(
                        //               Icons.payment,
                        //             ),
                        //             title: const Text('Payment History'),
                        //             onTap: () {
                        //               Navigator.pushNamed(
                        //                   context, MyRoutes.paymentHistory);
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: const Icon(
                        //               Icons.reviews,
                        //             ),
                        //             title: const Text('Reviews'),
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => HotelPage(
                        //                           products: WebServices.hotelItems(),
                        //                         )),
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //         PopupMenuItem(
                        //           child: ListTile(
                        //             leading: Icon(Icons.logout),
                        //             title: Text('Logout'),
                        //             onTap: () async {
                        //               SharedPreferences prefs = await SharedPreferences.getInstance();
                        //               prefs.remove('email');
                        //               setState(() {
                        //                 _isSigningOut = true;
                        //               });
                        //               await Authentication.signOut(
                        //                   context: context);
                        //               setState(() {
                        //                 _isSigningOut = false;
                        //               });
                        //               Navigator.of(context).pushReplacement(
                        //                   _routeToSignInScreen());
                        //             },
                        //             // onTap: () async {
                        //             //   await FacebookAuth.i.logOut();
                        //             //
                        //             //   setState(() {
                        //             //     _appConfig.userData = null;
                        //             //   });
                        //             // },
                        //           ),
                        //         ),
                        //       ],
                        //       icon: const CircleAvatar(
                        //         backgroundImage: AssetImage(
                        //           'assets/images/user.png',
                        //         ),
                        //         maxRadius: 22,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _appConfig.rH(1),
              ),
              SizedBox(
                height: _appConfig.rH(5),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: _appConfig.rHP(2.5)),
                  padding: EdgeInsets.symmetric(
                    horizontal: _appConfig.rHP(2.5),
                  ),
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
                      IconButton(onPressed: () async {
                        await WebServices.tripSearchItems(_searchController.text)
                            .then((value) {
                          setState(() {
                            allTrip = value;
                          });
                        });
                        print("$allTrip");
                        setState(() {
                          if (allTrip.toString() != '[]'&&_searchController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TripList(
                                    allTrip: allTrip,
                                  )),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: 'Not Found',
                                    subtitle: 'Item not found in our Trips!',
                                    primaryAction: () {
                                      Navigator.pop(context);
                                    },
                                    primaryActionText: 'Okay',
                                  );
                                });
                          }
                        });
                      },icon: Icon(Icons.search))
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: _appConfig.rH(5),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: _appConfig.rHP(2.5),
              //     ),
              //     child: CupertinoSearchTextField(
              //       prefixIcon: Center(
              //         child: Padding(
              //           padding: const EdgeInsets.all(5.0),
              //           child: Icon(
              //             Icons.search,
              //             color: AppConfig.shadeColor,
              //             size: _appConfig.rH(3),
              //           ),
              //         ),
              //       ),
              //       onChanged: (value) {},
              //       backgroundColor: Colors.white,
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: _appConfig.rH(1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _appConfig.rHP(2.5)),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Make Travel\nEasy\n',
                      style: TextStyle(
                          fontSize: AppConfig.f1,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppConfig.fontFamilyMedium),
                      children: [
                        TextSpan(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam congue fermentum mi ac pretium. ',
                          style: TextStyle(
                              fontSize: AppConfig.f5,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppConfig.fontFamilyRegular),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _appConfig.rW(2),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: _appConfig.rHP(2.5)),
                    // width: _appConfig.rW(40),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppConfig.hotelColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Text(
                          "View more",
                          style: TextStyle(
                              color: AppConfig.tripColor,
                              fontSize: AppConfig.f4,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppConfig.fontFamilyRegular),
                          textScaleFactor: 1,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryFilter(name, email, type) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: _appConfig.rH(15),
            padding: EdgeInsets.only(
                top: _appConfig.rHP(2),
                left: _appConfig.rHP(2.5),
                right: _appConfig.rHP(2.5)),
            decoration: BoxDecoration(
                color: AppConfig.tripColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConfig.f2,
                          color: AppConfig.whiteColor,
                          fontFamily: AppConfig.fontFamilyMedium),
                      textScaleFactor: 1,
                    ),
                    Text(
                      "$email",
                      style: TextStyle(
                          fontSize: AppConfig.f5,
                          color: AppConfig.whiteColor,
                          fontFamily: AppConfig.fontFamilyRegular),
                      textScaleFactor: 1,
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [NotificationPopUp(), PopUp()],
                )
              ],
            ),
          ),
          Positioned(
              top: _appConfig.rH(10), left: 20, right: 20, child: SearchCard(type: type,))
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.apps),
          title: const Text('Home'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.people),
          title: const Text('Users'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.message),
          title: const Text(
            'Messages ',
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class PlansListItems extends StatelessWidget {
  final List<Plans>? items;
  PlansListItems({Key? key, this.items});
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: items!.length,
      itemBuilder: (context, index) {
        return CurveItemCard(item: items![index]);
      },
    );
  }
}

class PopularCitiesListItems extends StatelessWidget {
  final List<PopularCitiesModel>? items;

  PopularCitiesListItems({Key? key, this.items});
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return ListView.builder(
      // shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: items!.length,
      itemBuilder: (context, index) {
        return PopularPlaceCard(item: items![index]);
      },
    );
  }
}

class SearResults extends StatefulWidget {
  const SearResults({Key? key}) : super(key: key);

  @override
  _SearResultsState createState() => _SearResultsState();
}

class _SearResultsState extends State<SearResults> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            thickness: 5,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 35,
              ),
              Text(
                'Results',
                style: TextStyle(
                  color: AppConfig.tripColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 220,
              ),
              Text(
                'See all',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SearchItemCards()
        ],
      ),
    );
  }
}

class SearchItemCards extends StatelessWidget {
  const SearchItemCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 150,
          child: Expanded(
            flex: 3,
            child: Stack(
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
                      child: Image.asset(
                        "assets/images/swat.jpg",
                        // height: 120,
                        // width: 60,
                        fit: BoxFit.cover,
                      ),
                    )),
                const Positioned(
                    right: 60, top: 20, child: const Icon(Icons.favorite))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: Expanded(
            flex: 1,
            child: Stack(
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
                      child: Image.asset(
                        "assets/images/swat.jpg",
                        // height: 120,
                        // width: 60,
                        fit: BoxFit.cover,
                      ),
                    )),
                const Positioned(
                    right: 20, top: 20, child: const Icon(Icons.favorite))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
