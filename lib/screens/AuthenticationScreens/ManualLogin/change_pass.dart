import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/functions.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/services/services.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController passController = TextEditingController();
  late AppConfig _appConfig;
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();

  String? _password;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    _appConfig.statusBar();
    return Scaffold(
      backgroundColor: AppConfig.tripColor,

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
                                builder: (context) => LoginScreen()),
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
                    "Change Password",
                    style: TextStyle(
                        fontSize: AppConfig.f1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),textScaleFactor: 1,
                  ),
                ],
              )),
        ),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/traboon_logo.png",
                  height: _appConfig.rH(30),
                ),
                SizedBox(
                  height: _appConfig.rH(10),
                ),
            Stack(
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: TextFormField(
                    controller: passController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: AppConfig.fontFamilyRegular),
                    decoration: buildInputDecoration(
                      Icons.lock,
                      'Password',
                    ),
                    validator: (value) {

                      if (value!.isEmpty || value.length < 8 ) {
                        return "Password must be 8 character long";
                      }

                      return null;
                    },
                    onSaved: (val) => _password = val,
                    obscureText: _obscureText,

                  ),
                ),
                Positioned(
                  right: 10,
                  child: IconButton(
                      onPressed: _toggle,
                      // color: AppConfig.whiteColor,
                      icon: Icon(_obscureText ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_rounded)),
                )

              ],
            ),

                  // style: TextStyle(fontSize: AppConfig.f3),

                SizedBox(
                  height: 20,
                ),
                CustomBtn("Change Password",                         _appConfig.rW(8), AppConfig.hotelColor,textColor: AppConfig.tripColor,onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var email = prefs.getString('email');
    if (formKey.currentState!.validate()) {
       WebServices.updatePasswordItem(passController.text.trim(), email);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => LoginScreen()),
      );
    }
                },)
              ],
            ),
          ),
        ),
    );
  }
}
