import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/notification_pop_menu.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/DrawerScreens/ContactUs/message_sent.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/all_my_requests.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _name = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _message = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _email = TextEditingController();

  late AppConfig _appConfig;
  // File? selectedImage;
  // bool? isLoading = false;
  // late String encode = "";
  // // late XFile? image= null;
  // var image;
  final formKey = GlobalKey<FormState>();
  // late FToast fToast;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fToast = FToast();
  //   fToast.init(context);
  // }
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
      // backgroundColor: AppConfig.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(20)), // Set this height
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
                          NotificationPopUp(),
                          PopUp(),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Contact Us",
                    style: TextStyle(
                        fontSize: AppConfig.f2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),
                    textScaleFactor: 1,
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
                // height: _appConfig.rH(72),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    // color: AppConfig.whiteColor,
                    // borderRadius: const BorderRadius.only(
                    //     topRight: Radius.circular(30),
                    //     topLeft: Radius.circular(30))
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("Name",style: TextStyle(fontSize: AppConfig.f4,fontWeight: FontWeight.w500,fontFamily: AppConfig.fontFamilyRegular),),
                            TextFormField(
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Subhan',
                              ),
                              controller: _name,
                              validator: (String? name) {
                                if (name!.isEmpty) {
                                  return "field can't be empty!";
                                }
                                return null;
                              },
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   focusColor: AppConfig.tripColor,
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("subject",style: TextStyle(fontSize: AppConfig.f4,fontWeight: FontWeight.w500,fontFamily: AppConfig.fontFamilyRegular),),
                            TextFormField(
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText: 'abc',
                              ),
                              controller: _subject,
                              validator: (String? name) {
                                if (name!.isEmpty) {
                                  return "field can't be empty!";
                                }
                                return null;
                              },
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   focusColor: AppConfig.tripColor,
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                          decoration:InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Company',
                          ),
                          controller: _company,
                          validator: (String? name) {
                            if (name!.isEmpty) {
                              return "field can't be empty!";
                            }
                            return null;
                          },
                          // decoration: InputDecoration(
                          //   border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5),
                          //   ),
                          //   focusColor: AppConfig.tripColor,
                          // ),
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                          decoration:InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Message!',
                          ),
                          controller: _message,
                          validator: (String? name) {
                            if (name!.isEmpty) {
                              return "field can't be empty!";
                            }
                            return null;
                          },
                          maxLines: 8,
                          minLines: 1,
                          // decoration: InputDecoration(
                          //   border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(5),
                          //   ),
                          //   focusColor: AppConfig.tripColor,
                          // ),
                        ),
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Container(child: Text("$encode")),
                            TextButton(
                                onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                 Email email = Email(
                                  body: "Me ${_name.text},\nCompany: ${_company.text},\n\n${_message.text}",
                                  subject: _subject.text,
                                  recipients: ['ahmedsubhan741@gmail.com'],
                                  // cc: ['cc@example.com'],
                                  // bcc: ['bcc@example.com'],
                                  // attachmentPaths: ['/path/to/attachment.zip'],
                                  isHTML: false,
                                );

                                await FlutterEmailSender.send(email);
                                setState(() {
                                  _name.text ="";
                                  _subject.text = "";
                                  _email.text="";
                                  _message.text="";
                                  _company.text="";
                                });
                                // // showCustomToast();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => MessageSuccess()),
                                // );
                                // _subject.text = "";
                                // _description.text = "";
                                // _subject.clear();
                                // _description.clear();
                              }

                            }, child: Text("SEND",style: TextStyle(fontSize: AppConfig.f4,color: AppConfig.tripColor),)),
                            CircleAvatar(
                              radius: 20,
                              //   padding: EdgeInsets.symmetric(horizontal: 20),
                              child: IconButton(onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  Email email = Email(
                                    body: "Me ${_name.text},\nCompany: ${_company.text},\n\n${_message.text}",
                                    subject: _subject.text,
                                    recipients: ['ahmedsubhan741@gmail.com'],
                                    // cc: ['cc@example.com'],
                                    // bcc: ['bcc@example.com'],
                                    // attachmentPaths: ['/path/to/attachment.zip'],
                                    isHTML: false,
                                  );

                                  await FlutterEmailSender.send(email);
                                  setState(() {
                                    _name.text ="";
                                    _subject.text = "";
                                    _email.text="";
                                    _message.text="";
                                    _company.text="";
                                  });
                                  // // showCustomToast();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => MessageSuccess()),
                                  // );
                                  // _subject.text = "";
                                  // _description.text = "";
                                  // _subject.clear();
                                  // _description.clear();
                                }

                              },icon: Icon(Icons.email_outlined)),),
                            // Container(
                            //   child: CustomBtn(
                            //     "Send Request",
                            //     40,
                            //     AppConfig.hotelColor,
                            //     textSize: AppConfig.f3,
                            //     textColor: AppConfig.tripColor,
                            //     height: 50,
                            //     onPressed: ()  {
                            //       if (formKey.currentState!.validate()) {
                            //         WebServices.sendTicket(
                            //             _subject.text, _description.text, image);
                            //         setState(() {
                            //           _subject.text = "";
                            //           _description.text = "";
                            //           image = null;
                            //         });
                            //         showCustomToast();
                            //
                            //         // _subject.text = "";
                            //         // _description.text = "";
                            //         // _subject.clear();
                            //         // _description.clear();
                            //       }
                            //       // WebServices.uploadFile(_subject.text,encode,_description.text)
                            //       // Navigator.push(
                            //       //   context,
                            //       //  MaterialPageRoute(
                            //       //       builder: (context) => AllRequests(
                            //       //         products:
                            //       //         WebServices.getGetTickets(),
                            //       //       )),
                            //       // );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
  // showCustomToast() {
  //   Widget toast = Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25.0),
  //       color: AppConfig.shadeColor,
  //     ),
  //     child: Text("Ticket Sent",textScaleFactor: 1,),
  //   );
  //
  //   // fToast.showToast(
  //   //   child: toast,
  //   //   toastDuration: Duration(seconds: 3),
  //   // );
  // }

}
