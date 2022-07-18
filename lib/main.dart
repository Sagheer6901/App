import 'dart:io';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/routes.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/forget_pass.dart';
import 'package:untitled/screens/AuthenticationScreens/landing_screen.dart';
import 'package:untitled/screens/DrawerScreens/PaymentScreens/add_payment_method.dart';
import 'package:untitled/screens/DrawerScreens/PaymentScreens/payment_methods.dart';
import 'package:untitled/screens/NavigationScreens/Map/places_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/signup_screen.dart';
import 'package:untitled/screens/NavigationScreens/map.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/PaymentHistoryScreen/payment_history.dart';
import 'package:untitled/services/push_notifications.dart';
import 'package:untitled/functions/upload_file.dart';
import 'package:untitled/up_image.dart';


//key generators
// keytool -list -v -keystore "C:\Users\saghe\Documents\k" -alias "key"
// keytool -list -v -keystore "C:\Users\saghe\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass an
// droid

//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await workmanager.initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
//   await workmanager.registerPeriodicTask("5", simplePeriodicTask,
//       existingWorkPolicy: ExistingWorkPolicy.replace,
//       frequency: Duration(minutes: 15),//when should it check the link
//       initialDelay: Duration(seconds: 5),//duration before showing the notification
//       constraints: Constraints(
//         networkType: NetworkType.connected,
//       ));
//   runApp(MyApp());
// }




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_){
    runApp(email == null ? MyApp() : NavigationScreen());
  }
  );
  // runApp(email == null ? MyApp() : NavigationScreen());


  // runApp(const MyApp());


}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          // MyRoutes.loginRoute: (context) => LoginScreen(),
          // MyRoutes.signUpRoute: (context) => SignUpScreen(),
          MyRoutes.forgetPass: (context) => ForgetPass(),
          // MyRoutes.wishRoute: (context) => WishList(),
          MyRoutes.map: (context) => Map(),
          // MyRoutes.addCardMethod: (context) => CardPayments(),
          // MyRoutes.addJazzOrEasy: (context) => JazzcashOrEasyPaisa(),
          // MyRoutes.paymentMethods: (context) => AddPaymentMethod(),
          // MyRoutes.updateMethods: (context) => PaymentMethods(),
          // MyRoutes.paymentHistory: (context) => PaymentHistory()
        });
  }
}










