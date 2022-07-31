import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/conversation_model.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/image_view.dart';
import 'package:untitled/screens/NavigationScreens/HomeScreen/home_page.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';
import 'package:untitled/functions/upload_file.dart';


// class ChatScreen extends StatefulWidget {
//   final String? jsonFileName;
//   final Stream<List<ConversationModel>>? chat;
//
//
//   var title;
//   ChatScreen({this.jsonFileName,this.chat, this.title});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _textController = new TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fToast = FToast();
//     fToast.init(context);
//   }
//   late AppConfig _appConfig;
//   var picked;
//   late FToast fToast;
//
//   @override
//   Widget build(BuildContext context) {
//     // var _scaffoldKey = GlobalKey<ScaffoldState>();
//     _appConfig = AppConfig(context);
//     SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(
//             statusBarColor: AppConfig.tripColor
//           //color set to transperent or set your own color
//         )
//     );
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: AppConfig.queryBackground,
//       // key: _scaffoldKey,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(_appConfig.rH(8)),
//         child: Container(
//             color: AppConfig.whiteColor,
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage(
//                         'assets/images/user.png',
//                       ),
//                       maxRadius: 30,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Admin",
//                             style: TextStyle(
//                                 fontSize: AppConfig.f4,
//                                 fontWeight: FontWeight.w700,
//                                 color: AppConfig.tripColor),
//                           ),
//                           // Expanded(
//                           //   child: Container(
//                           //     width: _appConfig.rW(50),
//                           //     child: RichText(
//                           //       overflow: TextOverflow.ellipsis,
//                           //       strutStyle: StrutStyle(fontSize: 12.0),
//                           //       text: TextSpan(
//                           //           style:
//                           //               TextStyle(color: AppConfig.textColor),
//                           //           text: '${AppConfig.dummyReview}'),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Icon(
//                   Icons.more_horiz,
//                   color: AppConfig.queryBackground,
//                   size: 50,
//                 ),
//               ],
//             )),
//       ),
//
//       //
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   automaticallyImplyLeading: false,
//       //   backgroundColor: shadeColor,
//       //   flexibleSpace:
//       // ),
//
//       body: WillPopScope(
//         onWillPop: () {
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => NavigationScreen()),
//               (route) => false);
//           return Future.value(false);
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//
//           children: [
//             // Expanded(child: AppBody(messages: messages)),
//             Expanded(
//               child: StreamBuilder<List<ConversationModel>>(
//                 stream: WebServices.productsStream(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) print(snapshot.error);
//                   return snapshot.hasData
//                       ? ChatList(items: snapshot.data)
//
//                   // return the ListView widget :
//                       : Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//
//             Container(
//               padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//               // height: 60,
//               color: AppConfig.whiteColor,
//               width: double.infinity,
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 15,
//                   ),
//                   IconButton(
//                     color: Colors.white,
//                     icon: Icon(
//                       Icons.attach_file,
//                       color: AppConfig.textColor,
//                       size: 25,
//                     ),
//                     onPressed: () async {
//                       picked = await FilePicker.platform.pickFiles();
//                     },
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                           hintText: "Write message...",
//                           hintStyle: TextStyle(color: AppConfig.textColor),
//                           border: InputBorder.none),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   IconButton(
//                     color: Colors.white,
//                     icon: Icon(
//                       Icons.send,
//                       color: AppConfig.textColor,
//                       size: 25,
//                     ),
//                     onPressed:() async {
//                       SharedPreferences prefs = await SharedPreferences.getInstance();
//                       var userId = prefs.getString('id');
//
//                       if(picked!=null || _controller.text!=null || _controller.text!="") {
//                         WebServices.sentChat(userId,userId,_controller.text,picked);
//
//                         // print(" pickfile");
//                         // showCustomToast();
//                       }
//                       else{
//
//                           print(" pickfile");
//                           showCustomToast();
//
//                       }
//                       setState(() {
//                         _controller.text="";
//                         picked  =  null;
//                         print(" clear1");
//
//                       });
//                       // if(picked==null && _controller.text==null) {
//                       //   WebServices.sentChat(userId,userId,_controller.text,picked);
//                       //
//                       //   print(" pickfile");
//                       //   showCustomToast();
//                       // }
//
//                       picked= null;
//                       _controller.clear();
//                       // ChatList().scrollcontroller.animateTo(
//                       //   ChatList().scrollcontroller.position.maxScrollExtent,
//                       //   curve: Curves.easeOut,
//                       //   duration: const Duration(milliseconds: 300),
//                       // );
//                     }
//                   ),
//                 ],
//               ),
//             ),
//
//             // Container(
//             //   padding: const EdgeInsets.symmetric(
//             //     horizontal: 10,
//             //     vertical: 5,
//             //   ),
//             //   color: Colors.blue,
//             //   child: Row(
//             //     children: [
//             //       Expanded(
//             //         child: TextField(
//             //           controller: _controller,
//             //           style: TextStyle(color: Colors.white),
//             //         ),
//             //       ),
//             //       IconButton(
//             //         color: Colors.white,
//             //         icon: Icon(Icons.send),
//             //         onPressed: () {
//             //           sendMessage(_controller.text);
//             //           _controller.clear();
//             //         },
//             //       ),
//             //     ],
//             //   ),
//             // ),
//
//           ],
//         ),
//       ),
//     ));
//   }
//   showCustomToast() {
//     Widget toast = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: AppConfig.shadeColor,
//       ),
//       child: Text("No attachment or Field is empty",textScaleFactor: 1,),
//     );
//
//     fToast.showToast(
//       child: toast,
//       toastDuration: Duration(seconds: 1),
//     );
//   }
//
//
// // void sendMessage(String text) async {
//   //   if (text.isEmpty) return;
//   //   setState(() {
//   //     addMessage(
//   //       // Message(text: DialogText(text: [text])),
//   //       true,
//   //     );
//   //   });
//   //
//   //   // dialogFlowtter.projectId = "deimos-apps-0905";
//   //
//   //   // DetectIntentResponse response = await dialogFlowtter.detectIntent(
//   //   //   queryInput: QueryInput(text: TextInput(text: text)),
//   //   // );
//   //
//   //   // if (response.message == null) return;
//   //   // setState(() {
//   //   //   addMessage(response.message);
//   //   // });
//   // }
//
//   // void addMessage(message, [bool isUserMessage = false]) {
//   //   messages.add({
//   //     'message': message,
//   //     'isUserMessage': isUserMessage,
//   //   });
//   // }
//   // void addMessage(Message message, [bool isUserMessage = false]) {
//   //   messages.add({
//   //     'message': message,
//   //     'isUserMessage': isUserMessage,
//   //   });
//   // }
//
//   // @override
//   // void dispose() {
//   //   dialogFlowtter.dispose();
//   //   super.dispose();
//   // }
// }
//







