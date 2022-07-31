import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/functions/custom_btn.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/GuideScreen/guide_detail.dart';
import 'package:untitled/services/services.dart';

class GuideCard extends StatefulWidget {
  final TourGuideModel? item;

  var tour;

  GuideCard({Key? key, this.tour, this.item}) : super(key: key);
  @override
  _GuideCardState createState() => _GuideCardState();
}

class _GuideCardState extends State<GuideCard> {
  late AppConfig _appConfig;
  late FToast fToast;
  bool isGuideInWishlist = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getGuideWishlist();
  }
  getGuideWishlist() async {
    isLoading = true;
    await WebServices.checkGuideInWishlist(widget.item!.id).then((wishlist) {
      // _categories = categories;
      print("categories in $wishlist");
      setState(() {
        isLoading = false;
        isGuideInWishlist = wishlist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    // setState(() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('guideId','${widget.item!.id}');
    // });
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        :Container(
      // height: _appConfig.rH(27),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
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
          Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  child: Image.network(
                      "${AppConfig.srcLink}${widget.item!.image}",
                    height: _appConfig.rH(26),
                    width: _appConfig.rW(30),
                    fit: BoxFit.cover,
                  ),
                )),
          ),

          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(left: 20,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${widget.item!.title}",
                                          style: TextStyle(
                                              fontSize: AppConfig.f4,
                                              color: AppConfig.tripColor,
                                              fontWeight: FontWeight.bold,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Age", style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                        Text("30 Years",
                                            style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Experience",
                                            style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                                        Text("30 Years",
                                            style: TextStyle(color: AppConfig.textColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                child: isGuideInWishlist?Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent
                                  ,
                                  size: _appConfig.rH(4),
                                ):Icon(
                                  Icons.favorite_outline_sharp,
                                  color:  Colors.redAccent,

                                  size: _appConfig.rH(4),
                                ),
                                onTap: () async {
                                  // showCustomToast();
                                  SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                  // prefs.remove('carId');
                                  if (isGuideInWishlist) {
                                    await prefs.setString(
                                        'guideId', "${widget.item!.id}");
                                    await WebServices.removeTouGuideWishlistItems()
                                        .then((value) async {
                                      await getGuideWishlist();
                                    });
                                    setState(() {
                                      showCustomToast("Remove From WishList");
                                    });
                                  } else {
                                    await prefs.setString(
                                        'guideId', "${widget.item!.id}");
                                    await WebServices.addTourGuideWishlistItems()
                                        .then((value) async {
                                      await getGuideWishlist();
                                    });
                                    setState(() {
                                      showCustomToast("Added To WishList");
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                           SizedBox(
                            height: _appConfig.rH(1),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: _appConfig.rH(2.5),
                                    color: AppConfig.textColor,
                                  ),
                                  Expanded(

                                    child: Text("${widget.item!.address}",
                                        style: TextStyle(color: AppConfig.textColor),textScaleFactor: 1,),
                                  )
                                ],
                              ),
                              RatingBarIndicator(
                                rating: double.parse("${widget.item!.rating}"),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: _appConfig.rW(5),

                                unratedColor: Colors.amber.withAlpha(60),
                                direction:  Axis.horizontal,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _appConfig.rH(1),
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Row(
                            children: [
                              Text(
                                "Rs ",
                                style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,
                              ),
                              Text("${widget.item!.price}/-",
                                  style: TextStyle(
                                      fontSize: AppConfig.f4,
                                      fontWeight: FontWeight.bold,
                                      color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                               SizedBox(
                                width: _appConfig.rW(20),
                              ),

                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Per Day",
                                  style: TextStyle(color: AppConfig.tripColor,fontFamily: AppConfig.fontFamilyRegular),textScaleFactor: 1,),
                              widget.tour==null?CustomBtn(
                                "Book Now",
                                _appConfig.rW(7),
                                AppConfig.hotelColor,
                                textColor: AppConfig.tripColor,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GuideDetails(
                                              products: WebServices.tourGuideItems(),
                                              reviews: WebServices.guideReviewItem(
                                                  "${widget.item!.id}"),
                                              item: this.widget.item,
                                            )),
                                  );
                                },                    textSize: AppConfig.f5,

                              ):SizedBox(),

                            ],
                          ),
                          SizedBox(
                            height: _appConfig.rH(1),
                          ),
                        ],
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  showCustomToast(msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppConfig.shadeColor,
      ),
      child: Text(msg,textScaleFactor: 1,),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 1),
    );
  }

}
