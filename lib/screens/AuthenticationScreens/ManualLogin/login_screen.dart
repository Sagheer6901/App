import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_dialog.dart';
import 'package:untitled/functions/functions.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/routes.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/goog_signin_btn.dart';
import 'package:untitled/screens/AuthenticationScreens/GoogleAuth/google_auth.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/change_pass.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/forget_pass.dart';
import 'package:untitled/screens/AuthenticationScreens/ManualLogin/signup_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';
import 'package:untitled/services/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AppConfig _appConfig;
  // String? passVal="";

  bool changeButtton = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  UserProfile userProfile = UserProfile();

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var url = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_profile&user_email=$email");
    var response = await http.get(url);
    setState(() {
      print("Hello  $response");
      final jsonresponse = json.decode(response.body);

      userProfile = UserProfile.fromJson(jsonresponse[0]);
      // userProfile = UserProfile.fromJson(json.decode(response.body));
      print(userProfile);
    });
    prefs.setString("id", userProfile.id.toString());
    prefs.setString("name", userProfile.name.toString());
  }
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: size.height / 1.7,
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
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image(
                          alignment: Alignment.topCenter,
                          image:
                              const AssetImage('assets/images/trabooncom.png'),
                          height: size.height / 2.3,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          child: TextFormField(
                            controller: userPass,
                            keyboardType: TextInputType.text,
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
                            // obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ).p8(),
                  SizedBox(
                    height: 10,
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
                              WebServices.login(userEmail.text, userPass.text)
                                  .then((value) async {
                                if (value == 'pass_err') {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        title: 'Error',
                                        subtitle: 'Invalid Password',
                                        primaryAction: () {
                                          Navigator.pop(context);
                                        },
                                        primaryActionText: 'Okay',
                                      );
                                    },);
                                } else if (value == 'email_err') {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(
                                          title: 'Error',
                                          subtitle:
                                          'Email not found in our database!',
                                          primaryAction: () {
                                            Navigator.pop(context);
                                          },
                                          primaryActionText: 'Okay',
                                        );
                                      });
                                }


                                print("response: $value");
                                if (value == "login_success") {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('email', userEmail.text);
                                  fetchData();

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => NavigationScreen()),
                                  );
                                }
                              });       });

                          }


                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.yellow),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, MyRoutes.forgetPass);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MaterialApp(        debugShowCheckedModeBanner: false,
                                home: ForgetPass())),
                      );
                    },
                    child: Text(
                      'Forget Your Password?',
                      style:
                          TextStyle(fontSize: 12, color: AppConfig.whiteColor),
                    ),
                  ),
                  Center(
                    child: Text(
                      'or connect with',
                      style: TextStyle(
                          color: AppConfig.whiteColor,
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
                            width: 120,
                            child: SignInButton(Buttons.Facebook,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                text: 'FaceBook', onPressed: () async {
                              final result = await FacebookAuth.i.login(
                                  permissions: ["public_profile", "email"]);

                              if (result.status == LoginStatus.success) {
                                final userData =
                                    await FacebookAuth.i.getUserData(
                                  fields: "email,name",
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyBlogs()),
                                );
                                setState(() {
                                  _appConfig.userData = userData;
                                });
                              }
                            }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Dont have an Account? ',
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: Colors.yellow),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
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
