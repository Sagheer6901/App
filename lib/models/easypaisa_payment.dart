// To parse this JSON data, do
//
//     final easypaisaForm = easypaisaFormFromJson(jsonString);

import 'dart:convert';

List<EasypaisaForm> easypaisaFormFromJson(String str) => List<EasypaisaForm>.from(json.decode(str).map((x) => EasypaisaForm.fromJson(x)));

String easypaisaFormToJson(List<EasypaisaForm> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EasypaisaForm {
  EasypaisaForm({
    this.amount,
    this.storeId,
    this.postBackUrl,
    this.postBackURL2,
    this.orderRefNum,
    this.autoRedirect,
    this.paymentMethod,
    this.emailAddr,
    this.mobileNum,
    this.merchantHashedReq,
    this.transactionPostUrl1,
    this.transactionPostURL2,
    this.bookingType,
    this.authToken,
  });

  String? amount;
  String? storeId;
  String? postBackUrl;
  String? postBackURL2;
  String? orderRefNum;
  String? autoRedirect;
  String? paymentMethod;
  String? emailAddr;
  String? mobileNum;
  String? merchantHashedReq;
  String? transactionPostUrl1;
  String? transactionPostURL2;
  String? bookingType;
  String? authToken;

  factory EasypaisaForm.fromJson(Map<String, dynamic> json) => EasypaisaForm(
    amount: json["amount"],
    storeId: json["storeId"],
    postBackUrl: json["postBackURL"],
    postBackURL2: json["postBackURL2"],
    orderRefNum: json["orderRefNum"],
    autoRedirect: json["autoRedirect"],
    paymentMethod: json["paymentMethod"],
    emailAddr: json["emailAddr"],
    mobileNum: json["mobileNum"],
    merchantHashedReq: json["merchantHashedReq"],
    transactionPostUrl1: json["transaction_post_url1"],
    transactionPostURL2: json["transactionPostURL2"],
    bookingType: json["booking_type"],
      authToken: json['auth_token']
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "storeId": storeId,
    "postBackURL": postBackUrl,
    "orderRefNum": orderRefNum,
    "autoRedirect": autoRedirect,
    "paymentMethod": paymentMethod,
    "emailAddr": emailAddr,
    "mobileNum": mobileNum,
    "merchantHashedReq": merchantHashedReq,
    "transaction_post_url1": transactionPostUrl1,
    "booking_type": bookingType,
  };
}
