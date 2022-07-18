import 'package:flutter/material.dart';
import 'package:untitled/functions/app_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({Key? key}) : super(key: key);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late AppConfig _appConfig;
  var _itemCount=0;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);

    return                   Container(
      // height: _appConfig.rH(22),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      padding: const EdgeInsets.all(10),
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
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  "${AppConfig.srcLink}4.png",
                  height: _appConfig.rH(15),
                  width: _appConfig.rW(20),
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            width: _appConfig.rW(2),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: _appConfig.rW(50),
                    child: Text(
                      'Photography Trip Photography Trip',
                      style: TextStyle(
                          color: AppConfig.tripColor,
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Container(
                    width: _appConfig.rW(50),
                    child: Text(
                      'for PAK Bank Credit Carde',
                      style: TextStyle(
                          color: AppConfig.textColor,
                          fontSize: AppConfig.f5,
                          fontWeight: FontWeight.w400
                      ),

                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState(()=>_itemCount--),):new Container(),
                      new Text(_itemCount.toString()),
                      new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState(()=>_itemCount++))
                    ],
                  ),
                  SizedBox(width: 1,),
                  Text("\$130")
                ],
              )
            ],
          )
        ],
      ),

    );
  }
}
