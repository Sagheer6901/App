// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/screens/NavigationScreens/CheckoutScreen/order_completion_status.dart';
import 'package:untitled/screens/NavigationScreens/navigation_screen.dart';
import 'package:untitled/services/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class WebViewExample extends StatefulWidget {
  var type;

  var pMethod,orderIds,totalAmount;
  var ordersId,orderTypes;
   WebViewExample({Key? key, this.cookieManager,this.url,this.type,this.pMethod,this.orderIds,this.totalAmount,this.orderTypes,this.ordersId}) : super(key: key);

  final CookieManager? cookieManager;
  var url;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConfig.whiteColor,
        // appBar: AppBar(
        //   title: const Text('Flutter WebView example'),
        //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        //   actions: <Widget>[
        //     NavigationControls(_controller.future),
        //     // SampleMenu(_controller.future, widget.cookieManager),
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
          child: WebView(
            initialUrl: '${widget.url}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url)  async {
              var fUrl;
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =
              print("webview ${widget.orderIds} ${widget.orderTypes}");
              if(url.contains("showOrderStatus")){
    var orders, type,payPalUrl;
    var orderId,pStatus,msg,amount;

    if (widget.type == "car" || widget.type == "hotel" || widget.type == "guide") {
      orders = "${widget.orderIds}";
      type = "${widget.type}";
      fUrl  = "$url&orderRefType=$type&paymentMethod=${widget.pMethod}";
      await WebServices.easypaisaMsg("$fUrl").then((value) {
          print("values in $value");

          for(var element in value){
            if(element.toString().contains("payment")) {
              msg = element.paymentStatus;
            }

            // pStatus= element.affect;
            // orderId = element.orderId;
            // pStatus = element.paymentStatus;
            // amount = element.amount;
          }
      });
    }
    else{
      orders = "${widget.ordersId}";
      type = "${widget.orderTypes}";
      fUrl  = "$url&orderRefType=$type&paymentMethod=${widget.pMethod}";
      await WebServices.easypaisaMsg("$fUrl").then((value) {

        print("values in ${value[1].affect}");
        pStatus= value[1].affect;
        // orderId = element.orderId;
        msg = value[0].paymentStatus;
      });
    }


    print("msg $msg $pStatus");
    print("paypals ${widget.orderTypes} ${widget.ordersId}");
    print("webview ${widget.orderIds} ${widget.orderTypes}");


    if (widget.type == "car" || widget.type == "hotel" || widget.type == "guide") {
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderCompletionStatus(orderId:"${widget.orderIds}",pStatus:"$pStatus",amount:"${widget.totalAmount}",msg:"$msg")));

    }
    else{
      Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderCompletionStatus(orderId:"${widget.ordersId}",pStatus:"$pStatus",amount:"${widget.totalAmount}",msg:"$msg")));

    }
              }
              else if(url.contains("success")){
                var status = url.contains("success=true")?true:false;
                var msgStatus = url.contains("success=true")?"Success":"Failed";
                var orders, type,payPalUrl;
                if (widget.type == "car" || widget.type == "hotel" || widget.type == "guide"){
                  orders = "${widget.orderIds}";
                  type = "${widget.type}";

                  payPalUrl ='${AppConfig.apiSrcLink}tApi.php?action=update_payment_status&orderRefNum=$orders&orderRefType=$type&status=$status&message=$msgStatus"';
                }
                else{
                  orders = "${widget.orderIds}";
                  type = "${widget.orderTypes}";
                  payPalUrl ='${AppConfig.apiSrcLink}tApi.php?action=update_payment_status&orderRefNum=$orders&orderRefType=${widget.orderTypes}&status=$status&message=$msgStatus"';
                  print("paypals ${widget.orderTypes} ${widget.ordersId}");

                }
                var orderId,pStatus,msg,amount;

                await WebServices.paypalMsg("$payPalUrl").then((value) {
                  print("values in ${value[1].affect}");
                  pStatus= value[1].affect;
                  // orderId = element.orderId;
                  msg = value[0].paymentStatus;
                });
                print("msg $msg $amount");
                if (widget.type == "car" || widget.type == "hotel" || widget.type == "guide") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderCompletionStatus(orderId:"${widget.orderIds}",pStatus:"$pStatus",amount:"${widget.totalAmount}",msg:"$msg")));

                }
                else{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderCompletionStatus(orderId:"${widget.orderIds}",pStatus:"$pStatus",amount:"${widget.totalAmount}",msg:"$msg")));

                }

              }
              print('Page finished loading: $fUrl');
            },
            gestureNavigationEnabled: true,
            backgroundColor: AppConfig.whiteColor,
          ),
        ),
        // floatingActionButton: favoriteButton(),

    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}

