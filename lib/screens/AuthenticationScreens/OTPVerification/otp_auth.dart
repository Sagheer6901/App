import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/functions.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/screens/AuthenticationScreens/OTPVerification/otp_verification.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/profile_screen.dart';
import 'package:untitled/services/services.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OTPAuth extends StatefulWidget {
  @override
  _OTPAuthState createState() => _OTPAuthState();
}

class _OTPAuthState extends State<OTPAuth> {
  late AppConfig _appConfig;

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print(email);
    WebServices.updateContactItem(phoneController.text,"1").then((value) {
      print("response: $value");
    });
    setState(() {
      UserProfile().contact=phoneController.text;
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Profile()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    _appConfig = AppConfig(context);

    var phoneNumber;
    return Column(
      children: [
        Spacer(),
        IntlPhoneField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          onChanged: (phone) {
            phoneNumber=phone.countryCode;
            print(phone.completeNumber);
          },
          onCountryChanged: (country) {
            print('Country changed to: ' + country.name);
          },
        ),
        SizedBox(
          height: 20,
        ),
        // TextField(
        //   decoration: InputDecoration(
        //     hintText: "Phone Number",
        //   ),
        // ),
        // SizedBox(
        //   height: 16,
        // )
        CustomBtn(
          "Send",
          _appConfig.rW(6),
          AppConfig.hotelColor,
          textColor: AppConfig.tripColor,
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: "${phoneNumber}${phoneController.text}",
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState!.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message!)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          textSize: AppConfig.f5,
        ),

        // FlatButton(
        //   onPressed: () async {
        //     setState(() {
        //       showLoading = true;
        //     });
        //
        //     await _auth.verifyPhoneNumber(
        //       phoneNumber: "${phoneNumber}${phoneController.text}",
        //       verificationCompleted: (phoneAuthCredential) async {
        //         setState(() {
        //           showLoading = false;
        //         });
        //         //signInWithPhoneAuthCredential(phoneAuthCredential);
        //       },
        //       verificationFailed: (verificationFailed) async {
        //         setState(() {
        //           showLoading = false;
        //         });
        //         _scaffoldKey.currentState!.showSnackBar(
        //             SnackBar(content: Text(verificationFailed.message!)));
        //       },
        //       codeSent: (verificationId, resendingToken) async {
        //         setState(() {
        //           showLoading = false;
        //           currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
        //           this.verificationId = verificationId;
        //         });
        //       },
        //       codeAutoRetrievalTimeout: (verificationId) async {},
        //     );
        //   },
        //   child: Text("SEND"),
        //   color: Colors.blue,
        //   textColor: Colors.white,
        // ),

        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          decoration: buildInputDecoration(

            Icons.domain_verification,
            'Enter OTP',
          ),
        ),
        SizedBox(
          height: 16,
        ),
        CustomBtn(
          'Update',_appConfig.rW(6),AppConfig.hotelColor,textColor: AppConfig.tripColor,
          iconName: Icons.update,
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);

          },
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transperent or set your own color
        )
    );
    _appConfig = AppConfig(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
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
                                    builder: (context) => Profile()),
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
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.notifications_none,
                          //       size: 30,
                          //       color: Colors.white,
                          //     ),
                          //     PopUp(),
                          //   ],
                          // ),
                        ],
                      ),
                      Text(
                        "Verify Contact",
                        style: TextStyle(
                            fontSize: AppConfig.f2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,fontFamily: AppConfig.fontFamilyMedium),textScaleFactor: 1,
                      ),
                    ],
                  )),
            ),
          ),
          // backgroundColor: AppConfig.tripColor,

          key: _scaffoldKey,
          body: Container(
            child: showLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                    ? getMobileFormWidget(context)
                    : getOtpFormWidget(context),
            padding: const EdgeInsets.all(16),
          )),
    );
  }
}















