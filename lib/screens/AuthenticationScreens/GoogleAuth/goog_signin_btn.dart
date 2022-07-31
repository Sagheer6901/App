import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/google_auth.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return _isSigningIn
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        : SizedBox(
            height: 30,
            width: 120,
            child: SignInButton(
              Buttons.Email,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              text: 'Google',
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('email', user.email.toString());
                  prefs.setString("name", user.displayName.toString());
                  prefs.setString('profileUrl', user.photoURL.toString());
                  setState(() {
                    WebServices.register(user.displayName,"",user.email,"",user.phoneNumber,user.photoURL).then((value) async {
                      print("value of signup : ${value.toString()}");
                      print("response: ${user.photoURL.toString()}");
                      if (value == "register_success") {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('email', user.email.toString());
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => NavigationScreen()),
                        );
                      }
                      else if(value=="Duplicate entry 'sagheerrajper619@gmail.com' for key 'email'"){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: 'User',
                                subtitle: 'Already Exist!',
                                primaryAction: () {
                                  Navigator.pop(context);
                                },
                                primaryActionText: 'Okay',
                              );
                            });
                      }
                    });
                  });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => NavigationScreen(),
                  )
                  );
                }
              },
            ),
          );
  }
}
