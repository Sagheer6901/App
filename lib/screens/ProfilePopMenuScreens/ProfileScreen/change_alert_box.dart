
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/completion_alert_box.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/text_field.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/ProfileScreen/profile_screen.dart';
import 'package:untitled/services/services.dart';


class NameChangeDialogBox extends StatefulWidget {
  final String? oldText;
  final String? newText;
  final String? confirmText;
  final String? titleText;
  final String? description;
  final TextInputType? inputType;
  final Function()? onPressed;


  NameChangeDialogBox(
      {this.titleText,
      this.oldText,
      this.newText,
      this.confirmText,
      this.inputType,
      this.description,
        this.onPressed,
      });

  @override
  _NameChangeDialogBoxState createState() => _NameChangeDialogBoxState();
}

class _NameChangeDialogBoxState extends State<NameChangeDialogBox> {
  // final TextEditingController _oldController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  // final TextEditingController _confirmController = TextEditingController();
  bool changeButtton = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppConfig.whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: AppConfig.shadeColor,
                    offset: Offset(0, 10),
                    blurRadius: 10,),
              ],),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.titleText.toString(),
                    style: TextStyle(
                        fontSize: AppConfig.f2,
                        fontWeight: FontWeight.bold,),
                  ),
                  // CustomTextField(
                  //   text: widget.oldText,
                  //   controller: _oldController,
                  //   validator: (String? name) {
                  //     if (name!.isEmpty) {
                  //       return "Name can't be empty!";
                  //     }
                  //     return null;
                  //   },
                  //   inputType: TextInputType.text,
                  //   verticalMargin: 10,
                  // ),
                  CustomTextField(
                    text: widget.newText,
                    controller: _newController,
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return "Name can't be empty!";
                      }
                      return null;
                    },
                    inputType: TextInputType.text,
                    verticalMargin: 10,
                  ),
                  // CustomTextField(
                  //   text: widget.confirmText,
                  //   controller: _confirmController,
                  //   validator: (String? name) {
                  //     if (name!.isEmpty) {
                  //       return "Name can't be empty!";
                  //     }
                  //     return null;
                  //   },
                  //   inputType: TextInputType.text,
                  //   verticalMargin: 10,
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20.0, left: 40.0, right: 40.0, bottom: 0.0,),
                    child: CustomBtn(
                        'Update',60,AppConfig.hotelColor,textColor: AppConfig.tripColor,
                        iconName: Icons.update,
                        onPressed: ()  async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var email = prefs.getString('email');
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              changeButtton = true;
                            });
                            setState(()  {

                              var val;
                              WebServices.updateNameItem(_newController.text, email)
                                  .then((value) async {
                                print("response: $value");
                                if (value == "name_change_success") {
                              setState(() {
                              UserProfile().name=_newController.text;
                              val =value;
                              });

                                }
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Profile()),
                              );

    });
                          }

                          // print("resposonse fsfsdf ${_oldController.text}");
                          // var val;
                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                          // var email = prefs.getString('email');
                          // WebServices.updateNameItem(_newController.text, email).
                          // then((value) {
                          //   print("response: $value");
                          //   val = value;
                          //   // Profile(userName: _newController.text,);
                          //   // setState(() {
                          //   //   // Profile().name = _newController.text;
                          //   //   print(_newController.text);
                          //   // });
                          //   // if (value == "name_change_success") {
                          //   //   Navigator.of(context).pushReplacement(
                          //   //     MaterialPageRoute(
                          //   //         builder: (context) => Profile()),
                          //   //   );
                          //   // }
                          // });
                          // setState(() {
                          //   UserProfile().name=_newController.text;
                          // });
                          //   Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //         builder: (context) => Profile()),
                          //   );

                        },
                        // onPressed: () {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext ctx) {
                        //         return CompletionAlertBox(
                        //           description: widget.description,
                        //           iconName: Icons.arrow_back,
                        //           buttonText: "Back",
                        //           title: widget.titleText,
                        //           onPressed: () {
                        //               Navigator.push(context, MaterialPageRoute(
                        //                   builder: (BuildContext context) {
                        //                     return Profile();
                        //                   }
                        //               ),);
                        //           },
                        //         );
                        //       },);
                        // }
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}















