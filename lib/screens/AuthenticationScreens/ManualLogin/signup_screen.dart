import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/functions.dart';
import 'package:untitled/models/Authentication/register.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/goog_signin_btn.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/google_auth.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/login_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/services/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpScreen> {
  bool changeButtton = false;
  final formKey = GlobalKey<FormState>();

  late AppConfig _appConfig;

  TextEditingController userEmail = TextEditingController();
  TextEditingController userFirstName = TextEditingController();
  TextEditingController userLastName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  TextEditingController userContact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: _appConfig.rH(60),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/Untitled-15.png'),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                ),
              ),
            ),
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: _appConfig.rH(30),
                    width: _appConfig.rW(30),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/trabooncom.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                                controller: userFirstName,
                                keyboardType: TextInputType.emailAddress,
                                decoration: buildInputDecoration(
                                  Icons.face_outlined,
                                  'First name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter first name';
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,
                                bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                                controller: userLastName,
                                keyboardType: TextInputType.emailAddress,
                                decoration: buildInputDecoration(
                                  Icons.face_retouching_natural,
                                  'Last name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter last name';
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                              controller: userEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: buildInputDecoration(
                                Icons.email,
                                'Enter email',
                              ),
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Email can\'t be empty!';
                                } else if (!(email.contains('@'))) {
                                  return 'Please enter a valid email!';
                                } else if (!(email.contains('.com'))) {
                                  return 'Please enter a valid email!';
                                }
                                return null;
                              },
                              // validator: (email) =>
                              //     email != null && !EmailValidator.validate(email)
                              //         ? 'Enter a valid email'
                              //         : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                              controller: userContact,
                              keyboardType: TextInputType.number,
                              decoration: buildInputDecoration(
                                Icons.phone_android_outlined,
                                'Mobile number',
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 11) {
                                  return "Enter mobile number";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                              controller: userPass,
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration(
                                Icons.lock,
                                'Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 8) {
                                  return "Password must be 8 character long";
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                              controller: confirmPass,
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration(
                                Icons.lock,
                                'Confirm Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 8 && confirmPass.text ==userPass.text) {
                                  return "Invalid confirm Password";
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              changeButtton = true;
                            });
                            setState(() {
                              WebServices.register(userFirstName.text,userLastName.text,userEmail.text,userPass.text,userContact.text,null).then((value) async {
                                print("response: $value");
                                if (value == "register_success") {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('email', userEmail.text);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => NavigationScreen()),
                                  );
                                }
                              });                        });
                          }
                          // register();

                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppConfig.hotelColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'or connect with',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(
                            future: Authentication.initializeFirebase(
                                context: context),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error initializing Firebase');
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return GoogleSignInButton();
                              }
                              return CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppConfig.carColor,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              height: 30,
                              width: 125,
                              child: SignInButton(
                                Buttons.Facebook,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                text: 'FaceBook',
                                onPressed: () {},
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already have account',
                              ),
                              TextSpan(
                                text: '  Login',
                                style: TextStyle(color: Colors.yellow),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
