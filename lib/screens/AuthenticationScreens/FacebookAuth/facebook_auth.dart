// // import com.facebook.FacebookSdk;
// // import com.facebook.appevents.AppEventsLogger;
// //
//
//
//
//
//
// // keytool -exportcert -alias androiddebugkey -keystore "C:\Users\USERNAME\.android\debug.keystore" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64
//
//
//
//
// // release key hash = eKJJHinr+D3pnrXYFuIJnPbO7ag=
//
//
//
//
// // @Override
// // public void onCreate() {
// //   super.onCreate();
// //   FacebookSdk.sdkInitialize(getApplicationContext());
// //   AppEventsLogger.activateApp(this);
// // }
//
//
//
//
//
//
//
//
//
// // import com.facebook.FacebookSdk;
// // import com.facebook.appevents.AppEventsLogger;
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// keytool -exportcert -alias androiddebugkey -keystore "C:\Users\USERNAME\.android\debug.keystore" | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" sha1 -binary | "PATH_TO_OPENSSL_LIBRARY\bin\openssl" base64
// //
// //
// //
// keytool -exportcert -alias YOUR_RELEASE_KEY_ALIAS -keystore YOUR_RELEASE_KEY_PATH | openssl sha1 -binary | openssl base64
//
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// class FacebookApp extends StatefulWidget {
//   const FacebookApp({Key? key}) : super(key: key);
//
//   @override
//   _FacebookAppState createState() => _FacebookAppState();
// }
//
// class _FacebookAppState extends State<FacebookApp> {
//   Map? _userData;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//             title: Text('Facebook (Logged ' +
//                 (_userData == null ? 'Out' : 'In') +
//                 ')')),
//         body: Center(
//           child: Column(
//             children: [
//               ElevatedButton(
//                   child: Text('Log In'),
//                   onPressed: () async {
//                     final result = await FacebookAuth.i
//                         .login(permissions: ["public_profile", "email"]);
//
//                     if (result.status == LoginStatus.success) {
//                       final userData = await FacebookAuth.i.getUserData(
//                         fields: "email,name",
//                       );
//
//                       setState(() {
//                         _userData = userData;
//                       });
//                     }
//                   }),
//               ElevatedButton(
//                   child: Text('Log Out'),
//                   onPressed: () async {
//                     await FacebookAuth.i.logOut();
//
//                     setState(() {
//                       _userData = null;
//                     });
//                   }),
//             ],
//           ), // Column
//         ),
//       ),
//     );
//   }
// }
