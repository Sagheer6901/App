import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';

class ImageView extends StatelessWidget {
  var img;
  ImageView({Key? key,this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.network("${AppConfig.srcLink}$img")),
    );
  }
}
