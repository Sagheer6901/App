import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/functions/completion_alert_box.dart';
import 'package:untitled/functions/preferred_size_appbar.dart';
import 'package:untitled/functions/text_field.dart';
import 'package:untitled/screens/NavigationScreens/Cart/cart_screen.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/webview.dart';

import '../../DrawerScreens/PaymentScreens/payment_methods.dart';

enum PaymentsMethods { paypal, jazzcash, easypaisa, easypaisa_card ,nomethod}

class CheckOut extends StatefulWidget {
  String? title, name, type,bookingType, img;
  var orderIds,orderTypes;
  var id, contact, checkIn, checkOut, orderId, price, totalPrice, days;
  CheckOut(
      {Key? key,
      this.name,
      this.contact,
      this.type,
        this.bookingType,
      this.img,
      this.id,
      this.title,
      this.checkIn,
      this.checkOut,
      this.orderId,
        this.orderIds,
        this.orderTypes,
      this.price,
      this.days,
      this.totalPrice})
      : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  PaymentsMethods _method = PaymentsMethods.nomethod;
  var method;
  late AppConfig _appConfig;
  // print("$amount,$storeId,$orderId, $postBackURL, $paymentMethod,$paymentMethod, $email, $contact, $mercahnt");
  String? amount,
      storeId,
      orderId,
      pbUrl,
      payMethod,
      email,
      contact,
      merchant,
      transactionURl1;
  List<String> checkOutDetails = [];
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(_appConfig.rH(15)), // Set this height
          child: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: _appConfig.rWP(5), vertical: _appConfig.rHP(5)),
                decoration: BoxDecoration(
                    color: AppConfig.tripColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppConfig.whiteColor,
                        size: _appConfig.rH(3),
                      ),
                    ),
                    Text(
                      "Checkout",
                      style: TextStyle(
                          fontSize: AppConfig.f2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textScaleFactor: 1,
                    ),
                    Container()
                  ],
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  right: 30,
                  left: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConfig.f2,
                          color: AppConfig.tripColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "This will help to book your services even faster",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name ",
                        style: TextStyle(
                            fontSize: AppConfig.f4,
                            fontWeight: FontWeight.w300,
                            color: AppConfig.whiteColor),
                      ),
                      Text("Contact ",
                          style: TextStyle(
                              fontSize: AppConfig.f4,
                              fontWeight: FontWeight.w300,
                              color: AppConfig.whiteColor))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.name}",
                          style: TextStyle(
                              fontSize: AppConfig.f3,
                              fontWeight: FontWeight.w500,
                              color: AppConfig.whiteColor)),
                      widget.contact!=null?Text("${widget.contact}",
                          style: TextStyle(
                              fontSize: AppConfig.f3,
                              fontWeight: FontWeight.w500,
                              color: AppConfig.whiteColor)):SizedBox(),

                      // Image(
                      //   image: AssetImage(
                      //       "assets/images/easypaisa.png"),
                      //   width: 40,
                      //   height: 50,
                      // ),
                    ],
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black12,
                    //         offset: Offset(0, 5),
                    //         blurRadius: 10,
                    //       ),
                    //     ],
                    //   ),
                    //   margin: EdgeInsets.all(10),
                    //   padding: EdgeInsets.all(20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Image(
                    //             image: AssetImage(
                    //                 "assets/images/mastercard.png"),
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text("Paypal"),
                    //         ],
                    //       ),
                    //       Radio(value: PaymentsMethods.paypal, groupValue: _method, onChanged: (PaymentsMethods? value){
                    //         setState(() {
                    //           _method=value!;
                    //         });
                    //       })
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.all(Radius.circular(20)),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black12,
                    //         offset: Offset(0, 5),
                    //         blurRadius: 10,
                    //       ),
                    //     ],
                    //   ),
                    //   padding: EdgeInsets.all(20),
                    //   margin: EdgeInsets.all(10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Image(
                    //             image: AssetImage(
                    //                 "assets/images/jazzcash.png"),
                    //             width: 30,
                    //             height: 30,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Text("Jazzcash"),
                    //         ],
                    //       ),
                    //       Radio(value: PaymentsMethods.jazzcash, groupValue: _method, onChanged: (PaymentsMethods? value){
                    //         setState(() {
                    //           _method=value!;
                    //         });
                    //       })
                    //     ],
                    //   ),
                    // ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image:
                                    AssetImage("assets/images/easypaisa.png"),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Easypaisa Mobile"),
                            ],
                          ),
                          Radio(
                              value: PaymentsMethods.easypaisa,
                              groupValue: _method,
                              onChanged: (PaymentsMethods? value) {
                                setState(() {
                                  _method = value!;
                                  method = "easypaisa";
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image:
                                    AssetImage("assets/images/easypaisa.png"),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Easypaisa Card"),
                            ],
                          ),
                          Radio(
                              value: PaymentsMethods.easypaisa_card,
                              groupValue: _method,
                              onChanged: (PaymentsMethods? value) {
                                setState(() {
                                  _method = value!;
                                  method = "card";
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image:
                                    AssetImage("assets/images/easypaisa.png"),
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Paypal"),
                            ],
                          ),
                          Radio(
                              value: PaymentsMethods.paypal,
                              groupValue: _method,
                              onChanged: (PaymentsMethods? value) {
                                setState(() {
                                  _method = value!;
                                  method = "paypal";
                                });
                              })
                        ],
                      ),
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              child: Image.network(
                                "${widget.img}",
                                height: _appConfig.rH(17),
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${widget.title}",
                                  style: TextStyle(
                                      fontFamily: AppConfig.fontFamilyMedium,
                                      fontSize: AppConfig.f4))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          widget.checkIn != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Start Date:",
                                      style: TextStyle(
                                          fontFamily:
                                              AppConfig.fontFamilyRegular,
                                          fontSize: AppConfig.f4),
                                      textScaleFactor: 1,
                                    ),
                                    Text(
                                      "${widget.checkIn}",
                                      style: TextStyle(
                                          fontFamily:
                                              AppConfig.fontFamilyRegular,
                                          fontSize: AppConfig.f4),
                                      textScaleFactor: 1,
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          widget.checkIn != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "End Date:",
                                      style: TextStyle(
                                          fontFamily:
                                              AppConfig.fontFamilyRegular,
                                          fontSize: AppConfig.f4),
                                      textScaleFactor: 1,
                                    ),
                                    Text(
                                      "${widget.checkOut}",
                                      style: TextStyle(
                                          fontFamily:
                                              AppConfig.fontFamilyRegular,
                                          fontSize: AppConfig.f4),
                                      textScaleFactor: 1,
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          widget.checkIn != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    widget.type != "hotel"
                                        ? Text(
                                            "Price Per Day:",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConfig.fontFamilyRegular,
                                                fontSize: AppConfig.f4),
                                            textScaleFactor: 1,
                                          )
                                        : Text(
                                            "Price Per Night:",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConfig.fontFamilyRegular,
                                                fontSize: AppConfig.f4),
                                            textScaleFactor: 1,
                                          ),
                                    Text(
                                      "${widget.price}",
                                      style: TextStyle(
                                          fontFamily:
                                              AppConfig.fontFamilyRegular,
                                          fontSize: AppConfig.f4),
                                      textScaleFactor: 1,
                                    )
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 5,
                          ),
                          widget.checkIn != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    widget.type != "hotel"
                                        ? Text(
                                            "Days:",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConfig.fontFamilyRegular,
                                                fontSize: AppConfig.f4),
                                            textScaleFactor: 1,
                                          )
                                        : Text(
                                            "Nights:",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConfig.fontFamilyRegular,
                                                fontSize: AppConfig.f4),
                                            textScaleFactor: 1,
                                          ),
                                    Text(
                                      "${widget.days}",
                                      style: TextStyle(
                                          fontFamily:
                                              AppConfig.fontFamilyRegular,
                                          fontSize: AppConfig.f4),
                                      textScaleFactor: 1,
                                    )
                                  ],
                                )
                              : SizedBox(),
                          widget.checkIn != null
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total:",
                                style: TextStyle(
                                    fontFamily: AppConfig.fontFamilyMedium,
                                    fontSize: AppConfig.f3),
                                textScaleFactor: 1,
                              ),
                              Text(
                                "${widget.totalPrice}",
                                style: TextStyle(
                                    fontFamily: AppConfig.fontFamilyMedium,
                                    fontSize: AppConfig.f3),
                                textScaleFactor: 1,
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text("Shipping Information ",style: TextStyle(fontSize: AppConfig.f4, fontWeight: FontWeight.w400, color: AppConfig.tripColor),),
                    //           Text("Edit",style: TextStyle(fontSize: AppConfig.f5, fontWeight: FontWeight.w300, color: AppConfig.tripColor))
                    //         ],
                    //       ),
                    //       SizedBox(height: _appConfig.rH(1),),
                    //       Text("product",style: TextStyle(fontSize: AppConfig.f5, color: AppConfig.textColor),),
                    //       SizedBox(height: _appConfig.rH(1),),
                    //       Text("product",style: TextStyle(fontSize: AppConfig.f5, color: AppConfig.textColor),),
                    //       SizedBox(height: _appConfig.rH(1),),
                    //       Text("product",style: TextStyle(fontSize: AppConfig.f5, color: AppConfig.textColor),),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Total",style: TextStyle(fontSize: AppConfig.f3, color: AppConfig.tripColor),),
                    //       Text("\$730",style: TextStyle(fontSize: AppConfig.f3, color: AppConfig.tripColor),),
                    //
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomBtn(
                      "Pay",
                      40,
                      AppConfig.hotelColor,
                      textSize: AppConfig.f4,
                      textColor: AppConfig.tripColor,
                      height: 40,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var eamil = prefs.getString("email");
    if (widget.bookingType == "car" || widget.bookingType == "hotel" || widget.bookingType == "guide") {
      if (method == 'card' || method == "easypaisa") {




        await WebServices.easypaisform(
            "$method",
            "${widget.totalPrice}",
            "${widget.orderId}",
            "$eamil",
            "${widget.contact}",
            "${widget.bookingType}")
            .then((value) {
          print(value);
          // checkOutDetails = value;
          for (var element in value) {
            amount = element.amount;
            storeId = element.storeId;
            pbUrl = element.postBackUrl;
            orderId = element.orderRefNum;
            payMethod = element.paymentMethod;
            email = element.emailAddr;
            contact = element.mobileNum;
            merchant = element.merchantHashedReq;
            transactionURl1 = element.transactionPostUrl1;
          }
          // print(checkOutDetails);
        });
        // print(checkOutDetails);
        var url;
        await WebServices.easypaisaAuthToken(
            "$transactionURl1",
            "$amount",
            "$storeId",
            "$orderId",
            "$pbUrl",
            "$payMethod",
            "$email",
            "$contact",
            "$merchant")
            .then((value) {
          url = value;
          print("url : $url");
        });
        var authToken;
        await WebServices.easypaisaGetLastData(url)
            .then((value) {
          for (var element in value) {
            pbUrl = element.postBackURL2;
            pbUrl = "${pbUrl}&booking_type=${widget.bookingType}";
            transactionURl1 = element.transactionPostURL2;
            authToken = element.authToken;
          }
        });
        // await WebServices.easypaisaConfirm(transactionURl1,pbUrl,authToken).then((value) {
        //   url = value;
        // });

        print(" ordersss ${widget.orderTypes} ${widget.orderIds}");
        setState(() {
          print(
              "url2: $transactionURl1?postBackURL=$pbUrl&auth_token=$authToken");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewExample(
                    pMethod: "$method",
                    type: "${widget.bookingType}",
                    orderIds: "${widget.orderId}",
                    ordersId: "${widget.orderIds}",
                    orderTypes:"${widget.orderTypes}",
                    totalAmount: "${widget.totalPrice}",
                    url:
                    '$transactionURl1?postBackURL=$pbUrl&auth_token=$authToken',
                  )));
        });
      }
      else if (method == 'paypal') {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewExample(
                  pMethod: "$method",
                  type: "${widget.bookingType}",
                  orderIds:"${widget.orderId}",
                  totalAmount: "${widget.totalPrice}",
                  url:
                  'https://mobicell.net/Yaseo/paypal-payment/first.php?order_id=${widget.orderId}&&price=${widget.totalPrice}',
                )));
      }
    }
    else{
      if (method == 'card' || method == "easypaisa") {
        await WebServices.easypaisform(
            "$method",
            "${widget.totalPrice}",
            "${widget.orderIds}",
            "$eamil",
            "${widget.contact}",
            "${widget.bookingType}")
            .then((value) {
          print(value);
          // checkOutDetails = value;
          for (var element in value) {
            amount = element.amount;
            storeId = element.storeId;
            pbUrl = element.postBackUrl;
            orderId = element.orderRefNum;
            payMethod = element.paymentMethod;
            email = element.emailAddr;
            contact = element.mobileNum;
            merchant = element.merchantHashedReq;
            transactionURl1 = element.transactionPostUrl1;
          }
          // print(checkOutDetails);
        });
        // print(checkOutDetails);
        var url;
        await WebServices.easypaisaAuthToken(
            "$transactionURl1",
            "$amount",
            "$storeId",
            "${widget.orderIds}",
            "$pbUrl",
            "$payMethod",
            "$email",
            "$contact",
            "$merchant")
            .then((value) {
          url = value;
          print("url : $url");
        });
        var authToken;
        await WebServices.easypaisaGetLastData(url)
            .then((value) {
          for (var element in value) {
            pbUrl = element.postBackURL2;
            pbUrl = "${pbUrl}&booking_type=${widget.bookingType}";
            transactionURl1 = element.transactionPostURL2;
            authToken = element.authToken;
          }
        });
        // await WebServices.easypaisaConfirm(transactionURl1,pbUrl,authToken).then((value) {
        //   url = value;
        // });

        print(" ordersss ${widget.orderTypes} ${widget.orderIds}");
        setState(() {
          print(
              "url2: $transactionURl1?postBackURL=$pbUrl&auth_token=$authToken");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebViewExample(
                    pMethod: "$method",
                    type: "${widget.bookingType}",
                    orderIds: "${widget.orderId}",
                    ordersId: "${widget.orderIds}",
                    orderTypes:"${widget.orderTypes}",
                    totalAmount: "${widget.totalPrice}",
                    url:
                    '$transactionURl1?postBackURL=$pbUrl&auth_token=$authToken',
                  )));
        });
      }
      else if (method == 'paypal') {

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewExample(
                  pMethod: "$method",
                  type: "${widget.bookingType}",
                  orderIds:"${widget.orderIds}",
                  orderTypes: "${widget.orderTypes}",
                  totalAmount: "${widget.totalPrice}",
                  url:
                  'https://mobicell.net/Yaseo/paypal-payment/first.php?order_id=${widget.orderIds}&price=${widget.totalPrice}',
                )));
      }
    }

                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class CardPayments extends StatefulWidget {
  const CardPayments({Key? key}) : super(key: key);

  @override
  _CardPaymentsState createState() => _CardPaymentsState();
}

