// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
//
// class UploadPage extends StatefulWidget {
//   UploadPage({Key? key, this.url}) : super(key: key);
//
//   final String? url;
//
//   @override
//   _UploadPageState createState() => _UploadPageState();
// }
//
// class _UploadPageState extends State<UploadPage> {
//
//   Future<String?> uploadImage(filename, url) async {
//     var arr = filename.split('/');
//
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath('picture', arr[6]));
//     print("fiel name : $filename");
//     var res = await request.send();
//     print(" res file : $res");
//     return res.reasonPhrase;
//   }
//   String state = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter File Upload Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(state)
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var file = await ImagePicker().pickImage(source: ImageSource.gallery);
//           var res = await uploadImage(file!.path.toString(), widget.url);
//           setState(() {
//             state = res!;
//             print(res);
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
//
//
//















































//
// import 'dart:isolate';
// import 'dart:ui';
// import 'dart:async';
// import 'dart:io';
//
// import 'package:android_path_provider/android_path_provider.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// const debug = true;
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final platform = Theme.of(context).platform;
//
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(
//         title: 'Downloader',
//         platform: platform,
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget with WidgetsBindingObserver {
//   final TargetPlatform? platform;
//
//   MyHomePage({Key? key, this.title, this.platform}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final _documents = [
//     {
//       'name': 'Learning Android Studio',
//       'link':
//       'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'
//     },
//     {
//       'name': 'Android Programming Cookbook',
//       'link':
//       'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
//     },
//     {
//       'name': 'iOS Programming Guide',
//       'link':
//       'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'
//     },
//     {
//       'name': 'Objective-C Programming (Pre-Course Workbook',
//       'link':
//       'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'
//     },
//   ];
//
//   final _images = [
//     {
//       'name': 'Arches National Park',
//       'link':
//       'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
//     },
//     {
//       'name': 'Canyonlands National Park',
//       'link':
//       'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg'
//     },
//     {
//       'name': 'Death Valley National Park',
//       'link':
//       'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg'
//     },
//     {
//       'name': 'Gates of the Arctic National Park and Preserve',
//       'link':
//       'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg'
//     }
//   ];
//
//   final _videos = [
//     {
//       'name': 'Big Buck Bunny',
//       'link':
//       'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
//     },
//     {
//       'name': 'Elephant Dream',
//       'link':
//       'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
//     }
//   ];
//
//   List<_TaskInfo>? _tasks;
//   late List<_ItemHolder> _items;
//   late bool _isLoading;
//   late bool _permissionReady;
//   late String _localPath;
//   ReceivePort _port = ReceivePort();
//
//   @override
//   void initState() {
//     super.initState();
//
//     _bindBackgroundIsolate();
//
//     FlutterDownloader.registerCallback(downloadCallback);
//
//     _isLoading = true;
//     _permissionReady = false;
//
//     _prepare();
//   }
//
//   @override
//   void dispose() {
//     _unbindBackgroundIsolate();
//     super.dispose();
//   }
//
//   void _bindBackgroundIsolate() {
//     bool isSuccess = IsolateNameServer.registerPortWithName(
//         _port.sendPort, 'downloader_send_port');
//     if (!isSuccess) {
//       _unbindBackgroundIsolate();
//       _bindBackgroundIsolate();
//       return;
//     }
//     _port.listen((dynamic data) {
//       if (debug) {
//         print('UI Isolate Callback: $data');
//       }
//       String? id = data[0];
//       DownloadTaskStatus? status = data[1];
//       int? progress = data[2];
//
//       if (_tasks != null && _tasks!.isNotEmpty) {
//         final task = _tasks!.firstWhere((task) => task.taskId == id);
//         setState(() {
//           task.status = status;
//           task.progress = progress;
//         });
//       }
//     });
//   }
//
//   void _unbindBackgroundIsolate() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//   }
//
//   static void downloadCallback(
//       String id, DownloadTaskStatus status, int progress) {
//     if (debug) {
//       print(
//           'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
//     }
//     final SendPort send =
//     IsolateNameServer.lookupPortByName('downloader_send_port')!;
//     send.send([id, status, progress]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title!),
//       ),
//       body: Builder(
//           builder: (context) => _isLoading
//               ? new Center(
//             child: new CircularProgressIndicator(),
//           )
//               : _permissionReady
//               ? _buildDownloadList()
//               : _buildNoPermissionWarning()),
//     );
//   }
//
//   Widget _buildDownloadList() => Container(
//     child: ListView(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       children: _items
//           .map((item) => item.task == null
//           ? _buildListSection(item.name!)
//           : DownloadItem(
//         data: item,
//         onItemClick: (task) {
//           _openDownloadedFile(task).then((success) {
//             if (!success) {
//               Scaffold.of(context).showSnackBar(SnackBar(
//                   content: Text('Cannot open this file')));
//             }
//           });
//         },
//         onActionClick: (task) {
//           if (task.status == DownloadTaskStatus.undefined) {
//             _requestDownload(task);
//           } else if (task.status == DownloadTaskStatus.running) {
//             _pauseDownload(task);
//           } else if (task.status == DownloadTaskStatus.paused) {
//             _resumeDownload(task);
//           } else if (task.status == DownloadTaskStatus.complete) {
//             _delete(task);
//           } else if (task.status == DownloadTaskStatus.failed) {
//             _retryDownload(task);
//           }
//         },
//       ))
//           .toList(),
//     ),
//   );
//
//   Widget _buildListSection(String title) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: Text(
//       title,
//       style: TextStyle(
//           fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18.0),
//     ),
//   );
//
//   Widget _buildNoPermissionWarning() => Container(
//     child: Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Text(
//               'Please grant accessing storage permission to continue -_-',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
//             ),
//           ),
//           SizedBox(
//             height: 32.0,
//           ),
//           FlatButton(
//               onPressed: () {
//                 _retryRequestPermission();
//               },
//               child: Text(
//                 'Retry',
//                 style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0),
//               ))
//         ],
//       ),
//     ),
//   );
//
//   Future<void> _retryRequestPermission() async {
//     final hasGranted = await _checkPermission();
//
//     if (hasGranted) {
//       await _prepareSaveDir();
//     }
//
//     setState(() {
//       _permissionReady = hasGranted;
//     });
//   }
//
//   void _requestDownload(_TaskInfo task) async {
//     task.taskId = await FlutterDownloader.enqueue(
//       url: task.link!,
//       headers: {"auth": "test_for_sql_encoding"},
//       savedDir: _localPath,
//       showNotification: true,
//       openFileFromNotification: true,
//       saveInPublicStorage: true,
//     );
//   }
//
//   void _cancelDownload(_TaskInfo task) async {
//     await FlutterDownloader.cancel(taskId: task.taskId!);
//   }
//
//   void _pauseDownload(_TaskInfo task) async {
//     await FlutterDownloader.pause(taskId: task.taskId!);
//   }
//
//   void _resumeDownload(_TaskInfo task) async {
//     String? newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
//     task.taskId = newTaskId;
//   }
//
//   void _retryDownload(_TaskInfo task) async {
//     String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
//     task.taskId = newTaskId;
//   }
//
//   Future<bool> _openDownloadedFile(_TaskInfo? task) {
//     if (task != null) {
//       return FlutterDownloader.open(taskId: task.taskId!);
//     } else {
//       return Future.value(false);
//     }
//   }
//
//   void _delete(_TaskInfo task) async {
//     await FlutterDownloader.remove(
//         taskId: task.taskId!, shouldDeleteContent: true);
//     await _prepare();
//     setState(() {});
//   }
//
//   Future<bool> _checkPermission() async {
//     if (Platform.isIOS) return true;
//
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     if (widget.platform == TargetPlatform.android &&
//         androidInfo.version.sdkInt! <= 28) {
//       final status = await Permission.storage.status;
//       if (status != PermissionStatus.granted) {
//         final result = await Permission.storage.request();
//         if (result == PermissionStatus.granted) {
//           return true;
//         }
//       } else {
//         return true;
//       }
//     } else {
//       return true;
//     }
//     return false;
//   }
//
//   Future<Null> _prepare() async {
//     final tasks = await FlutterDownloader.loadTasks();
//
//     int count = 0;
//     _tasks = [];
//     _items = [];
//
//     _tasks!.addAll(_documents.map((document) =>
//         _TaskInfo(name: document['name'], link: document['link'])));
//
//     _items.add(_ItemHolder(name: 'Documents'));
//     for (int i = count; i < _tasks!.length; i++) {
//       _items.add(_ItemHolder(name: _tasks![i].name, task: _tasks![i]));
//       count++;
//     }
//
//     _tasks!.addAll(_images
//         .map((image) => _TaskInfo(name: image['name'], link: image['link'])));
//
//     _items.add(_ItemHolder(name: 'Images'));
//     for (int i = count; i < _tasks!.length; i++) {
//       _items.add(_ItemHolder(name: _tasks![i].name, task: _tasks![i]));
//       count++;
//     }
//
//     _tasks!.addAll(_videos
//         .map((video) => _TaskInfo(name: video['name'], link: video['link'])));
//
//     _items.add(_ItemHolder(name: 'Videos'));
//     for (int i = count; i < _tasks!.length; i++) {
//       _items.add(_ItemHolder(name: _tasks![i].name, task: _tasks![i]));
//       count++;
//     }
//
//     tasks!.forEach((task) {
//       for (_TaskInfo info in _tasks!) {
//         if (info.link == task.url) {
//           info.taskId = task.taskId;
//           info.status = task.status;
//           info.progress = task.progress;
//         }
//       }
//     });
//
//     _permissionReady = await _checkPermission();
//
//     if (_permissionReady) {
//       await _prepareSaveDir();
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _prepareSaveDir() async {
//     _localPath = (await _findLocalPath())!;
//     final savedDir = Directory(_localPath);
//     bool hasExisted = await savedDir.exists();
//     if (!hasExisted) {
//       savedDir.create();
//     }
//   }
//
//   Future<String?> _findLocalPath() async {
//     var externalStorageDirPath;
//     if (Platform.isAndroid) {
//       try {
//         externalStorageDirPath = await AndroidPathProvider.downloadsPath;
//       } catch (e) {
//         final directory = await getExternalStorageDirectory();
//         externalStorageDirPath = directory?.path;
//       }
//     } else if (Platform.isIOS) {
//       externalStorageDirPath =
//           (await getApplicationDocumentsDirectory()).absolute.path;
//     }
//     return externalStorageDirPath;
//   }
// }
//
// class DownloadItem extends StatelessWidget {
//   final _ItemHolder? data;
//   final Function(_TaskInfo?)? onItemClick;
//   final Function(_TaskInfo)? onActionClick;
//
//   DownloadItem({this.data, this.onItemClick, this.onActionClick});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 16.0, right: 8.0),
//       child: InkWell(
//         onTap: data!.task!.status == DownloadTaskStatus.complete
//             ? () {
//           onItemClick!(data!.task);
//         }
//             : null,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               width: double.infinity,
//               height: 64.0,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Text(
//                       data!.name!,
//                       maxLines: 1,
//                       softWrap: true,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: _buildActionForTask(data!.task!),
//                   ),
//                 ],
//               ),
//             ),
//             data!.task!.status == DownloadTaskStatus.running ||
//                 data!.task!.status == DownloadTaskStatus.paused
//                 ? Positioned(
//               left: 0.0,
//               right: 0.0,
//               bottom: 0.0,
//               child: LinearProgressIndicator(
//                 value: data!.task!.progress! / 100,
//               ),
//             )
//                 : Container()
//           ].toList(),
//         ),
//       ),
//     );
//   }
//
//   Widget? _buildActionForTask(_TaskInfo task) {
//     if (task.status == DownloadTaskStatus.undefined) {
//       return RawMaterialButton(
//         onPressed: () {
//           onActionClick!(task);
//         },
//         child: Icon(Icons.file_download),
//         shape: CircleBorder(),
//         constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//       );
//     } else if (task.status == DownloadTaskStatus.running) {
//       return RawMaterialButton(
//         onPressed: () {
//           onActionClick!(task);
//         },
//         child: Icon(
//           Icons.pause,
//           color: Colors.red,
//         ),
//         shape: CircleBorder(),
//         constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//       );
//     } else if (task.status == DownloadTaskStatus.paused) {
//       return RawMaterialButton(
//         onPressed: () {
//           onActionClick!(task);
//         },
//         child: Icon(
//           Icons.play_arrow,
//           color: Colors.green,
//         ),
//         shape: CircleBorder(),
//         constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//       );
//     } else if (task.status == DownloadTaskStatus.complete) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(
//             'Ready',
//             style: TextStyle(color: Colors.green),
//           ),
//           RawMaterialButton(
//             onPressed: () {
//               onActionClick!(task);
//             },
//             child: Icon(
//               Icons.delete_forever,
//               color: Colors.red,
//             ),
//             shape: CircleBorder(),
//             constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//           )
//         ],
//       );
//     } else if (task.status == DownloadTaskStatus.canceled) {
//       return Text('Canceled', style: TextStyle(color: Colors.red));
//     } else if (task.status == DownloadTaskStatus.failed) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text('Failed', style: TextStyle(color: Colors.red)),
//           RawMaterialButton(
//             onPressed: () {
//               onActionClick!(task);
//             },
//             child: Icon(
//               Icons.refresh,
//               color: Colors.green,
//             ),
//             shape: CircleBorder(),
//             constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
//           )
//         ],
//       );
//     } else if (task.status == DownloadTaskStatus.enqueued) {
//       return Text('Pending', style: TextStyle(color: Colors.orange));
//     } else {
//       return null;
//     }
//   }
// }
//
// class _TaskInfo {
//   final String? name;
//   final String? link;
//
//   String? taskId;
//   int? progress = 0;
//   DownloadTaskStatus? status = DownloadTaskStatus.undefined;
//
//   _TaskInfo({this.name, this.link});
// }
//
// class _ItemHolder {
//   final String? name;
//   final _TaskInfo? task;
//
//   _ItemHolder({this.name, this.task});
// }



















import 'package:flutter/material.dart';
import 'dart:async';

//import OneSignal
import 'package:onesignal_flutter/onesignal_flutter.dart';

// void main() => runApp(new MyApp());

class PushNot extends StatefulWidget {
  @override
  _PushNotState createState() => new _PushNotState();
}

class _PushNotState extends State<PushNot> {
  String _debugLabelString = "";
  String? _emailAddress;
  String? _smsNumber;
  String? _externalUserId;
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');
      /// Display Notification, send null to not display
      event.complete(null);

      this.setState(() {
        _debugLabelString =
        "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      this.setState(() {
        _debugLabelString =
        "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
            (OSEmailSubscriptionStateChanges changes) {
          print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
        });

    OneSignal.shared.setSMSSubscriptionObserver(
            (OSSMSSubscriptionStateChanges changes) {
          print("SMS SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
        });

    OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
      print("ON WILL DISPLAY IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnDidDisplayInAppMessageHandler((message) {
      print("ON DID DISPLAY IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnWillDismissInAppMessageHandler((message) {
      print("ON WILL DISMISS IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnDidDismissInAppMessageHandler((message) {
      print("ON DID DISMISS IN APP MESSAGE ${message.messageId}");
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared
        .setAppId("49e7d734-8a8f-4ec9-8c3e-1c8bcb4fc099");

    // iOS-only method to open launch URLs in Safari when set to false
    OneSignal.shared.setLaunchURLsInApp(false);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });

    // Some examples of how to use In App Messaging public methods with OneSignal SDK
    oneSignalInAppMessagingTriggerExamples();

    OneSignal.shared.disablePush(false);

    // Some examples of how to use Outcome Events public methods with OneSignal SDK
    oneSignalOutcomeEventsExamples();

    bool userProvidedPrivacyConsent = await OneSignal.shared.userProvidedPrivacyConsent();
    print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  }

  void _handleGetTags() {
    OneSignal.shared.getTags().then((tags) {
      if (tags == null) return;

      setState((() {
        _debugLabelString = "$tags";
      }));
    }).catchError((error) {
      setState(() {
        _debugLabelString = "$error";
      });
    });
  }

  void _handleSendTags() {
    print("Sending tags");
    OneSignal.shared.sendTag("test2", "val2").then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });

    print("Sending tags array");
    var sendTags = {'test': 'value'};
    OneSignal.shared.sendTags(sendTags).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  void _handlePromptForPushPermission() {
    print("Prompting for Permission");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  void _handleGetDeviceState() async {
    print("Getting DeviceState");
    OneSignal.shared.getDeviceState().then((deviceState) {
      print("DeviceState: ${deviceState?.jsonRepresentation()}");
      this.setState(() {
        _debugLabelString = deviceState?.jsonRepresentation() ?? "Device state null";
      });
    });
  }

  void _handleSetEmail() {
    if (_emailAddress == null) return;

    print("Setting email");

    OneSignal.shared.setEmail(email: _emailAddress!).whenComplete(() {
      print("Successfully set email");
    }).catchError((error) {
      print("Failed to set email with error: $error");
    });
  }

  void _handleLogoutEmail() {
    print("Logging out of email");

    OneSignal.shared.logoutEmail().then((v) {
      print("Successfully logged out of email");
    }).catchError((error) {
      print("Failed to log out of email: $error");
    });
  }

  void _handleSetSMSNumber() {
    if (_smsNumber == null) return;

    print("Setting SMS Number");

    OneSignal.shared.setSMSNumber(smsNumber: _smsNumber!).then((response) {
      print("Successfully set SMSNumber with response $response");
    }).catchError((error) {
      print("Failed to set SMS Number with error: $error");
    });
  }

  void _handleLogoutSMSNumber() {
    print("Logging out of smsNumber");

    OneSignal.shared.logoutSMSNumber().then((response) {
      print("Successfully logoutEmail with response $response");
    }).catchError((error) {
      print("Failed to log out of SMSNumber: $error");
    });
  }

  void _handleConsent() {
    print("Setting consent to true");
    OneSignal.shared.consentGranted(true);

    print("Setting state");
    this.setState(() {
      _enableConsentButton = false;
    });
  }

  void _handleSetLocationShared() {
    print("Setting location shared to true");
    OneSignal.shared.setLocationShared(true);
  }

  void _handleDeleteTag() {
    print("Deleting tag");
    OneSignal.shared.deleteTag("test2").then((response) {
      print("Successfully deleted tags with response $response");
    }).catchError((error) {
      print("Encountered error deleting tag: $error");
    });

    print("Deleting tags array");
    OneSignal.shared.deleteTags(['test']).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  void _handleSetExternalUserId() {
    print("Setting external user ID");
    if (_externalUserId == null) return;

    OneSignal.shared.setExternalUserId(_externalUserId!).then((results) {
      if (results == null) return;

      this.setState(() {
        _debugLabelString = "External user id set: $results";
      });
    });
  }

  void _handleRemoveExternalUserId() {
    OneSignal.shared.removeExternalUserId().then((results) {
      if (results == null) return;

      this.setState(() {
        _debugLabelString = "External user id removed: $results";
      });
    });
  }

  void _handleSendNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null)
      return;

    var playerId = deviceState.userId!;

    var imgUrlString =
        "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "this is a test from OneSignal's Flutter SDK",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);

    this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    });
  }

  void _handleSendSilentNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null)
      return;

    var playerId = deviceState.userId!;

    var notification = OSCreateNotification.silentNotification(
        playerIds: [playerId], additionalData: {'test': 'value'});

    var response = await OneSignal.shared.postNotification(notification);

    this.setState(() {
      _debugLabelString = "Sent notification with response: $response";
    });
  }

  oneSignalInAppMessagingTriggerExamples() async {
    /// Example addTrigger call for IAM
    /// This will add 1 trigger so if there are any IAM satisfying it, it
    /// will be shown to the user
    OneSignal.shared.addTrigger("trigger_1", "one");

    /// Example addTriggers call for IAM
    /// This will add 2 triggers so if there are any IAM satisfying these, they
    /// will be shown to the user
    Map<String, Object> triggers = new Map<String, Object>();
    triggers["trigger_2"] = "two";
    triggers["trigger_3"] = "three";
    OneSignal.shared.addTriggers(triggers);

    // Removes a trigger by its key so if any future IAM are pulled with
    // these triggers they will not be shown until the trigger is added back
    OneSignal.shared.removeTriggerForKey("trigger_2");

    // Get the value for a trigger by its key
    Object? triggerValue = await OneSignal.shared.getTriggerValueForKey("trigger_3");
    print("'trigger_3' key trigger value: ${triggerValue?.toString()}");

    // Create a list and bulk remove triggers based on keys supplied
    List<String> keys = ["trigger_1", "trigger_3"];
    OneSignal.shared.removeTriggersForKeys(keys);

    // Toggle pausing (displaying or not) of IAMs
    OneSignal.shared.pauseInAppMessages(false);
  }

  oneSignalOutcomeEventsExamples() async {
    // Await example for sending outcomes
    outcomeAwaitExample();

    // Send a normal outcome and get a reply with the name of the outcome
    OneSignal.shared.sendOutcome("normal_1");
    OneSignal.shared.sendOutcome("normal_2").then((outcomeEvent) {
      print(outcomeEvent.jsonRepresentation());
    });

    // Send a unique outcome and get a reply with the name of the outcome
    OneSignal.shared.sendUniqueOutcome("unique_1");
    OneSignal.shared.sendUniqueOutcome("unique_2").then((outcomeEvent) {
      print(outcomeEvent.jsonRepresentation());
    });

    // Send an outcome with a value and get a reply with the name of the outcome
    OneSignal.shared.sendOutcomeWithValue("value_1", 3.2);
    OneSignal.shared.sendOutcomeWithValue("value_2", 3.9).then((outcomeEvent) {
      print(outcomeEvent.jsonRepresentation());
    });
  }

  Future<void> outcomeAwaitExample() async {
    var outcomeEvent = await OneSignal.shared.sendOutcome("await_normal_1");
    print(outcomeEvent.jsonRepresentation());
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('OneSignal Flutter Demo'),
            backgroundColor: Color.fromARGB(255, 212, 86, 83),
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: new Table(
                children: [
                  new TableRow(children: [
                    new OneSignalButton(
                        "Get Tags", _handleGetTags, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Send Tags", _handleSendTags, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Prompt for Push Permission",
                        _handlePromptForPushPermission, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Print Device State",
                        _handleGetDeviceState,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Email Address",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 212, 86, 83),
                          )),
                      onChanged: (text) {
                        this.setState(() {
                          _emailAddress = text == "" ? null : text;
                        });
                      },
                    )
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Set Email", _handleSetEmail, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Logout Email", _handleLogoutEmail,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "SMS Number",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 212, 86, 83),
                          )),
                      onChanged: (text) {
                        this.setState(() {
                          _smsNumber = text == "" ? null : text;
                        });
                      },
                    )
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Set SMS Number", _handleSetSMSNumber, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Logout SMS Number", _handleLogoutSMSNumber,
                        !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Provide GDPR Consent", _handleConsent,
                        _enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Set Location Shared",
                        _handleSetLocationShared, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Delete Tag", _handleDeleteTag, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Post Notification",
                        _handleSendNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton("Post Silent Notification",
                        _handleSendSilentNotification, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "External User ID",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 212, 86, 83),
                          )),
                      onChanged: (text) {
                        this.setState(() {
                          _externalUserId = text == "" ? null : text;
                        });
                      },
                    )
                  ]),
                  new TableRow(children: [
                    Container(
                      height: 8.0,
                    )
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Set External User ID", _handleSetExternalUserId, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new OneSignalButton(
                        "Remove External User ID", _handleRemoveExternalUserId, !_enableConsentButton)
                  ]),
                  new TableRow(children: [
                    new Container(
                      child: new Text(_debugLabelString),
                      alignment: Alignment.center,
                    )
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}

typedef void OnButtonPressed();

class OneSignalButton extends StatefulWidget {
  final String title;
  final OnButtonPressed onPressed;
  final bool enabled;

  OneSignalButton(this.title, this.onPressed, this.enabled);

  State<StatefulWidget> createState() => new OneSignalButtonState();
}

class OneSignalButtonState extends State<OneSignalButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Table(
      children: [
        new TableRow(children: [
          new FlatButton(
            disabledColor: Color.fromARGB(180, 212, 86, 83),
            disabledTextColor: Colors.white,
            color: Color.fromARGB(255, 212, 86, 83),
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: new Text(widget.title),
            onPressed: widget.enabled ? widget.onPressed : null,
          )
        ]),
        new TableRow(children: [
          Container(
            height: 8.0,
          )
        ]),
      ],
    );
  }
}