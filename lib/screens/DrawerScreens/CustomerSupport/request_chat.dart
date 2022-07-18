import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/conversation_model.dart';
import 'package:untitled/models/ticket_conv_model.dart';
import 'package:untitled/screens/DrawerScreens/Queries/SendingQuery/image_view.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';

class RequestChat extends StatefulWidget {
  final String? ticketId;
  const RequestChat({Key? key,this.ticketId}) : super(key: key);

  @override
  _RequestChatState createState() => _RequestChatState();
}

class _RequestChatState extends State<RequestChat> {
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
    updateSupportStatus();
    setState(() {
      oldEnquiryCount=0;
    });
    fToast = FToast();
    fToast.init(context);
  }
  updateSupportStatus(){
    WebServices.addCustomersupportNotStatus("${widget.ticketId}");

  }

  @override
  Widget build(BuildContext context) {
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
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/user.png',
                          ),
                          maxRadius: 30,
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
                  child: StreamBuilder<List<TicketConvModel>>(
                    stream: WebServices.productsStreamConv("${widget.ticketId}"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? ConvList(items: snapshot.data)

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
                              WebServices.sentConv(widget.ticketId,toSendString);
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

}







class ConvList extends StatefulWidget {
  final List<TicketConvModel>? items;
  ConvList({Key? key, this.items});

  @override
  State<ConvList> createState() => _ConvListState();
}

class _ConvListState extends State<ConvList> {
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
          return ConvCard(item: widget.items![index]);
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

class ConvCard extends StatefulWidget  {
  final TicketConvModel? item;
  const ConvCard({Key? key,this.item}) : super(key: key);

  @override
  _ConvCardState createState() => _ConvCardState();
}

class _ConvCardState extends State<ConvCard> {
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    // var extension = widget.item!.attachment!.split('.');
    // platform = Theme.of(context).platform;

    _appConfig= AppConfig(context);
    return widget.item!.sender=="1"?Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20,),
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/user.png',
            ),
            maxRadius: 20,
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
              child:                      Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("${widget.item!.message}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular)),
                  SizedBox(height: _appConfig.rH(1),),

                  Text("${widget.item!.sentAt}",style: TextStyle(fontSize: AppConfig.f6,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)

                ],
              )
                ),
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
              child:                     Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("${widget.item!.message}",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular)),
                  SizedBox(height: _appConfig.rH(1),),

                  Text("${widget.item!.sentAt}",style: TextStyle(fontSize: AppConfig.f6,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)

                ],
              )),
        ],
      ),
    );
  }
}
