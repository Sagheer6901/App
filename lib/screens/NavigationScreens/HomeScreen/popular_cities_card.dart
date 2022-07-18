import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/popular_cities_model.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/HotelScreen/hotel_place.dart';
import 'package:untitled/services/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
class PopularPlaceCard extends StatelessWidget {
  final PopularCitiesModel? item;

  PopularPlaceCard({this.item,Key? key}) : super(key: key);
  late AppConfig _appConfig;

  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>HotelPlace(item: item,)),
        );
      },
      child:  Container(
        // height: _appConfig.rH(31),
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              // offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: AppConfig.tripColor,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.network(
                    "${AppConfig.srcLink}t.png",
                    height: _appConfig.rH(20),
                    width: _appConfig.rW(65),
                    fit: BoxFit.cover,
                  ),
                )),
           SizedBox(
              height: _appConfig.rH(1),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item!.slug}',
                      style: TextStyle(
                          fontSize: AppConfig.f4,
                          fontWeight: FontWeight.bold,
                          color: AppConfig.tripColor,
                          fontFamily: AppConfig.fontFamilyMedium
                      ),textScaleFactor: 1,
                    ),
                    RatingBarIndicator(
                      rating: double.parse("3"),
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
                SizedBox(
                  height: _appConfig.rH(0.5),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: _appConfig.rW(5),
                      color: AppConfig.textColor,
                    ),

                    Text("${item!.name},Pakistan",style: TextStyle(fontSize:AppConfig.f5,color: AppConfig.textColor,                          fontFamily: AppConfig.fontFamilyRegular
                    ),textScaleFactor: 1,)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