class AccountChangeDialogBox extends StatefulWidget {
  final String? oldText;
  final String? newText;
  final String? confirmText;
  final String? titleText;
  final String? description;
  final TextInputType? inputType;
  final Function()? onPressed;


  AccountChangeDialogBox(
      {this.titleText,
        this.oldText,
        this.newText,
        this.confirmText,
        this.inputType,
        this.description,
        this.onPressed,
      });

  @override
  _AccountChangeDialogBoxState createState() => _AccountChangeDialogBoxState();
}

class _AccountChangeDialogBoxState extends State<AccountChangeDialogBox> {
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool changeButtton = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppConfig.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig.shadeColor,
                offset: Offset(0, 10),
                blurRadius: 10,),
            ],),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.titleText.toString(),
                    style: TextStyle(
                      fontSize: AppConfig.f2,
                      fontWeight: FontWeight.bold,),
                  ),
                  CustomTextField(
                    text: widget.oldText,
                    controller: _oldController,
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return "Name can't be empty!";
                      }
                      return null;
                    },
                    inputType: TextInputType.text,
                    verticalMargin: 10,
                  ),
                  CustomTextField(
                    text: widget.newText,
                    controller: _newController,
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return "Name can't be empty!";
                      }
                      return null;
                    },
                    inputType: TextInputType.text,
                    verticalMargin: 10,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     top: 20.0, left: 40.0, right: 40.0, bottom: 0.0,),
                  //   child: CustomBtn(
                  //     'Send OTP',60,AppConfig.hotelColor,textColor: AppConfig.tripColor,
                  //     iconName: Icons.update,
                  //     onPressed: ()  async {
                  //       SharedPreferences prefs = await SharedPreferences.getInstance();
                  //       var email = prefs.getString('email');
                  //       if (formKey.currentState!.validate()) {
                  //         setState(() {
                  //           changeButtton = true;
                  //         });
                  //         setState(()  {
                  //
                  //           var val;
                  //           WebServices.streamUpdateEmailItem( email,_newController.text,otp)
                  //               .then((value) async {
                  //             print("response: $value");
                  //             if (value == "name_change_success") {
                  //               setState(() {
                  //                 UserProfile().name=_newController.text;
                  //                 val =value;
                  //               });
                  //
                  //             }
                  //           });
                  //           Navigator.of(context).pushReplacement(
                  //             MaterialPageRoute(
                  //                 builder: (context) => Profile()),
                  //           );
                  //
                  //         });
                  //       }
                  //
                  //       // print("resposonse fsfsdf ${_oldController.text}");
                  //       // var val;
                  //       // SharedPreferences prefs = await SharedPreferences.getInstance();
                  //       // var email = prefs.getString('email');
                  //       // WebServices.updateNameItem(_newController.text, email).
                  //       // then((value) {
                  //       //   print("response: $value");
                  //       //   val = value;
                  //       //   // Profile(userName: _newController.text,);
                  //       //   // setState(() {
                  //       //   //   // Profile().name = _newController.text;
                  //       //   //   print(_newController.text);
                  //       //   // });
                  //       //   // if (value == "name_change_success") {
                  //       //   //   Navigator.of(context).pushReplacement(
                  //       //   //     MaterialPageRoute(
                  //       //   //         builder: (context) => Profile()),
                  //       //   //   );
                  //       //   // }
                  //       // });
                  //       // setState(() {
                  //       //   UserProfile().name=_newController.text;
                  //       // });
                  //       //   Navigator.of(context).pushReplacement(
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => Profile()),
                  //       //   );
                  //
                  //     },
                  //     // onPressed: () {
                  //     //   showDialog(
                  //     //       context: context,
                  //     //       builder: (BuildContext ctx) {
                  //     //         return CompletionAlertBox(
                  //     //           description: widget.description,
                  //     //           iconName: Icons.arrow_back,
                  //     //           buttonText: "Back",
                  //     //           title: widget.titleText,
                  //     //           onPressed: () {
                  //     //               Navigator.push(context, MaterialPageRoute(
                  //     //                   builder: (BuildContext context) {
                  //     //                     return Profile();
                  //     //                   }
                  //     //               ),);
                  //     //           },
                  //     //         );
                  //     //       },);
                  //     // }
                  //   ),
                  // ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}







