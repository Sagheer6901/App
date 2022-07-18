// import 'dart:convert';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// Workmanager workmanager = Workmanager();
// //this is the name given to the background fetch
// const simplePeriodicTask = "simplePeriodicTask";
// // flutter local notification setup
// void showNotification( v, flp) async {
//   var android = AndroidNotificationDetails(
//       'channel id', 'channel NAME', channelDescription: 'CHANNEL DESCRIPTION',
//       priority: Priority.high, importance: Importance.max);
//   var iOS = IOSNotificationDetails();
//   var platform = NotificationDetails(android: android, iOS: iOS);
//   await flp.show(0, 'Virtual intelligent solution', '$v', platform,
//       payload: 'VIS \n $v');
// }
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
//
// void callbackDispatcher() {
//   workmanager.executeTask((task, inputData) async {
//
//     FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOS = IOSInitializationSettings();
//     var initSetttings = InitializationSettings(android: android, iOS: iOS);
//     flp.initialize(initSetttings);
//
//
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userId = prefs.getString('id');
//     Uri uri = Uri.parse(
//         '${AppConfig.apiSrcLink}tApi.php?action=get_chat&user_id=$userId');
//
//     var response= await http.post(uri);
//     print("here================");
//     print(response);
//     var convert = json.decode(response.body);
//     if (response.statusCode == true) {
//       showNotification("convert['msg']", flp);
//     } else {
//       print("no messgae");
//     }
//
//
//     return Future.value(true);
//   });
// }
//
//
//
// class MyApp extends StatelessWidget {
//   MyApp();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter notification',
//         theme: ThemeData(
//           primarySwatch: Colors.teal,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text("Testing push notification")
//               ,
//               centerTitle: true,
//             ),
//             body: Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     child: Text("Flutter push notification without firebase with background fetch feature")
//                 ),
//               ),
//             )
//         ));
//   }
// }
//



// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//
// // void main() {
// //   return runApp(MyApp());
// // }
//
// /// My app class to display the date range picker
// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() => MyAppState();
// }
//
// /// State for MyApp
// class MyAppState extends State<MyApp> {
//   String _selectedDate = '';
//   String _dateCount = '';
//   String _range = '';
//   dynamic _rangeCount = '';
//   int daysBetween(DateTime from, DateTime to) {
//     from = DateTime(from.year, from.month, from.day);
//     to = DateTime(to.year, to.month, to.day);
//     return (to.difference(from).inHours / 24).round();
//   }
//   /// The method for [DateRangePickerSelectionChanged] callback, which will be
//   /// called whenever a selection changed on the date picker widget.
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     /// The argument value will return the changed date as [DateTime] when the
//     /// widget [SfDateRangeSelectionMode] set as single.
//     ///
//     /// The argument value will return the changed dates as [List<DateTime>]
//     /// when the widget [SfDateRangeSelectionMode] set as multiple.
//     ///
//     /// The argument value will return the changed range as [PickerDateRange]
//     /// when the widget [SfDateRangeSelectionMode] set as range.
//     ///
//     /// The argument value will return the changed ranges as
//     /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
//     /// multi range.
//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//         // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//         _rangeCount = daysBetween(args.value.startDate, args.value.endDate);
//       } else if (args.value is DateTime) {
//         _selectedDate = args.value.toString();
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         // _rangeCount = args.value.length.toString();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('DatePicker demo'),
//             ),
//             body: Stack(
//               children: <Widget>[
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   top: 0,
//                   height: 80,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text('Selected date: $_selectedDate'),
//                       Text('Selected date count: $_dateCount'),
//                       Text('Selected range: ${_range}'),
//                       Text('Selected ranges count: $_rangeCount')
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   top: 80,
//                   right: 0,
//                   bottom: 0,
//                   child: SfDateRangePicker(
//                     onSelectionChanged: _onSelectionChanged,
//                     selectionMode: DateRangePickerSelectionMode.range,
//                     initialSelectedRange: PickerDateRange(
//                         DateTime.now().subtract(const Duration(days: 4)),
//                         DateTime.now().add(const Duration(days: 3))),
//                   ),
//                 )
//               ],
//             )));
//   }
// }