const debug = true;



class ChatScreen extends StatefulWidget{
  final String? jsonFileName;
  final Stream<List<ConversationModel>>? chat;


  var title;
  ChatScreen({this.jsonFileName,this.chat, this.title});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _textController = new TextEditingController();

  late AppConfig _appConfig;
  var picked;
  late FToast fToast;
  var upload=null;
  var txt= null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    updateStatus();
    setState(() {
      oldChatCount=0;
    });
  }
updateStatus(){
  WebServices.addNotStatus();

}
  Color color =  AppConfig.textColor;


  @override
  Widget build(BuildContext context) {
    // var _scaffoldKey = GlobalKey<ScaffoldState>();

    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppConfig.tripColor
          //color set to transperent or set your own color
        )
    );

    return SafeArea(
        child: Scaffold(
          backgroundColor: AppConfig.queryBackground,
          // key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_appConfig.rH(8)),
            child: Container(
                color: AppConfig.whiteColor,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/user.png',
                          ),
                          maxRadius: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Admin",
                                style: TextStyle(
                                    fontSize: AppConfig.f4,
                                    fontWeight: FontWeight.w700,
                                    color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyMedium),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     width: _appConfig.rW(50),
                              //     child: RichText(
                              //       overflow: TextOverflow.ellipsis,
                              //       strutStyle: StrutStyle(fontSize: 12.0),
                              //       text: TextSpan(
                              //           style:
                              //               TextStyle(color: AppConfig.textColor),
                              //           text: '${AppConfig.dummyReview}'),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/traboon_logo.png",
                      height: _appConfig.rH(5),
                    ),
                    // Icon(
                    //   Icons.more_horiz,
                    //   color: AppConfig.queryBackground,
                    //   size: 50,
                    // ),
                  ],
                )),
          ),

          //
          // appBar: AppBar(
          //   elevation: 0,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: shadeColor,
          //   flexibleSpace:
          // ),

          body: WillPopScope(
            onWillPop: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationScreen()),
                      (route) => false);
              return Future.value(false);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // Expanded(child: AppBody(messages: messages)),
                Expanded(
                  child: StreamBuilder<List<ConversationModel>>(
                    stream: WebServices.productsStreamchat(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ChatList(items: snapshot.data)

                      // return the ListView widget :
                          : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  // height: 60,
                  color: AppConfig.whiteColor,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                     upload == null ? IconButton(
                        color: Colors.white,
                        icon:Icon(
                          Icons.attach_file,
                          color: AppConfig.textColor,
                          size: _appConfig.rW(6),
                        ),
                        onPressed: () async {
                          picked = await FilePicker.platform.pickFiles();
                          setState(() {
                            upload = picked;

                          });
                          },
                      ):
                      Row(
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon:Icon(
                              Icons.attachment,
                              color: AppConfig.carColor,
                              size: _appConfig.rW(6),
                            ),
                            onPressed: () async {
                              picked = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ["jpg","png","jpeg","doc","docx","pdf"] );
                              setState(() {
                                upload = picked;

                              });
                            },
                          ),
                          IconButton(
                            color: Colors.white,
                            icon:Icon(
                              Icons.close,
                              color: AppConfig.carColor,
                              size: _appConfig.rW(6),
                            ),
                            onPressed: () async {
                              setState(() {
                                picked=null;
                                upload=picked;
                              });

                            },
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: _controller,
                            decoration: InputDecoration(

                                hintText: "Write message...",
                                hintStyle: TextStyle(color: AppConfig.textColor),
                                border: InputBorder.none),
                            keyboardType: TextInputType.multiline,

                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      IconButton(
                          color: Colors.white,
                          icon: Icon(
                            Icons.send,
                            color: AppConfig.textColor,
                            size: 25,
                          ),
                          onPressed:() async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var userId = prefs.getString('id');
                            String toSendString = _controller.text.trimLeft(); //Send toSendString instead of inputText

                            if(upload!=null || toSendString.isNotEmpty) {
                              WebServices.sentChat(userId,userId,toSendString,picked);
                              // print(" pickfile");
                              // showCustomToast();
                            }
                            else{

                              print(" pickfile");
                              showCustomToast();

                            }

                            // if(picked==null && _controller.text==null) {
                            //   WebServices.sentChat(userId,userId,_controller.text,picked);
                            //
                            //   print(" pickfile");
                            //   showCustomToast();
                            // }

                            picked= null;
                            _controller.clear();
                            setState(() {
                              upload = null;
                            });
                            // ChatList().scrollcontroller.animateTo(
                            //   ChatList().scrollcontroller.position.maxScrollExtent,
                            //   curve: Curves.easeOut,
                            //   duration: const Duration(milliseconds: 300),
                            // );
                          }
                      ),
                    ],
                  ),
                ),

                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 10,
                //     vertical: 5,
                //   ),
                //   color: Colors.blue,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: TextField(
                //           controller: _controller,
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //       IconButton(
                //         color: Colors.white,
                //         icon: Icon(Icons.send),
                //         onPressed: () {
                //           sendMessage(_controller.text);
                //           _controller.clear();
                //         },
                //       ),
                //     ],
                //   ),
                // ),

              ],
            ),
          ),
        ));
  }
  showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppConfig.shadeColor,
      ),
      child: Text("No attachment or Field is empty",textScaleFactor: 1,),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 1),
    );
  }