class ContactChangeDialogBox extends StatefulWidget {
  final String? oldText;
  final String? newText;
  final String? confirmText;
  final String? titleText;
  final String? description;
  final TextInputType? inputType;
  final Function()? onPressed;


  ContactChangeDialogBox(
      {this.titleText,
        this.oldText,
        this.newText,
        this.confirmText,
        this.inputType,
        this.description,
        this.onPressed,
      });

  @override
  _ContactChangeDialogBoxState createState() => _ContactChangeDialogBoxState();
}

class _ContactChangeDialogBoxState extends State<ContactChangeDialogBox> {
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppConfig.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig.shadeColor,
                offset: Offset(0, 10),
                blurRadius: 10,),
            ],),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.titleText.toString(),
                  style: TextStyle(
                    fontSize: AppConfig.f2,
                    fontWeight: FontWeight.bold,),
                ),
                CustomTextField(
                  text: widget.oldText,
                  controller: _oldController,
                  validator: (String? name) {
                    if (name!.isEmpty) {
                      return "Name can't be empty!";
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                  verticalMargin: 10,
                ),
                CustomTextField(
                  text: widget.newText,
                  controller: _newController,
                  validator: (String? name) {
                    if (name!.isEmpty) {
                      return "Name can't be empty!";
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                  verticalMargin: 10,
                ),
                CustomTextField(
                  text: widget.confirmText,
                  controller: _confirmController,
                  validator: (String? name) {
                    if (name!.isEmpty) {
                      return "Name can't be empty!";
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                  verticalMargin: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 0.0,),
                  child: CustomBtn(
                    'Update',60,AppConfig.hotelColor,textColor: AppConfig.tripColor,
                    iconName: Icons.update,
                    onPressed: (){
                      print("resposonse fsfsdf ${_oldController.text}");
                      var val;
                      WebServices.updateContactItem(_newController.text,"1").then((value) {
                        print("response: $value");
                        val = value;
                        // Profile(userName: _newController.text,);
                        // setState(() {
                        //   // Profile().name = _newController.text;
                        //   print(_newController.text);
                        // });
                        if (value == "name_change_success") {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => Profile()),
                          );
                        }
                      });
                      setState(() {
                        // UserProfile().name=_newController.text;
                      });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => Profile()),
                        );

                    },
                    // onPressed: () {
                    //   showDialog(
                    //       context: context,
                    //       builder: (BuildContext ctx) {
                    //         return CompletionAlertBox(
                    //           description: widget.description,
                    //           iconName: Icons.arrow_back,
                    //           buttonText: "Back",
                    //           title: widget.titleText,
                    //           onPressed: () {
                    //               Navigator.push(context, MaterialPageRoute(
                    //                   builder: (BuildContext context) {
                    //                     return Profile();
                    //                   }
                    //               ),);
                    //           },
                    //         );
                    //       },);
                    // }
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}







class PasswordChangeDialogBox extends StatefulWidget {
  final String? oldText;
  final String? newText;
  final String? confirmText;
  final String? titleText;
  final String? description;
  final String? oldPass;
  final TextInputType? inputType;
  final Function()? onPressed;


  PasswordChangeDialogBox(
      {this.titleText,
        this.oldText,
        this.newText,
        this.confirmText,
        this.inputType,
        this.oldPass,
        this.description,
        this.onPressed,
      });

  @override
  _PasswordChangeDialogBoxState createState() => _PasswordChangeDialogBoxState();
}

class _PasswordChangeDialogBoxState extends State<PasswordChangeDialogBox> {
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool changeButtton = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppConfig.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig.shadeColor,
                offset: Offset(0, 10),
                blurRadius: 10,),
            ],),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.titleText.toString(),
                    style: TextStyle(
                      fontSize: AppConfig.f2,
                      fontWeight: FontWeight.bold,),
                  ),
                  CustomTextField(
                    text: widget.oldText,
                    controller: _oldController,
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return "field can't be empty!";
                      }
                      else if(widget.oldPass != _oldController.text){
                        return "Incorrect password";

                      }
                      return null;
                    },
                    inputType: TextInputType.visiblePassword,
                    verticalMargin: 10,
                  ),
                  CustomTextField(
                    text: widget.newText,
                    controller: _newController,
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return "field can't be empty!";
                      }
                      return null;
                    },
                    inputType: TextInputType.visiblePassword,
                    verticalMargin: 10,
                  ),
                  CustomTextField(
                    text: widget.confirmText,
                    controller: _confirmController,
                    validator: (String? name) {
                      if (name!.isEmpty) {
                        return "field can't be empty!";
                      }
                      else if(_confirmController.text !=_newController.text){
                        return "password does not match!";

                      }
                      return null;
                    },
                    inputType: TextInputType.visiblePassword,
                    verticalMargin: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.0, left: 40.0, right: 40.0, bottom: 0.0,),
                    child: CustomBtn(
                      'Update',60,AppConfig.hotelColor,textColor: AppConfig.tripColor,
                      iconName: Icons.update,
                      onPressed: () async {

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var email = prefs.getString('email');
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            changeButtton = true;
                          });
                          setState(()  {

                            WebServices.updatePasswordItem(_newController.text,email).
                                then((value) async {
                              print("response: $value");
                              if (value == "pass_change_success") {
                                setState(() {
                                  UserProfile().password=_newController.text;
                                });

                              }
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );

                          });
                        }

                        //
                        //
                        // print("resposonse fsfsdf ${_oldController.text}");
                        // var val;
                        // WebServices.updatePasswordItem(_newController.text,"sometwo@example.com").then((value) {
                        //   print("response: $value");
                        //   val = value;
                        //   // Profile(userName: _newController.text,);
                        //   // setState(() {
                        //   //   // Profile().name = _newController.text;
                        //   //   print(_newController.text);
                        //   // });
                        //   if (value == "name_change_success") {
                        //     Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) => Profile()),
                        //     );
                        //   }
                        // });
                        // setState(() {
                        //   UserProfile().password=_newController.text;
                        // });
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //         builder: (context) => Profile()),
                        //   );

                      },
                      // onPressed: () {
                      //   showDialog(
                      //       context: context,
                      //       builder: (BuildContext ctx) {
                      //         return CompletionAlertBox(
                      //           description: widget.description,
                      //           iconName: Icons.arrow_back,
                      //           buttonText: "Back",
                      //           title: widget.titleText,
                      //           onPressed: () {
                      //               Navigator.push(context, MaterialPageRoute(
                      //                   builder: (BuildContext context) {
                      //                     return Profile();
                      //                   }
                      //               ),);
                      //           },
                      //         );
                      //       },);
                      // }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}






