import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/notification_pop_menu.dart';
import 'package:untitled/functions/popup_menu.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/screens/DrawerScreens/CustomerSupport/all_my_requests.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  TextEditingController _subject = TextEditingController();
  TextEditingController _description = TextEditingController();
  late AppConfig _appConfig;
  File? selectedImage;
  bool? isLoading = false;
  late String encode = "";
  // late XFile? image= null;
  var image;
  final formKey = GlobalKey<FormState>();
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
      // backgroundColor: AppConfig.White,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(20)), // Set this height
        child: SafeArea(
          child: Container(
              // height: _appConfig.rH(30),
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
                    "Customer Support",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Subject",
                              style: TextStyle(
                                  fontSize: AppConfig.f4,
                                  fontWeight: FontWeight.w700,
                                  color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: TextFormField(
                              controller: _subject,
                              validator: (String? name) {
                                if (name!.isEmpty) {
                                  return "field can't be empty!";
                                }
                                return null;
                              },
                              maxLines: 2,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusColor: AppConfig.tripColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: AppConfig.f4,
                                  fontWeight: FontWeight.w700,
                                  color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: TextFormField(
                              controller: _description,
                              validator: (String? name) {
                                if (name!.isEmpty) {
                                  return "field can't be empty!";
                                }
                                return null;
                              },
                              maxLines: 5,
                              minLines: 2,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusColor: AppConfig.tripColor,
                                hintText:
                                    'Hey! We care about what you like or not!',

                                // labelText: 'Hey! We care about what you like or not!',
                                // alignLabelWithHint: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      InkWell(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          setState(() {
                            isLoading = true;
                          });
                          image = await FilePicker.platform.pickFiles();

                          // if (image != null) {
                          //   // Now we're converting our image into Uint8List
                          //   Uint8List bytes = await image.readAsBytes();
                          //
                          //   // Here we're converting our image to Base64
                          //   encode = base64Encode(bytes);
                          //
                          //   // Returning Base64 Encoded Image
                          //   // return encode;
                          // }
                          // else {
                          //   if (kDebugMode) {
                          //     print('Pick Image First');
                          //   }
                          //   return 'Error';
                          // }
                          setState(() {
                            isLoading = false;
                            // selectedImage = File(image!.path);
                          });
                        },
                        child: Container(
                          // height: 100.0,
                          // width: 100.0,
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.circle, color: Colors.green),
                          child: (selectedImage == null)
                              ? Container(
                                  margin: EdgeInsets.all(15),
                                  height: 40,
                                  width: _appConfig.rW(40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppConfig.shadeColor,
                                  ),
                                  child: image == null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.attachment_outlined,
                                              size: 20,
                                              color: AppConfig.whiteColor,
                                            ),
                                            Text(
                                              'Attach Files',
                                              style: TextStyle(
                                                color: AppConfig.whiteColor,
                                                fontSize: AppConfig.f5,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.attachment_outlined,
                                              size: 30,
                                              color: AppConfig.carColor,
                                            ),
                                            Text(
                                              'Attachment Attached',
                                              style: TextStyle(
                                                color: AppConfig.tripColor,
                                                fontSize: AppConfig.f4,
                                              ),
                                            ),
                                          ],
                                        ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     // color: AppConfig.shadeColor,
                                    //     offset: Offset(0, 5),
                                    //     blurRadius: 10,
                                    //   ),
                                    // ],
                                  ),
                                  height: 150,
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image.file(
                                        File(
                                          selectedImage!.path,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(child: Text("$encode")),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllRequests(
                                              products:
                                                  WebServices.getGetTickets(),
                                            )),
                                  );
                                },
                                child: Text("View Previous enquiries",style: TextStyle(fontFamily: AppConfig.fontFamilyRegular),)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: CustomBtn(
                              "Send",
                              25,
                              AppConfig.hotelColor,
                              textSize: AppConfig.f3,
                              textColor: AppConfig.tripColor,
                              height: 50,
                              onPressed: ()  {
                                if (formKey.currentState!.validate()) {
                                   WebServices.sendTicket(
                                      _subject.text, _description.text, image);
                                  setState(() {
                                    _subject.text = "";
                                    _description.text = "";
                                    image = null;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        title: 'Message',
                                        subtitle: 'Thank you for submitting your enquiry ,Team Traboon is looking at the issue, we will get back to you',
                                        primaryAction: () {
                                          // Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => AllRequests(
                                                  products:
                                                  WebServices.getGetTickets(),
                                                )),
                                          );
                                        },
                                        primaryActionText: 'Okay',
                                      );
                                    },);
                                  // showCustomToast();

                                  // _subject.text = "";
                                  // _description.text = "";
                                  // _subject.clear();
                                  // _description.clear();
                                }
                                // WebServices.uploadFile(_subject.text,encode,_description.text)
                                // Navigator.push(
                                //   context,
                                //  MaterialPageRoute(
                                //       builder: (context) => AllRequests(
                                //         products:
                                //         WebServices.getGetTickets(),
                                //       )),
                                // );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
  showCustomToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppConfig.shadeColor,
      ),
      child: Text("Ticket Sent",textScaleFactor: 1,),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 3),
    );
  }

}
