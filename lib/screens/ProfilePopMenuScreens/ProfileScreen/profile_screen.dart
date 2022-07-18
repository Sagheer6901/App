import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/date_range_picker.dart';
import 'package:untitled/functions/drawer.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/forget_pass.dart';
import 'package:untitled/screens/AuthenticationScreens/OTPVerification/otp_verification.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/change_alert_box.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/email_verification.dart';
import 'package:untitled/services/services.dart';

class Profile extends StatefulWidget {
  // final UserProfile? item;
  // final Future<List<UserProfile>>? products;
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? selectedImage;
  bool isLoading = false;
  late AppConfig _appConfig;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  UserProfile userProfile = UserProfile();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print("email $email");
    var url = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_profile&user_email=$email");

    var response = await http.get(url);
    setState(() {
      print("Hello  ${response.body}");
      final jsonresponse = json.decode(response.body);
      userProfile = UserProfile.fromJson(jsonresponse[0]);
      isLoading = false;
    });
    prefs.setString("profileImage", userProfile.image.toString());
    prefs.setString("id", userProfile.id.toString());
    prefs.setString("name", userProfile.name.toString());
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 60),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    setState(() {
      var birthday = "${newDate!.year}-${newDate.month}-${newDate.day}";
      WebServices.updateBirthdayItem(birthday, email).then((value) {
        print("response: $value");
      });
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
  }
  // RefreshController _refreshController =
  // RefreshController(initialRefresh: false);


//   SmartRefresher(
//   enablePullDown: true,
//   enablePullUp: true,
//   controller: _refreshController,
//   onRefresh: () async {
//   fetchData();
//   await Future.delayed(Duration(milliseconds: 1000));
//   // if failed,use refreshFailed()
//   _refreshController.refreshCompleted();
// },
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    // final String? birthDay = widget.formatter!.format(userProfile.date!);

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appConfig.rH(37)), // Set this height
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // background image and bottom contents
              Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      color: AppConfig.tripColor,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(_appConfig.rW(100), 250.0)),
                    ),
                    height: _appConfig.rH(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: _appConfig.rWP(5),
                              vertical: _appConfig.rHP(5)),
                          child: InkWell(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 25,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavigationScreen()),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: userProfile.name != null
                                ? FittedBox(
                                    child: Text(
                                      "${userProfile.name}",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: AppConfig.fontFamilyBold,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                : Text(
                                    "--",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Profile image
              Positioned(
                top: 150.0, // (background container size) - (circle height / 2)
                child: selectedImage == null
                    ? InkWell(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          setState(() {
                            isLoading = true;
                          });
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            isLoading = false;
                            selectedImage = File(image!.path);
                          });
                          await WebServices.uploadProfileImage(image);
                          fetchData();
                          if (selectedImage != null) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          }
                        },
                        child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConfig.carColor),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              child: userProfile.image != null
                                  ? Image.network(
                                      userProfile.image
                                              .toString()
                                              .contains("http")
                                          ? "${userProfile.image}"
                                          : "${AppConfig.srcLink}${userProfile.image}",
                                      height: _appConfig.rH(30),
                                      width: _appConfig.rW(30),
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Text(
                                      "--",
                                      style: TextStyle(fontSize: AppConfig.f3),
                                    )),
                            )),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                              Radius.circular(100),
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
              )
            ],
          ),
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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppConfig.carColor),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      // height: 150,
                      //alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              child: userProfile.otpPhoneStatus == "1"
                                  ? Text(
                                "Account Verified",
                                style: TextStyle(
                                    color: AppConfig.carColor,
                                    fontSize: AppConfig.f4,
                                    fontFamily: AppConfig.fontFamilyBold),
                              )
                                  : Text(
                                "Verify your phone number!",
                                style: TextStyle(
                                    color: AppConfig.textColor,
                                    fontSize: AppConfig.f4,
                                    fontFamily: AppConfig.fontFamilyMedium),
                              ),
                              onTap: userProfile.otpPhoneStatus != "1"
                                  ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InitializerWidget()),
                                );
                              }
                                  : () {},
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.supervised_user_circle_outlined),
                                  Row(
                                    children: <Widget>[
                                      userProfile.name != null
                                          ? Text(
                                        "${userProfile.name}",
                                        style: TextStyle(
                                            fontSize: AppConfig.f4,
                                            fontFamily:
                                            AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                      )
                                          : Text(
                                        "--",
                                        style: TextStyle(
                                            fontSize: AppConfig.f4),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppConfig.tripColor,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return NameChangeDialogBox(
                                                  titleText: "CHANGE USER NAME",
                                                  oldText: "Old User Name",
                                                  newText: "New User Name",
                                                  confirmText:
                                                  "Confirm User Name",
                                                  description:
                                                  "Your User Name has been updated Successfully!",
                                                );
                                              });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.cake_outlined),
                                  ButtonHeaderWidget(
                                      text: "${userProfile.date}",
                                      // text: formatter.format(userProfile.date),
                                      // text: '${userProfile.date!.year}-${userProfile.date!.month}-${userProfile.date!.day}',
                                      onClicked: () {
                                        pickDate(context);
                                      })
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.mobile_friendly),
                                  Row(
                                    children: <Widget>[
                                      userProfile.contact == null ||
                                          userProfile.contact == 'null'
                                          ? Text(
                                        "Add Contact Number",
                                        style: TextStyle(
                                            fontSize: AppConfig.f4,
                                            fontFamily:
                                            AppConfig.fontFamilyRegular),
                                        textScaleFactor: 1,
                                      )
                                          : Text("${userProfile.contact}",
                                          style: TextStyle(fontSize: AppConfig.f4, fontFamily: AppConfig.fontFamilyRegular),
                                          textScaleFactor: 1),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppConfig.tripColor,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InitializerWidget()),
                                            );
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (BuildContext ctx) {
                                            //       return ContactChangeDialogBox(
                                            //         titleText: "CHANGE Contact",
                                            //         oldText: "Old Contact",
                                            //         newText: "New Contact",
                                            //         confirmText: "Confirm Contact",
                                            //         description:
                                            //             "Your Contact has been updated Successfully!",
                                            //       );
                                            //     });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.email_outlined),
                                  Row(
                                    children: <Widget>[
                                      userProfile.email != null
                                          ? Text(
                                        "${userProfile.email}",
                                        style: TextStyle(
                                            fontSize: AppConfig.f5,
                                            fontFamily:
                                            AppConfig.fontFamilyRegular),
                                        textScaleFactor: 1,
                                      )
                                          : Text(
                                        "--",
                                        style: TextStyle(
                                            fontSize: AppConfig.f4),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                      ),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.edit,
                                      //     color: AppConfig.tripColor,
                                      //   ),
                                      //   onPressed: () {
                                      //     showDialog(
                                      //         context: context,
                                      //         builder: (BuildContext ctx) {
                                      //           return NameChangeDialogBox(
                                      //             titleText: "CHANGE USER NAME",
                                      //             oldText: "Old User Name",
                                      //             newText: "New User Name",
                                      //             confirmText: "Confirm User Name",
                                      //             description:
                                      //             "Your User Name has been updated Successfully!",
                                      //           );
                                      //         });
                                      //   },
                                      // ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppConfig.tripColor,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return VerifyEmail();
                                                }),
                                          );
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext ctx) {
                                          //       return AccountChangeDialogBox(
                                          //         titleText: "CHANGE EMAIL",
                                          //         oldText: "Old Email",
                                          //         newText: "New Email",
                                          //         confirmText: "Confirm Email",
                                          //         description:
                                          //             "Your Email has been updated Successfully!",
                                          //       );
                                          //     });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.password),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "********",
                                        style: TextStyle(
                                            fontSize: AppConfig.f4,
                                            fontFamily:
                                            AppConfig.fontFamilyRegular),
                                        textScaleFactor: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppConfig.tripColor,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return PasswordChangeDialogBox(
                                                  titleText: "CHANGE PASSWORD",
                                                  oldText: "Old Password",
                                                  newText: "New Password",
                                                  confirmText: "Confirm Password",
                                                  oldPass:
                                                  "${userProfile.password}",
                                                  description:
                                                  "Your Password has been updated Successfully!",
                                                );
                                              });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.add_location_alt_outlined),
                                  Row(
                                    children: <Widget>[
                                      // userProfile.address!.isEmpty  || userProfile.address!= null || userProfile.address!= "null"?
                                      FittedBox(
                                        child: Text(
                                          "${userProfile.address}",
                                          style: TextStyle(
                                              fontSize: AppConfig.f5,
                                              fontFamily:
                                              AppConfig.fontFamilyRegular),
                                          textScaleFactor: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppConfig.tripColor,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return AddressChangeDialogBox(
                                                  titleText: "CHANGE ADDRESS",
                                                  newText: "User Address",
                                                  description:
                                                  "Your address has been updated Successfully!",
                                                );
                                              });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            // CustomBtn("Edit Profile", 60, AppConfig.hotelColor,height: 40,textColor: AppConfig.tripColor,textSize: AppConfig.f3,)
                          ],
                        )),
                  ],
                )),
      ),
    );
  }
}