class AddressChangeDialogBox extends StatefulWidget {
  final String? oldText;
  final String? newText;
  final String? confirmText;
  final String? titleText;
  final String? description;
  final String? oldPass;
  final TextInputType? inputType;
  final Function()? onPressed;


  AddressChangeDialogBox(
      {this.titleText,
        this.oldText,
        this.newText,
        this.confirmText,
        this.inputType,
        this.oldPass,
        this.description,
        this.onPressed,
      });

  @override
  _AddressChangeDialogBoxState createState() => _AddressChangeDialogBoxState();
}

class _AddressChangeDialogBoxState extends State<AddressChangeDialogBox> {
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool changeButtton = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppConfig.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig.shadeColor,
                offset: Offset(0, 10),
                blurRadius: 10,),
            ],),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.titleText.toString(),
                    style: TextStyle(
                      fontSize: AppConfig.f2,
                      fontWeight: FontWeight.bold,),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hoverColor: AppConfig.tripColor,
                        focusColor: AppConfig.tripColor,
                      ),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(30),
                      ],
                      controller:_newController,
                      validator:  (String? name) {
                        if (name!.isEmpty) {
                          return "field can't be empty!";
                        }
                        return null;
                      },
                      // maxLines: 1,
                    ),
                  ),
                  // CustomTextField(
                  //   text: widget.newText,
                  //   controller: _newController,
                  //   validator: (String? name) {
                  //     if (name!.isEmpty) {
                  //       return "field can't be empty!";
                  //     }
                  //     return null;
                  //   },
                  //   inputType: TextInputType.visiblePassword,
                  //   verticalMargin: 10,
                  // ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20.0, left: 40.0, right: 40.0, bottom: 0.0,),
                    child: CustomBtn(
                      'Update',60,AppConfig.hotelColor,textColor: AppConfig.tripColor,
                      iconName: Icons.update,
                      onPressed: () async {


                        if (formKey.currentState!.validate()) {
                          setState(() {
                            changeButtton = true;
                          });
                          setState(()  {

                            WebServices.updateAddressItem(_newController.text).
                            then((value) async {
                              print("response: $value");
                              if (value == "address_change_success") {
                                setState(() {
                                  UserProfile().address=_newController.text;
                                });

                              }
                            });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );

                          });
                        }

                        //
                        //
                        // print("resposonse fsfsdf ${_oldController.text}");
                        // var val;
                        // WebServices.updatePasswordItem(_newController.text,"sometwo@example.com").then((value) {
                        //   print("response: $value");
                        //   val = value;
                        //   // Profile(userName: _newController.text,);
                        //   // setState(() {
                        //   //   // Profile().name = _newController.text;
                        //   //   print(_newController.text);
                        //   // });
                        //   if (value == "name_change_success") {
                        //     Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) => Profile()),
                        //     );
                        //   }
                        // });
                        // setState(() {
                        //   UserProfile().password=_newController.text;
                        // });
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //         builder: (context) => Profile()),
                        //   );

                      },
                      // onPressed: () {
                      //   showDialog(
                      //       context: context,
                      //       builder: (BuildContext ctx) {
                      //         return CompletionAlertBox(
                      //           description: widget.description,
                      //           iconName: Icons.arrow_back,
                      //           buttonText: "Back",
                      //           title: widget.titleText,
                      //           onPressed: () {
                      //               Navigator.push(context, MaterialPageRoute(
                      //                   builder: (BuildContext context) {
                      //                     return Profile();
                      //                   }
                      //               ),);
                      //           },
                      //         );
                      //       },);
                      // }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}