// void sendMessage(String text) async {
//   if (text.isEmpty) return;
//   setState(() {
//     addMessage(
//       // Message(text: DialogText(text: [text])),
//       true,
//     );
//   });
//
//   // dialogFlowtter.projectId = "deimos-apps-0905";
//
//   // DetectIntentResponse response = await dialogFlowtter.detectIntent(
//   //   queryInput: QueryInput(text: TextInput(text: text)),
//   // );
//
//   // if (response.message == null) return;
//   // setState(() {
//   //   addMessage(response.message);
//   // });
// }

// void addMessage(message, [bool isUserMessage = false]) {
//   messages.add({
//     'message': message,
//     'isUserMessage': isUserMessage,
//   });
// }
// void addMessage(Message message, [bool isUserMessage = false]) {
//   messages.add({
//     'message': message,
//     'isUserMessage': isUserMessage,
//   });
// }

// @override
// void dispose() {
//   dialogFlowtter.dispose();
//   super.dispose();
// }
}



class DownloadItem extends StatelessWidget {
  final _ItemHolder? data;
  final Function(_TaskInfo?)? onItemClick;
  final Function(_TaskInfo)? onActionClick;

  DownloadItem({this.data, this.onItemClick, this.onActionClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: InkWell(
        onTap: data!.task!.status == DownloadTaskStatus.complete
            ? () {
          onItemClick!(data!.task);
        }
            : null,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 64.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data!.name!,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildActionForTask(data!.task!),
                  ),
                ],
              ),
            ),
            data!.task!.status == DownloadTaskStatus.running ||
                data!.task!.status == DownloadTaskStatus.paused
                ? Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: LinearProgressIndicator(
                value: data!.task!.progress! / 100,
              ),
            )
                : Container()
          ].toList(),
        ),
      ),
    );
  }

  Widget? _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(Icons.file_download),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick!(task);
        },
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Ready',
            style: TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              onActionClick!(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Text('Canceled', style: TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Failed', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              onActionClick!(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {
      return Text('Pending', style: TextStyle(color: Colors.orange));
    } else {
      return null;
    }
  }
}

