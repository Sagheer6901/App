// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/functions/app_config.dart';
// import 'package:untitled/screens/NavigationScreens/HomeScreen/offers_card.dart';
// import 'package:untitled/functions/nevigationbar.dart';
// import 'package:untitled/screens/NavigationScreens/HomeScreen/popular_cities_card.dart';
// import 'package:untitled/functions/popupmenu.dart';
// import 'package:untitled/routes.dart';
// import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
// import 'package:untitled/functions/drawer.dart';
// import 'package:untitled/screens/ProfilePopMenuScreens/WishListScreen/wish_list1.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   late AppConfig _appConfig;
//   List listOfColors = [HomePage(), Map(), MyBlogs(), WishList()];
//   final _inactiveColor = Colors.grey;
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     _appConfig = AppConfig(context);
//     return SafeArea(
//       child: Stack(
//         children: [
//           Scaffold(
//             backgroundColor: Colors.white,
//             drawer: const MyDrawer(),
//             appBar: PreferredSize(
//               preferredSize:
//                   Size.fromHeight(_appConfig.rH(10)), // Set this height
//               child: SafeArea(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: _appConfig.rWP(5),
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppConfig.tripColor,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Hyder Ali",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: AppConfig.f2,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Text(
//                             "Lorem ipsum dolor sit amet",
//                             style: TextStyle(
//                               fontSize: AppConfig.f5,
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.notifications_outlined,
//                                 size: 30,
//                                 color: Colors.white,
//                               )),
//                           Builder(
//                             builder: (context) => GestureDetector(
//                               child: PopUpMenu(
//                                 menuList: [
//                                   const PopupMenuItem(
//                                     child: ListTile(
//                                       leading: Icon(
//                                         CupertinoIcons.person,
//                                       ),
//                                       title: Text('Profile'),
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     child: ListTile(
//                                       leading: const Icon(Icons.message),
//                                       title: const Text('Blogs'),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, MyRoutes.blogRoute);
//                                       },
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     child: ListTile(
//                                       leading: const Icon(Icons.car_rental),
//                                       title: const Text('Car'),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, MyRoutes.car);
//                                       },
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     child: ListTile(
//                                       leading: const Icon(Icons.book),
//                                       title: const Text('Guide'),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, MyRoutes.guide);
//                                       },
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     child: ListTile(
//                                       leading: const Icon(Icons.map),
//                                       title: const Text('Map'),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, MyRoutes.map);
//                                       },
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     child: ListTile(
//                                       leading: const Icon(
//                                         CupertinoIcons.list_dash,
//                                       ),
//                                       title: const Text('Wish List'),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, MyRoutes.wishRoute);
//                                       },
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     child: ListTile(
//                                       leading: const Icon(
//                                         Icons.reviews,
//                                       ),
//                                       title: const Text('Reviews'),
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                             context, MyRoutes.hotelRoute);
//                                       },
//                                     ),
//                                   ),
//                                   const PopupMenuItem(
//                                     child: ListTile(
//                                       leading: Icon(Icons.logout),
//                                       title: Text('Logout'),
//                                     ),
//                                   ),
//                                 ],
//                                 icon: const CircleAvatar(
//                                   backgroundImage: AssetImage(
//                                     'assets/images/user.png',
//                                   ),
//                                   maxRadius: 22,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             body: ListView(
//               scrollDirection: Axis.vertical,
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       alignment: Alignment.topCenter,
//                       height: size.height / 1.8,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(50.0),
//                             bottomRight: Radius.circular(50.0)),
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/Untitled-18.png'),
//                           fit: BoxFit.fitHeight,
//                         ),
//                       ),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           height: 50,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0,
//                             ),
//                             child: CupertinoSearchTextField(
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 color: Colors.black,
//                                 size: 25,
//                               ),
//                               onChanged: (value) {},
//                               backgroundColor: Colors.white,
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 160,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Container(
//                             alignment: Alignment.centerLeft,
//                             child: RichText(
//                               text: const TextSpan(
//                                 text: 'Make Travel\nEasy\n',
//                                 style: TextStyle(
//                                     fontSize: 30, fontWeight: FontWeight.bold),
//                                 children: [
//                                   TextSpan(
//                                     text:
//                                         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam congue fermentum mi ac pretium. ',
//                                     style: TextStyle(fontSize: 10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             SizedBox(
//                               width: 150,
//                               child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all<Color>(
//                                               Colors.yellow),
//                                       shape: MaterialStateProperty.all<
//                                               RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(18.0),
//                                       ))),
//                                   child: const Text(
//                                     "View more",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20.0,
//                                         fontWeight: FontWeight.bold),
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.height,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               SizedBox(
//                                 height: 50,
//                                 width: 50,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       image: const DecorationImage(
//                                         image:
//                                             AssetImage('assets/images/car.png'),
//                                       ),
//                                       color: Colors.lightGreen[600],
//                                       borderRadius: BorderRadius.circular(100)),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               const Text('Car'),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 40),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 50,
//                                   width: 50,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         image: const DecorationImage(
//                                           image: AssetImage(
//                                             'assets/images/hotel.png',
//                                           ),
//                                           scale: 0.7,
//                                         ),
//                                         color: Colors.yellow[700],
//                                         borderRadius:
//                                             BorderRadius.circular(100)),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 const Text('Hotel'),
//                               ],
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               SizedBox(
//                                 height: 50,
//                                 width: 50,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       image: const DecorationImage(
//                                         image: AssetImage(
//                                             'assets/images/travel.png'),
//                                         scale: 1.8,
//                                       ),
//                                       color: AppConfig.tripColor,
//                                       borderRadius: BorderRadius.circular(100)),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               const Text('Trip'),
//                             ],
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           SizedBox(
//                             width: 35,
//                           ),
//                           Text(
//                             'Offers',
//                             style: TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 220,
//                           ),
//                           Text(
//                             'See all',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         height: 300,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: 5,
//                           itemBuilder: (context, index) {
//                             return const SizedBox(
//                               width: 320,
//                               child: OfferCards(),
//                             ).p12();
//                           },
//                         ),
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           SizedBox(
//                             width: 35,
//                           ),
//                           Text(
//                             'Popular Cities',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 140,
//                           ),
//                           Text(
//                             'See all',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ).p8(),
//                       Expanded(
//                         child: Container(
//                           child: const PopularPlaceCard().p8(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             bottomNavigationBar: _buildBottomBar(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return CustomAnimatedBottomBar(
//       containerHeight: 70,
//       backgroundColor: Colors.white,
//       selectedIndex: _currentIndex,
//       showElevation: true,
//       itemCornerRadius: 24,
//       curve: Curves.easeIn,
//       onItemSelected: (index) => setState(() => _currentIndex = index),
//       items: <BottomNavyBarItem>[
//         BottomNavyBarItem(
//           icon: const Icon(Icons.apps),
//           title: const Text('Home'),
//           activeColor: Colors.green,
//           inactiveColor: _inactiveColor,
//           textAlign: TextAlign.center,
//         ),
//         BottomNavyBarItem(
//           icon: const Icon(Icons.people),
//           title: const Text('Users'),
//           activeColor: Colors.purpleAccent,
//           inactiveColor: _inactiveColor,
//           textAlign: TextAlign.center,
//         ),
//         BottomNavyBarItem(
//           icon: const Icon(Icons.message),
//           title: const Text(
//             'Messages ',
//           ),
//           activeColor: Colors.pink,
//           inactiveColor: _inactiveColor,
//           textAlign: TextAlign.center,
//         ),
//         BottomNavyBarItem(
//           icon: const Icon(Icons.settings),
//           title: const Text('Settings'),
//           activeColor: Colors.blue,
//           inactiveColor: _inactiveColor,
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   Widget getBody() {
//     List<Widget> pages = [
//       const HomePage(),
//     ];
//     return IndexedStack(
//       index: _currentIndex,
//       children: pages,
//     );
//   }
// }