class StatusUpdateDialogBox extends StatefulWidget {
  final String? oldText;
  final String? newText;
  final String? confirmText;
  final String? titleText;
  final String? description;
  final TextInputType? inputType;
  final Function()? onPressed;


  StatusUpdateDialogBox(
      {this.titleText,
        this.oldText,
        this.newText,
        this.confirmText,
        this.inputType,
        this.description,
        this.onPressed,
      });

  @override
  _StatusUpdateDialogBoxState createState() => _StatusUpdateDialogBoxState();
}

class _StatusUpdateDialogBoxState extends State<StatusUpdateDialogBox> {


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppConfig.whiteColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig.shadeColor,
                offset: Offset(0, 10),
                blurRadius: 10,),
            ],),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.titleText.toString(),
                  style: TextStyle(
                    fontSize: AppConfig.f2,
                    fontWeight: FontWeight.bold,),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0, left: 40.0, right: 40.0, bottom: 0.0,),
                  child: CustomBtn(
                    'Update',50,AppConfig.hotelColor,textColor: AppConfig.tripColor,
                    iconName: Icons.update,
                    onPressed: widget.onPressed
                    // onPressed: () {
                    //   showDialog(
                    //       context: context,
                    //       builder: (BuildContext ctx) {
                    //         return CompletionAlertBox(
                    //           description: widget.description,
                    //           iconName: Icons.arrow_back,
                    //           buttonText: "Back",
                    //           title: widget.titleText,
                    //           onPressed: () {
                    //               Navigator.push(context, MaterialPageRoute(
                    //                   builder: (BuildContext context) {
                    //                     return Profile();
                    //                   }
                    //               ),);
                    //           },
                    //         );
                    //       },);
                    // }
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}