// // class BackgroundImage extends StatelessWidget {
// //   const BackgroundImage({Key? key}) : super(key: key);
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return ShaderMask(
// //       shaderCallback: (bounds) => LinearGradient(
// //         colors: [Colors.black, Colors.black12],
// //         begin: Alignment.bottomCenter,
// //         end: Alignment.center,
// //       ).createShader(bounds),
// //       blendMode: BlendMode.darken,
// //       child: Container(
// //         decoration: const BoxDecoration(
// //           image: DecorationImage(
// //             image: AssetImage('assets/images/home.jpg'),
// //             fit: BoxFit.fitWidth,
// //             colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
// //
// //
// //
// //
// // import 'package:flutter/material.dart';
// //
// // void main()
// // {
// //   runApp(MaterialApp(
// //     title: 'AndroidMonks',
// //     home: Scaffold(
// //       appBar: AppBar(
// //         title: Text('Androidmonks'),
// //         backgroundColor: Colors.orangeAccent,
// //       ),
// //       body: Home(),
// //     ),
// //   ));
// // }
// //
// // class Home extends StatefulWidget {
// //
// //
// //   @override
// //   State<Home> createState()=>_Home();
// // }
// //
// // class _Home extends State<Home> {
// //   String title = "Title";
// //   List<Widget> _fragments =[Fragment1(),Fragment2(),Fragment3()];
// //   int _currentIndex = 0;
// //   final List<int> _backstack = [0];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     //navigateTo(_currentIndex);
// //     //each fragment is just a widget which we pass the navigate function
// //
// //     //will pop scope catches the back button presses
// //     return WillPopScope(
// //       onWillPop: () {
// //         return customPop(context);
// //       },
// //       child: Scaffold(
// //         body: Column(
// //           children: <Widget>[
// //             RaisedButton(
// //               child:Text('PRESS'),
// //               onPressed: (){
// //                 _currentIndex++;
// //                 navigateTo(_currentIndex);
// //               },
// //             ),
// //             Expanded(
// //               child: _fragments[_currentIndex],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   void navigateTo(int index) {
// //     _backstack.add(index);
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //
// //     _setTitle('$index');
// //   }
// //
// //   void navigateBack(int index) {
// //     setState(() {
// //       _currentIndex = index;
// //     });
// //
// //     _setTitle('$index');
// //   }
// //
// //   Future<bool> customPop(BuildContext context) {
// //     print("CustomPop is called");
// //     print("_backstack = $_backstack");
// //     if (_backstack.length   > 1) {
// //       _backstack.removeAt(_backstack.length - 1);
// //       navigateBack(_backstack[_backstack.length - 1]);
// //
// //       return Future.value(false);
// //     } else {
// //
// //       return Future.value(true);
// //     }
// //   }
// //   //this method could be called by the navigate and navigate back methods
// //   _setTitle(String appBarTitle) {
// //     setState(() {
// //       title = appBarTitle;
// //     });
// //   }
// // }
// //
// // class Fragment2 extends StatefulWidget {
// //   @override
// //   State<Fragment2> createState() => _Fragment2();
// // }
// //
// // class _Fragment2 extends State<Fragment2> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: RaisedButton(
// //           child: Text("_Fragment2"),
// //           onPressed: (){
// //           }),
// //     );
// //   }
// // }
// //
// //
// // class Fragment1 extends StatefulWidget {
// //   @override
// //   State<Fragment1> createState() => _Fragment1();
// // }
// //
// // class _Fragment1 extends State<Fragment1> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text("_Fragment1"),
// //     );
// //   }
// // }
// //
// //
// // class Fragment3 extends StatefulWidget {
// //   @override
// //   State<Fragment3> createState() => _Fragment3();
// // }
// //
// // class _Fragment3 extends State<Fragment3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text("_Fragment3"),
// //     );
// //   }
// // }

//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:untitled/functions/app_config.dart';
// import 'package:untitled/screens/AuthenticationScreens/goog_signin_btn.dart';
// import 'package:untitled/screens/AuthenticationScreens/google_auth.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterFire Samples',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         brightness: Brightness.dark,
//       ),
//       home: SignInScreen(),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:                       AppConfig.carColor,
//
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 16.0,
//             right: 16.0,
//             bottom: 20.0,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Row(),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: Image.asset(
//                         'assets/firebase_logo.png',
//                         height: 160,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'FlutterFire',
//                       style: TextStyle(
//                         color:                       AppConfig.carColor,
//
//                         fontSize: 40,
//                       ),
//                     ),
//                     Text(
//                       'Authentication',
//                       style: TextStyle(
//                         color:                       AppConfig.carColor,
//
//                         fontSize: 40,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               FutureBuilder(
//                 future: Authentication.initializeFirebase(context: context),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text('Error initializing Firebase');
//                   } else if (snapshot.connectionState == ConnectionState.done) {
//                     return GoogleSignInButton();
//                   }
//                   return CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       AppConfig.carColor,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// class UserInfoScreen extends StatefulWidget {
//   const UserInfoScreen({Key? key, required User user})
//       : _user = user,
//         super(key: key);
//
//   final User _user;
//
//   @override
//   _UserInfoScreenState createState() => _UserInfoScreenState();
// }
//
// class _UserInfoScreenState extends State<UserInfoScreen> {
//   late User _user;
//   bool _isSigningOut = false;
//
//   Route _routeToSignInScreen() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var begin = Offset(-1.0, 0.0);
//         var end = Offset.zero;
//         var curve = Curves.ease;
//
//         var tween =
//         Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     _user = widget._user;
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:                  Colors.green,
//
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor:                   Colors.green,
//
//         // title: AppBarTitle(),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 16.0,
//             right: 16.0,
//             bottom: 20.0,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(),
//               _user.photoURL != null
//                   ? ClipOval(
//                 child: Material(
//                   color:           Colors.green.withOpacity(0.3),
//                   child: Image.network(
//                     _user.photoURL!,
//                     fit: BoxFit.fitHeight,
//                   ),
//                 ),
//               )
//                   : ClipOval(
//                 child: Material(
//                   color:                  Colors.green.withOpacity(0.3),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Icon(
//                       Icons.person,
//                       size: 60,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Hello',
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 26,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 _user.displayName!,
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 26,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 '( ${_user.email!} )',
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 20,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: 24.0),
//               Text(
//                 'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
//                 style: TextStyle(
//                     color: Colors.green.withOpacity(0.8),
//                     fontSize: 14,
//                     letterSpacing: 0.2),
//               ),
//               SizedBox(height: 16.0),
//               _isSigningOut
//                   ? CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               )
//                   : ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(
//                     Colors.redAccent,
//                   ),
//                   shape: MaterialStateProperty.all(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 onPressed: () async {
//                   setState(() {
//                     _isSigningOut = true;
//                   });
//                   await Authentication.signOut(context: context);
//                   setState(() {
//                     _isSigningOut = false;
//                   });
//                   Navigator.of(context)
//                       .pushReplacement(_routeToSignInScreen());
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//                   child: Text(
//                     'Sign Out',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       letterSpacing: 2,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//
// }
//
//
