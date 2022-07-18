import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/models/enquiry_ticket.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/request_chat.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/chat_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/change_alert_box.dart';
import 'package:untitled/services/services.dart';
import 'package:untitled/functions/upload_file.dart';

class AllRequests extends StatefulWidget {
  final Future<List<TicketModel>>? products;
  AllRequests({Key? key, this.products}) : super(key: key);
  @override
  _AllRequestsState createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
  late AppConfig _appConfig;

  List<TicketModel> allTickets = [];
  List<TicketModel> fileteredTickets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WebServices.getGetTickets().then((value) {
      setState(() {
        allTickets = value;
        fileteredTickets = allTickets;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return Scaffold(
      backgroundColor: AppConfig.tripColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(25)), // Set this height
        child: SafeArea(
          child: Container(
              height: _appConfig.rH(30),
              padding: EdgeInsets.only(
                  left: _appConfig.rWP(5),
                  right: _appConfig.rHP(5),
                  top: _appConfig.rWP(5),
                  bottom: _appConfig.rWP(5)),
              decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationScreen()),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          NotIcon(),
                          PopUp(),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "All Requests",
                    style: TextStyle(
                        fontSize: AppConfig.f2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppConfig.fontFamilyRegular
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
              (route) => false);
          return Future.value(false);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                height: _appConfig.rH(72),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: AppConfig.whiteColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            "My Requests",
                            style: TextStyle(
                                fontSize: AppConfig.f4,
                                fontWeight: FontWeight.w700,
                                color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                          ),
                        ),
                        Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppConfig.shadeColor),
                              color: AppConfig.whiteColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  color: AppConfig.queryBackground,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 50,
                                        color: AppConfig.whiteColor,
                                        child: CupertinoSearchTextField(
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: AppConfig.shadeColor,
                                            size: _appConfig.rH(3),
                                          ),
                                          onChanged: (String) {
                                            setState(() {
                                              fileteredTickets = allTickets
                                                  .where((element) => (element
                                                      .issue!
                                                      .toLowerCase()
                                                      .contains(String
                                                          .toLowerCase())))
                                                  .toList();
                                            });
                                          },
                                          backgroundColor: AppConfig.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(
                                          //     borderRadius:
                                          //         BorderRadius.circular(5),
                                          //   ),
                                          //   focusColor: AppConfig.tripColor,
                                          //   hintText: 'Search',
                                          //
                                          //   // labelText: 'Hey! We care about what you like or not!',
                                          //   // alignLabelWithHint: true,
                                          // ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text("Status: ",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                                          Container(
                                            width: 100,
                                            height: 50,
                                            color: AppConfig.whiteColor,
                                            child: CupertinoSearchTextField(
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: AppConfig.shadeColor,
                                                size: _appConfig.rH(3),
                                              ),
                                              onChanged: (String) {
                                                setState(() {
                                                  fileteredTickets = allTickets
                                                      .where((element) => (element
                                                          .status!
                                                          .toLowerCase()
                                                          .contains(String
                                                              .toLowerCase())))
                                                      .toList();
                                                });
                                              },
                                              backgroundColor:
                                                  AppConfig.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              // decoration: InputDecoration(
                                              //   border: OutlineInputBorder(
                                              //     borderRadius:
                                              //         BorderRadius.circular(5),
                                              //   ),
                                              //   focusColor: AppConfig.tripColor,
                                              //   hintText: 'Search',
                                              //
                                              //   // labelText: 'Hey! We care about what you like or not!',
                                              //   // alignLabelWithHint: true,
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Id",
                                        style: TextStyle(
                                            color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Subject",
                                          style: TextStyle(
                                              color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Text("Created",
                                              style: TextStyle(
                                                  color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Status",
                                          style: TextStyle(
                                              color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 15,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: _appConfig.rH(35),
                                  child: FutureBuilder<List<TicketModel>>(
                                    future: widget.products,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError)
                                        print(snapshot.error);
                                      return snapshot.hasData
                                          ? TicketItems(
                                              items: fileteredTickets,
                                            )

                                          // return the ListView widget :
                                          : Center(
                                              child:
                                                  CircularProgressIndicator());
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class RequestCard extends StatefulWidget with WidgetsBindingObserver {
  final TargetPlatform? platform;
  final TicketModel? item;
  RequestCard({Key? key, this.item, this.platform}) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {

  var notiCountRequest;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkNoti("${widget.item!.id}");
  }
  checkNoti(ticketId) async {
    List<String> item=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await WebServices.productsNotiEnquiry(ticketId).first.then((categories) {
      // if (prefs.containsKey('notification_enquiry_count')) {
      //   oldEnquiryCount = prefs.getInt('notification_enquiry_count')!;
      // }
      // _categories = categories;
      categories. forEach((element){
        item.add("${element.notiCount}");
        // print("${element.title}");
      });

      print("request in enquiry ${item.first}item");
      setState(() {
        notiCountRequest = item.first;

      });
      // print("list of items ${enquiryItems.first}}");
    });  }



  late AppConfig _appConfig;

  bool value = false;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    var extension = widget.item!.file!.split('.');
    final platform = Theme.of(context).platform;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: RequestChat(
                    ticketId: "${widget.item!.id}",
                  ))),
        );
      },
      child: widget.item!.file != ""
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Row(
                      children: [
                        Text("${widget.item!.id}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),),
                        notiCountRequest!=null?Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: notiCountRequest!=0?Text(
                            '${notiCountRequest}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ):Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ):SizedBox(),
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("${widget.item!.issue}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("${widget.item!.date}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 25,
                      padding: EdgeInsets.all(_appConfig.rH(0.2)),
                      // width: 50,
                      color: AppConfig.carColor,
                      child: Center(child: Text("${widget.item!.status}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                    ),
                  ],
                ),
                SizedBox(
                  height: _appConfig.rW(1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
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
                        child: widget.item!.file!=null?Container(
                          width: _appConfig.rW(40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              extension[1] == "jpg" ||
                                      extension[1] == "png" ||
                                      extension[1] == "jpeg"
                                  ? Container(
                                      height: _appConfig.rH(35),
                                      width: _appConfig.rW(70),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConfig.carColor),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                          "${AppConfig.srcLink}${widget.item!.file}",
                                          height: _appConfig.rH(1.5),
                                          width: _appConfig.rH(1.5),
                                          fit: BoxFit.fill,
                                        ),
                                      ))
                                  : Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppConfig.queryBackground,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                          Text("${widget.item!.file}",
                                              style: TextStyle(
                                                  fontSize: AppConfig.f5,fontFamily: AppConfig.fontFamilyRegular),
                                              textScaleFactor: 1),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppConfig.shadeColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
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
                              SizedBox(
                                height: _appConfig.rH(1),
                              ),
                              SizedBox(
                                height: 30,
                                child: DownloadFile(platform: platform,name: "${widget.item!.file}",link: "${AppConfig.srcLink}${widget.item!.file}",),
                              ),
                              // SizedBox(
                              //     height: 100,
                              //     child: Builder(
                              //         builder: (context) => _isLoading
                              //             ? new Center(
                              //           child: new CircularProgressIndicator(),
                              //         )
                              //             : _permissionReady
                              //             ? _buildDownloadList()
                              //             : _buildNoPermissionWarning()),),

                              Text("Attachment${widget.item!.file}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))
                            ],
                          ),
                        ):Center(child: CircularProgressIndicator(),)),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppConfig.textColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ))),
                        onPressed: widget.item!.status == "pending"
                            ? () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return StatusUpdateDialogBox(
                                        titleText: "Status Update",
                                        description:
                                            "Status has been updated Successfully!",
                                        onPressed: () {
                                          setState(() {
                                            WebServices.sendTicketStatus(
                                                "${widget.item!.id}");
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllRequests(
                                                        products: WebServices
                                                            .getGetTickets(),
                                                      )),
                                            );
                                          });
                                        },
                                      );
                                    });
                              }
                            : () {},
                        child: Text("Approve",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular)),),
                  ],
                ),
                Divider(
                  height: 25,
                  thickness: 1,
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Row(
                      children: [
                        Text("${widget.item!.id}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular)),
                        notiCountRequest!=null?Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: notiCountRequest!=0?Text(
                            '${notiCountRequest}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ):Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ):SizedBox(),

                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("${widget.item!.issue}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("${widget.item!.date}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 25,
                      padding: EdgeInsets.all(_appConfig.rH(0.2)),
                      // width: 50,
                      color: AppConfig.carColor,
                      child: Center(child: Text("${widget.item!.status}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppConfig.textColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: widget.item!.status == "pending"
                        ? () {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return StatusUpdateDialogBox(
                                    titleText: "Status Update",
                                    description:
                                        "Status has been updated Successfully!",
                                    onPressed: () {
                                      setState(() {
                                        WebServices.sendTicketStatus(
                                            "${widget.item!.id}");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AllRequests(
                                                    products: WebServices
                                                        .getGetTickets(),
                                                  )),
                                        );
                                      });
                                    },
                                  );
                                });
                          }
                        : () {},
                    child: Text("Approve",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular))),
                Divider(
                  height: 25,
                  thickness: 1,
                ),
              ],
            ),
    );
  }





}




class TicketItems extends StatelessWidget {
  final List<TicketModel>? items;
  var ticketId;
  TicketItems({Key? key, this.items, this.ticketId});
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: items!.length,
        itemBuilder: (context, index) {
          return RequestCard(item: items![index]);
        },
      ),
    );
  }
}