class _TaskInfo {
  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String? name;
  final _TaskInfo? task;

  _ItemHolder({this.name, this.task});
}



































class ChatList extends StatefulWidget {
  final List<ConversationModel>? items;
  ChatList({Key? key, this.items});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late AppConfig _appConfig;

  ScrollController scrollController= ScrollController();


  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return SingleChildScrollView(
      reverse: true,
      child: ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.items!.length,
        controller: scrollController,


        itemBuilder: (context, index) {
          return ChatCard(item: widget.items![index]);
        },
      ),
    );
  }

  // void scrollToBottom() {
  //   final bottomOffset = scrollController.position.maxScrollExtent;
  //   scrollController.animateTo(
  //     bottomOffset,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }
}

// class ChatCard extends StatefulWidget  with WidgetsBindingObserver {
//   final ConversationModel? item;
//   const ChatCard({Key? key,this.item}) : super(key: key);
//
//   @override
//   _ChatCardState createState() => _ChatCardState();
// }
//
// class _ChatCardState extends State<ChatCard> {
//   late AppConfig _appConfig;
//   var _documents = [];
//
//
//   List<_TaskInfo>? _tasks;
//   late List<_ItemHolder> _items;
//   late bool _isLoading;
//   late bool _permissionReady;
//   late String _localPath;
//   ReceivePort _port = ReceivePort();
//   late final TargetPlatform? platform;
//   final String? title="download";
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
//   didChangeDependencies() {
//     platform = Theme.of(context).platform ;
//   }
//   @override
//   Widget build(BuildContext context) {
//     var extension = widget.item!.attachment!.split('.');
//     // platform = Theme.of(context).platform;
//
//     _appConfig= AppConfig(context);
//     return widget.item!.senderId=="1"?Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(width: 20,),
//           CircleAvatar(
//             backgroundImage: AssetImage(
//               'assets/images/user.png',
//             ),
//             maxRadius: 20,
//           ),
//           // SizedBox(
//           //   width: 10,
//           // ),
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//               padding: const EdgeInsets.all(10),
//               decoration:  BoxDecoration(
//                 color: AppConfig.whiteColor,
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     offset: Offset(0, 5),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child:                      widget.item!.attachment==""?Text("${widget.item!.msg}")
//                   :Container(
//                 width: _appConfig.rW(40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     extension[1]=="jpg"||extension[1]=="png"||extension[1]=="jpeg" ?Container(
//                         height: _appConfig.rH(35),
//                         width: _appConfig.rW(60),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle, color: Colors.green),
//                         child:
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           child: Image.network(
//                             "${AppConfig.srcLink}${widget.item!.attachment}",
//                             height: _appConfig.rH(1.5),
//                             width: _appConfig.rH(1.5),
//                             fit: BoxFit.fill,
//                           ),
//                         )):                  Container(
//                       padding: EdgeInsets.all(8),
//                       decoration:  BoxDecoration(
//                         color: AppConfig.queryBackground,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         // boxShadow: [
//                         //   BoxShadow(
//                         //     color: Colors.black12,
//                         //     offset: Offset(0, 5),
//                         //     blurRadius: 10,
//                         //   ),
//                         // ],
//                       ),
//                       child: Column(
//                         children: [
//                           Text("${widget.item!.attachment}",style: TextStyle(fontSize: AppConfig.f5),textScaleFactor: 1),
//                           Container(
//                             width: double.infinity,
//                             decoration:  BoxDecoration(
//                               color: AppConfig.shadeColor,
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               // boxShadow: [
//                               //   BoxShadow(
//                               //     color: Colors.black12,
//                               //     offset: Offset(0, 5),
//                               //     blurRadius: 10,
//                               //   ),
//                               // ],
//                             ),
//                             child: Icon(
//                               Icons.attachment_outlined,
//                               size: _appConfig.rW(7),
//                               color: AppConfig.queryBackground,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: _appConfig.rH(1),),
//                     Text("${widget.item!.msg}",style: TextStyle(fontSize: AppConfig.f4),textScaleFactor: 1),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text("${widget.item!.dateSent}",style: TextStyle(fontSize: AppConfig.f6),textScaleFactor: 1,)
//                       ],)
//
//                     // Text("Attachment${widget.item!.attachment}")
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     ):Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//               padding: const EdgeInsets.all(10),
//               decoration:  BoxDecoration(
//                 color: AppConfig.whiteColor,
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     offset: Offset(0, 5),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child:                      widget.item!.attachment==""?Text("${widget.item!.msg}")
//                   :Container(
//                 width: _appConfig.rW(40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     extension[1]=="jpg"||extension[1]=="png"||extension[1]=="jpeg" ?Container(
//                         height: _appConfig.rH(35),
//                         width: _appConfig.rW(60),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle, color: Colors.green),
//                         child:
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           child: Image.network(
//                             "${AppConfig.srcLink}${widget.item!.attachment}",
//                             height: _appConfig.rH(1.5),
//                             width: _appConfig.rH(1.5),
//                             fit: BoxFit.fill,
//                           ),
//                         )):                  Container(
//                       padding: EdgeInsets.all(8),
//                       decoration:  BoxDecoration(
//                         color: AppConfig.queryBackground,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         // boxShadow: [
//                         //   BoxShadow(
//                         //     color: Colors.black12,
//                         //     offset: Offset(0, 5),
//                         //     blurRadius: 10,
//                         //   ),
//                         // ],
//                       ),
//                       child: Column(
//                         children: [
//                           Text("${widget.item!.attachment}",style: TextStyle(fontSize: AppConfig.f5),textScaleFactor: 1),
//                           Container(
//                             width: double.infinity,
//                             decoration:  BoxDecoration(
//                               color: AppConfig.shadeColor,
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               // boxShadow: [
//                               //   BoxShadow(
//                               //     color: Colors.black12,
//                               //     offset: Offset(0, 5),
//                               //     blurRadius: 10,
//                               //   ),
//                               // ],
//                             ),
//                             child: Icon(
//                               Icons.attachment_outlined,
//                               size: _appConfig.rW(7),
//                               color: AppConfig.queryBackground,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: _appConfig.rH(1),),
//                     Text("${widget.item!.msg}",style: TextStyle(fontSize: AppConfig.f4),textScaleFactor: 1),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ListView(
//                           children: _items
//                               .map((item) => DownloadItem(
//                             data: item,
//                             onItemClick: (task) {
//                               _openDownloadedFile(task).then((success) {
//                                 if (!success) {
//                                   Scaffold.of(context).showSnackBar(SnackBar(
//                                       content: Text('Cannot open this file')));
//                                 }
//                               });
//                             },
//                             onActionClick: (task) {
//                               if (task.status == DownloadTaskStatus.undefined) {
//                                 _requestDownload(task);
//                               } else if (task.status == DownloadTaskStatus.running) {
//                                 _pauseDownload(task);
//                               } else if (task.status == DownloadTaskStatus.paused) {
//                                 _resumeDownload(task);
//                               } else if (task.status == DownloadTaskStatus.complete) {
//                                 _delete(task);
//                               } else if (task.status == DownloadTaskStatus.failed) {
//                                 _retryDownload(task);
//                               }
//                             },
//                           )).toList(),
//                         ),
//                         IconButton(
//                             onPressed: (){
//                               setState(() {
//                                 _documents[0]="${widget.item!.attachment}";
//                                 _documents[1]="${AppConfig.srcLink}${widget.item!.attachment}";
//                               });
//
//
//                             },
//                             icon: Icon(Icons.download,size: 40,)),
//                         Text("${widget.item!.dateSent}",style: TextStyle(fontSize: AppConfig.f6),textScaleFactor: 1,)
//                       ],)
//
//                     // Text("Attachment${widget.item!.attachment}")
//                   ],
//                 ),
//               )),
//         ],
//       ),
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
//     if (platform == TargetPlatform.android &&
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
//     //
//     // _tasks!.addAll(_images
//     //     .map((image) => _TaskInfo(name: image['name'], link: image['link'])));
//     //
//     // _items.add(_ItemHolder(name: 'Images'));
//     // for (int i = count; i < _tasks!.length; i++) {
//     //   _items.add(_ItemHolder(name: _tasks![i].name, task: _tasks![i]));
//     //   count++;
//     // }
//     //
//     // _tasks!.addAll(_videos
//     //     .map((video) => _TaskInfo(name: video['name'], link: video['link'])));
//     //
//     // _items.add(_ItemHolder(name: 'Videos'));
//     // for (int i = count; i < _tasks!.length; i++) {
//     //   _items.add(_ItemHolder(name: _tasks![i].name, task: _tasks![i]));
//     //   count++;
//     // }
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
//
// }
//







class ChatCard extends StatefulWidget  {
  final ConversationModel? item;
  const ChatCard({Key? key,this.item}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    var extension = widget.item!.attachment!.split('.');
    final platform = Theme.of(context).platform;

    _appConfig= AppConfig(context);

    return widget.item!.senderId=="1"?Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20,),
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/user.png',
            ),
            maxRadius: 15,
          ),
          // SizedBox(
          //   width: 10,
          // ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child:                      widget.item!.attachment==""?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("${widget.item!.msg}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                  SizedBox(height: _appConfig.rH(1),),

                  Text("${widget.item!.dateSent}",style: TextStyle(fontSize: AppConfig.f6,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)

                ],
              )
                  :Container(
                width: _appConfig.rW(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    extension[1]=="jpg"||extension[1]=="png"||extension[1]=="jpeg" ?InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageView(
                                  img: "${widget.item!.attachment}",
                                ),
                              ),
                        );
                      },
                      child: Container(
                          height: _appConfig.rH(35),
                          width: _appConfig.rW(60),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child:
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              "${AppConfig.srcLink}${widget.item!.attachment}",
                              height: _appConfig.rH(1.5),
                              width: _appConfig.rH(1.5),
                              fit: BoxFit.fill,
                            ),
                          )),
                    ):                  Container(
                      padding: EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                        color: AppConfig.queryBackground,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12,
                        //     offset: Offset(0, 5),
                        //     blurRadius: 10,
                        //   ),
                        // ],
                      ),
                      child: Column(
                        children: [
                          Text("${widget.item!.attachment}",style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                          Container(
                            width: double.infinity,
                            decoration:  BoxDecoration(
                              color: AppConfig.shadeColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black12,
                              //     offset: Offset(0, 5),
                              //     blurRadius: 10,
                              //   ),
                              // ],
                            ),
                            child: Icon(
                              Icons.attachment_outlined,
                              size: _appConfig.rW(7),
                              color: AppConfig.queryBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: _appConfig.rH(1),),
                    Text("${widget.item!.msg}",style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //                     ListView(
                        // children: _items
                        //     .map((item) => DownloadItem(
                        //   data: item,
                        //   onItemClick: (task) {
                        //     _openDownloadedFile(task).then((success) {
                        //       if (!success) {
                        //         Scaffold.of(context).showSnackBar(SnackBar(
                        //             content: Text('Cannot open this file')));
                        //       }
                        //     });
                        //   },
                        //   onActionClick: (task) {
                        //     if (task.status == DownloadTaskStatus.undefined) {
                        //       _requestDownload(task);
                        //     } else if (task.status == DownloadTaskStatus.running) {
                        //       _pauseDownload(task);
                        //     } else if (task.status == DownloadTaskStatus.paused) {
                        //       _resumeDownload(task);
                        //     } else if (task.status == DownloadTaskStatus.complete) {
                        //       _delete(task);
                        //     } else if (task.status == DownloadTaskStatus.failed) {
                        //       _retryDownload(task);
                        //     }
                        //   },
                        // )).toList(),
                        //                     ),
                        // IconButton(
                        //     onPressed: (){
                        //       // setState(() {
                        //       //   _documents[0]="${widget.item!.attachment}";
                        //       //   _documents[1]="${AppConfig.srcLink}${widget.item!.attachment}";
                        //       // });
                        //
                        //
                        //     },
                        //     icon: Icon(Icons.download,size: _appConfig.rH(3),)),
                        Text("${widget.item!.dateSent}",style: TextStyle(fontSize: AppConfig.f6,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                      ],)

                    // Text("Attachment${widget.item!.attachment}")
                  ],
                ),
              )),
        ],
      ),
    ):Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: AppConfig.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child:                      widget.item!.attachment==""?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("${widget.item!.msg}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                  SizedBox(height: _appConfig.rH(1),),

                  Text("${widget.item!.dateSent}",style: TextStyle(fontSize: AppConfig.f6,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)

                ],
              )
                  :widget.item!.attachment!=null? Container(
                width: _appConfig.rW(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    extension[1]=="jpg"||extension[1]=="png"||extension[1]=="jpeg" ?Container(
                        height: _appConfig.rH(35),
                        width: _appConfig.rW(60),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppConfig.carColor),
                        child:
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            "${AppConfig.srcLink}${widget.item!.attachment}",
                            height: _appConfig.rH(1.5),
                            width: _appConfig.rH(1.5),
                            fit: BoxFit.fill,
                          ),
                        )):                  Container(
                      padding: EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                        color: AppConfig.queryBackground,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black12,
                        //     offset: Offset(0, 5),
                        //     blurRadius: 10,
                        //   ),
                        // ],
                      ),
                          child: Column(
                            children: [
                              Text("${widget.item!.attachment}",style: TextStyle(fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                              Container(
                                width: double.infinity,
                                decoration:  BoxDecoration(
                                  color: AppConfig.shadeColor,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black12,
                                  //     offset: Offset(0, 5),
                                  //     blurRadius: 10,
                                  //   ),
                                  // ],
                                ),
                                child: Icon(
                                  Icons.attachment_outlined,
                                  size: _appConfig.rW(7),
                                  color: AppConfig.queryBackground,
                                ),
                              ),
                            ],
                          ),
                        ),
                    SizedBox(height: _appConfig.rH(1),),
                    Text("${widget.item!.msg}",style: TextStyle(fontSize: AppConfig.f4,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
    //                     ListView(
    // children: _items
    //     .map((item) => DownloadItem(
    //   data: item,
    //   onItemClick: (task) {
    //     _openDownloadedFile(task).then((success) {
    //       if (!success) {
    //         Scaffold.of(context).showSnackBar(SnackBar(
    //             content: Text('Cannot open this file')));
    //       }
    //     });
    //   },
    //   onActionClick: (task) {
    //     if (task.status == DownloadTaskStatus.undefined) {
    //       _requestDownload(task);
    //     } else if (task.status == DownloadTaskStatus.running) {
    //       _pauseDownload(task);
    //     } else if (task.status == DownloadTaskStatus.paused) {
    //       _resumeDownload(task);
    //     } else if (task.status == DownloadTaskStatus.complete) {
    //       _delete(task);
    //     } else if (task.status == DownloadTaskStatus.failed) {
    //       _retryDownload(task);
    //     }
    //   },
    // )).toList(),
    //                     ),
                        SizedBox(height:30,child: DownloadFile(platform: platform,name: "${widget.item!.attachment}",link: "${AppConfig.srcLink}${widget.item!.attachment}",)),
                        Text("${widget.item!.dateSent}",style: TextStyle(fontSize: AppConfig.f6,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                    ],)

                    // Text("Attachment${widget.item!.attachment}")
                ],
              ),
                  ):Center(child: CircularProgressIndicator(),)),
        ],
      ),
    );
  }
}