class _CardPaymentsState extends State<CardPayments> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return Scaffold(
        appBar: preferredSizeAppbar("Payment", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethods()),
                (route) => false);
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Card(
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                elevation: 18.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/online_payment.svg",
                      height: _appConfig.rH(20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      text: 'Card Number',
                      verticalMargin: 5,
                      horizontalMargin: 40,
                      suffixIcon: Icon(
                        Icons.credit_card,
                        color: AppConfig.tripColor,
                      ),
                      validator: (String? name) {
                        if (name!.isEmpty) {
                          return "Name can't be empty!";
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      text: 'Card Holder Name',
                      verticalMargin: 5,
                      horizontalMargin: 40,
                      suffixIcon: Icon(
                        Icons.person,
                        color: AppConfig.tripColor,
                      ),
                      validator: (String? name) {
                        if (name!.isEmpty) {
                          return "Name can't be empty!";
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            text: 'Expiry',
                            verticalMargin: 5,
                            horizontalMargin: 40,
                            validator: (String? name) {
                              if (name!.isEmpty) {
                                return "Name can't be empty!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            text: 'CVV',
                            verticalMargin: 5,
                            horizontalMargin: 40,
                            validator: (String? name) {
                              if (name!.isEmpty) {
                                return "Name can't be empty!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomBtn(
                        'Add Payment Method',
                        60,
                        AppConfig.hotelColor,
                        textColor: AppConfig.tripColor,
                        iconName: Icons.payments,
                        height: 50,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CompletionAlertBox(
                                title: "Payment Activated!",
                                description:
                                    "Payment Method has been activated successfully, Now you can order anytime.",
                                iconName: Icons.explore,
                                buttonText: "Explore",
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => PaymentMethods()),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class JazzcashOrEasyPaisa extends StatefulWidget {
  const JazzcashOrEasyPaisa({Key? key}) : super(key: key);

  @override
  _JazzcashOrEasyPaisaState createState() => _JazzcashOrEasyPaisaState();
}

class _JazzcashOrEasyPaisaState extends State<JazzcashOrEasyPaisa> {
  late AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return Scaffold(
        appBar: preferredSizeAppbar("Payment", context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethods()),
                (route) => false);
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Card(
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/online_payment.svg",
                      height: _appConfig.rH(20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      verticalMargin: 5,
                      horizontalMargin: 40,
                      text: 'Mobile Number',
                      suffixIcon: Icon(
                        Icons.credit_card,
                        color: AppConfig.tripColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomBtn(
                        'Add Payment Method',
                        60,
                        AppConfig.hotelColor,
                        textColor: AppConfig.tripColor,
                        iconName: Icons.payments,
                        height: 50,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CompletionAlertBox(
                                title: "Payment Activated!",
                                description:
                                    "Payment Method has been activated successfully, Now you can order anytime.",
                                iconName: Icons.explore,
                                buttonText: "Explore",
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => PaymentMethods()),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
