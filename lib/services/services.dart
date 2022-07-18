import 'dart:async';

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/Categories/review_car.dart';
import 'package:untitled/models/Categories/review_guide.dart';
import 'package:untitled/models/Categories/review_hotel.dart';
import 'package:untitled/models/Categories/car_model.dart';
import 'package:untitled/models/Categories/review_trip.dart';
import 'package:untitled/models/Categories/trip_model.dart';
import 'package:untitled/models/Profile/get_user_profile_data.dart';
import 'package:untitled/models/blog_category.dart';
import 'package:untitled/models/blog_comments.dart';
import 'package:untitled/models/check_in_wishlist.dart';
import 'package:untitled/models/conversation_model.dart';
import 'package:untitled/models/easypaisa_payment.dart';
import 'package:untitled/models/enquiry_ticket.dart';
import 'package:untitled/models/filter_attributes.dart';
import 'package:untitled/models/filter_category.dart';
import 'package:untitled/models/filter_terms.dart';
import 'package:untitled/models/get_blogs.dart';
import 'package:untitled/models/Categories/hotel_booking.dart';
import 'package:untitled/models/Authentication/register.dart';
import 'package:untitled/models/Categories/tour_guide.dart';
import 'package:untitled/models/hotel_rooms.dart';
import 'package:untitled/models/notification.dart';
import 'package:untitled/models/order_history_model.dart';
import 'package:untitled/models/order_id.dart';
import 'package:untitled/models/order_status.dart';
import 'package:untitled/models/plans.dart';
import 'package:untitled/models/plans.dart';
import 'package:untitled/models/plans.dart';
import 'package:untitled/models/plans.dart';
import 'package:untitled/models/popular_cities_model.dart';
import 'package:untitled/models/ratings.dart';
import 'package:untitled/models/ticket_conv_model.dart';
import 'package:untitled/screens/ProfilePopMenuScreens/BlogScreen/blogs.dart';

class WebServices {
  /////////////////////Authentication Services
  //SignUp Service
  static List<RegisterDB> parseSignUpData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<RegisterDB>((json) => RegisterDB.fromJson(json)).toList();
  }

  static Future<String?> register(userFirstName, userLastName, userEmail,
      userPass, userContact, userImage) async {
    var link = '${AppConfig.apiSrcLink}tApi.php?action=sign_up';

    link = "$link&user_first_name=$userFirstName";
    link = "$link&user_last_name=$userLastName";
    link = "$link&user_email=$userEmail";
    link = "$link&user_pass=$userPass";
    link = "$link&user_contact=$userContact";
    link = "$link&user_image=$userImage";
    Uri uri = Uri.parse(link);

    try {
      final response = await http.get(uri);
      print(response.body.toString());
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result;
      } else {
        return "Error";
      }
    } catch (e) {
      return "Errror";
    }
  }

  // Login Service
  static Future<String?> login(userEmail, userPass) async {
    var link = '${AppConfig.apiSrcLink}tApi.php?action=sign_in';
    link = "$link&user_email=$userEmail";
    link = "$link&user_pass=$userPass";
    Uri uri = Uri.parse(link);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.toString());
        final result = json.decode(response.body);
        return result;
      } else {
        // FlutterToast(context).showToast(
        //     child: Text('Username and password invalid',
        //         style: TextStyle(fontSize: 25, color: Colors.red)));
        return "Error";
      }
    } catch (e) {
      return "$e Error";
    }
  }

  /////////////////////Categories Services
  // Hire A Car Service
  static List<CarModel> parseHireACarProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarModel>((json) => CarModel.fromJson(json)).toList();
  }

  static List<CarModel> carList = [];
  static Future<List<CarModel>> carItems() async {
    carList.clear();
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_car_list');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        carList.add(CarModel.fromJson(i));
      }
      // return carList;
      return parseHireACarProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
  // Home search for Car Service
  static List<CarModel> parseSearchCarProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<CarModel>((json) => CarModel.fromJson(json))
        .toList();
  }

  static Future<List<CarModel>> searchCarItems(carSearch) async {
    Uri uri =
    Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=search&type=car&searchQ=$carSearch');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseSearchCarProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Hotel Booking Service
  static List<HotelModel> parseHotelBookingProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HotelModel>((json) => HotelModel.fromJson(json)).toList();
  }

  static Future<List<HotelModel>> hotelItems() async {
    Uri uri =
        Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_hotel_list');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseHotelBookingProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // hotel Room
  static List<HotelRooms> parseHotelRoomsItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HotelRooms>((json) => HotelRooms.fromJson(json)).toList();
  }
  static Future<List<HotelRooms>> hotelRoomsItems(hotelId) async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_hotelRooms&hotel_id=$hotelId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseHotelRoomsItems(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
  // Home search for Hotel Service
  static List<HotelModel> parseSearchHotelProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HotelModel>((json) => HotelModel.fromJson(json))
        .toList();
  }

  static Future<List<HotelModel>> searchHotelItems(searchHotel) async {
    Uri uri =
    Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=search&type=hotel&searchQ=$searchHotel');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseSearchHotelProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Tour Guide Service
  static List<TourGuideModel> parseTourGuideProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TourGuideModel>((json) => TourGuideModel.fromJson(json))
        .toList();
  }

  static Future<List<TourGuideModel>> tourGuideItems() async {
    Uri uri =
        Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_tour_guide');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseTourGuideProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Home search for Guide Service
  static List<TourGuideModel> parseSearchGuideProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TourGuideModel>((json) => TourGuideModel.fromJson(json))
        .toList();
  }

  static Future<List<TourGuideModel>> searchGuideItems(searchGuide) async {
    Uri uri =
    Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=search&type=guide&searchQ=$searchGuide');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseSearchGuideProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Trip Service
  static List<TripListModel> parseTripProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TripListModel>((json) => TripListModel.fromJson(json))
        .toList();
  }

  static Future<List<TripListModel>> tripItems() async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_trip_list');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseTripProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  // Home search for Trip Service
  static List<TripListModel> parseTripSearchProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TripListModel>((json) => TripListModel.fromJson(json))
        .toList();
  }

  static Future<List<TripListModel>> tripSearchItems(searchTrip) async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=search&type=trip&searchQ=$searchTrip');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseTripSearchProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  /////////////////////Profile Services
  // Update Name Service
  static List<UserProfile> parseUpdateName(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<List<UserProfile>> updateNameItem(userName, userEmail) async {
    Uri uri = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=edit_name&user_name=$userName&user_email=$userEmail");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseUpdateName(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Update Birthday Service
  static List<UserProfile> parseUpdateBirthday(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<List<UserProfile>> updateBirthdayItem(birthday, email) async {
    print(" hello $birthday");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=edit_birthdate&birthdate=${birthday}&user_email=$email');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseUpdateBirthday(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Update Contact Service
  static List<UserProfile> parseUpdateContact(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<List<UserProfile>> updateContactItem(userContact, otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=edit_number&number=$userContact&otp_status=$otp&user_email=$email');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseUpdateContact(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Update Name Service
  static List<UserProfile> parseEmailName(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<void> updateEmailItem(userEmail, newEmail, otp) async {
    Uri uri = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=edit_email&new_user_email=$newEmail&otp_email_status=$otp&user_email=$userEmail");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseEmailName(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Update Password Service
  static List<UserProfile> parseUpdatePassword(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<List<UserProfile>> updatePasswordItem(
      userPass, userEmail) async {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=edit_password&user_pass=$userPass&user_email=$userEmail');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseUpdatePassword(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Update Name Service
  static List<UserProfile> parseAddress(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<List<UserProfile>> updateAddressItem(userAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=edit_address&user_address=$userAddress&user_email=$email');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("hello1" + response.body.toString());
      return parseAddress(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  ///////////////////// WishList Services
  ////// WishList Fetch Services
  // Car WishList Service
  static List<CarModel> parseCarWishListProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarModel>((json) => CarModel.fromJson(json)).toList();
  }

  static List<CarModel> carWishList = [];
  static Future<List<CarModel>> carWishlistItems() async {
    carWishList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_car_wishlist&user_id=$userId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        carWishList.add(CarModel.fromJson(i));
      }
      return carWishList;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //////Car W list
  static List<CarModel> parseCWL(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarModel>((json) => CarModel.fromJson(json)).toList();
  }

  static List<CarModel> cwl = [];
  static Future<List<CarModel>> cWL(carId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_car_wl&car_id=$carId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        cwl.add(CarModel.fromJson(i));
      }
      print("list  $cwl");
      return cwl;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Hotel Wishlist Service
  static List<HotelModel> parseHotelWishListProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HotelModel>((json) => HotelModel.fromJson(json)).toList();
  }

  static Future<List<HotelModel>> hotelWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_hotel_wishlist&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseHotelWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Tour Guide Wishlist Service
  static List<TourGuideModel> parseTourGuideWishListProducts(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TourGuideModel>((json) => TourGuideModel.fromJson(json))
        .toList();
  }

  static Future<List<TourGuideModel>> tourGuideWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_guide_wishlist&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseTourGuideWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Trip Whislist Service
  static List<TripListModel> parseTripWishListProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TripListModel>((json) => TripListModel.fromJson(json))
        .toList();
  }

  static Future<List<TripListModel>> tripWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_trip_wishlist&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseTripWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Items in Wishlist
  // Add Car Wishlist Service
  static List<CarModel> parseAddCarToWishlist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarModel>((json) => CarModel.fromJson(json)).toList();
  }

  static Future<void> addCarWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var carId = prefs.getString("carId");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=add_car_wishlist&user_id=$userId&car_id=$carId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Hotel Wishlist Service
  static List<HotelModel> parseAddHotelToWishlist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HotelModel>((json) => HotelModel.fromJson(json)).toList();
  }

  static Future<void> addHotelWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var hotelId = prefs.getString("hotelId");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=add_hotel_wishlist&user_id=$userId&hotel_id=$hotelId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddHotelToWishlist(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Tour Guide Wishlist Service
  static List<TourGuideModel> parseAddTourGuideToWishlist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TourGuideModel>((json) => TourGuideModel.fromJson(json))
        .toList();
  }

  static Future<void> addTourGuideWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var guideId = prefs.getString("guideId");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=add_guide_wishlist&user_id=$userId&guide_id=$guideId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddTourGuideToWishlist(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Trip in Wishlist
  static Future<void> addTripWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var tripId = prefs.getString("tripId");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=add_trip_wishlist&user_id=$userId&trip_id=$tripId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  /////Remove Items in Wishlist
  // Remove Car Wishlist Service
  static List<CarModel> parseRemoveCarToWishlist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarModel>((json) => CarModel.fromJson(json)).toList();
  }

  static Future<void> removeCarWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var carId = prefs.getString("carId");
    print("CAr id is $carId");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=remove_car_wishlist&car_id=$carId&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseRemoveCarToWishlist(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

// Remove Hotel Wishlist Service
  static List<HotelModel> parseRemoveHotelToWishlist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HotelModel>((json) => HotelModel.fromJson(json)).toList();
  }

  static Future<void> removeHotelWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var hotelId = prefs.getString("hotelId");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=remove_hotel_wishlist&hotel_id=$hotelId&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseRemoveHotelToWishlist(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Remove Tour Guide Wishlist Service
  static List<TourGuideModel> parseRemoveTourGuideToWishlist(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TourGuideModel>((json) => TourGuideModel.fromJson(json))
        .toList();
  }

  static Future<void> removeTouGuideWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var guideId = prefs.getString("guideId");
    print("guide is $guideId");

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=remove_guide_wishlist&guide_id=$guideId&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(uri.toString());

      print(response.body.toString());
      // return parseTourGuideWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Remove Trip Wishlist Service
  static Future<void> removeTripWishlistItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var tripId = prefs.getString("tripId");
    print("tripId is $tripId");

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=remove_trip_wishlist&trip_id=$tripId&user_id=$userId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(uri.toString());

      print(response.body.toString());
      // return parseTourGuideWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  /////////////////////Other Services
  // Blogs Service

  // static List<Blogs> parseBlogsProducts(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Blogs>((json) => Blogs.fromJson(json)).toList();
  // }
  //
  // static Future<List<Blogs>> blogItems() async {
  //   Uri uri =
  //   Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_blogs');
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     print(response.body.toString());
  //     return parseBlogsProducts(response.body);
  //   } else {
  //     throw Exception('Unable to fetch products from the REST API');
  //   }
  // }
  //

  // Blogs
  static List<Blogs> parseBlogsProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Blogs>((json) => Blogs.fromJson(json)).toList();
  }

  static Future<List<Blogs>> blogItems(pageNo) async {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_blogs&page=${pageNo.toString()}');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response here: ${response.body.toString()}");
      return parseBlogsProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Blog Category Service
  static List<BlogCategory> parseBlogCategory(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BlogCategory>((json) => BlogCategory.fromJson(json))
        .toList();
  }

  static List<BlogCategory> blockCategory = [];
  static Future<List<BlogCategory>> getBlogCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri =
        Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_blog_categories');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      final List<BlogCategory> blogCategories =
          blogCategoryFromJson(response.body);
      print("helloo $blogCategories");
      return blogCategories;
      // print(response.body.toString());
      // for (Map<String,dynamic> i in data){
      //   blockCategory.add(BlogCategory.fromJson(i));
      // }      print("list $blockCategory");

      // return blockCategory;
      return parseBlogCategory(response.body);
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Blog By  Category Service
  static List<Blogs> parseBlogByCategory(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Blogs>((json) => Blogs.fromJson(json)).toList();
  }

  static List<Blogs> blogByCategory = [];
  static Future<List<Blogs>> getBlogByCategory(category, pageNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_blogs_by_cat&cat=$category&page=$pageNo');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // final List<Blogs> blogCategories= blogByCategory(response.body);
      // print("helloo $blogCategories");
      // return blogCategories;
      // print(response.body.toString());
      // for (Map<String,dynamic> i in data){
      //   blockCategory.add(BlogCategory.fromJson(i));
      // }      print("list $blockCategory");
      // return blockCategory;
      return parseBlogByCategory(response.body);
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Blogs comments Service
  static List<BlogsComments> parseBlogsComments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BlogsComments>((json) => BlogsComments.fromJson(json))
        .toList();
  }

  static Future<List<BlogsComments>> blogCommentItems() async {
    Uri uri =
        Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_blog_comments');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      var parsed = parseBlogsComments(response.body);
      print(" parsed $parsed");
      return parseBlogsComments(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Blog comments by Id
  static List<BlogsComments> parseBlogsCommentsById(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BlogsComments>((json) => BlogsComments.fromJson(json))
        .toList();
  }

  static Future<List<BlogsComments>> blogCommentItemsById(blogId) async {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_blog_comments&blog_id=$blogId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // print(response.body.toString());
      var parsed = parseBlogsComments(response.body);
      print(" parsed $parsed");
      return parseBlogsCommentsById(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Blogs comments Service
  static List<BlogsComments> parseAddBlogsComments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<BlogsComments>((json) => BlogsComments.fromJson(json))
        .toList();
  }

  static Future<List<BlogsComments>> addBlogCommentItems(
      blogId, name, email, comments) async {
    print("$comments");
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=add_blog_comment&blog_id=$blogId&name=$name&email=$email&comment=$comments');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseAddBlogsComments(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Hotel Review Service
  static List<HotelReview> parseHotelReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<HotelReview>((json) => HotelReview.fromJson(json))
        .toList();
  }

  static Future<List<HotelReview>> hotelReviewItem(hotelId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var hotelId = prefs.getString('hotelId');
    print("$hotelId");
    Uri uri = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_hotel_reviews&hotel_id=$hotelId");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseHotelReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Trip Review Service
  static List<TripReviews> parseTripReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TripReviews>((json) => TripReviews.fromJson(json))
        .toList();
  }

  static Future<List<TripReviews>> tripReviewItem(tripId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var hotelId = prefs.getString('hotelId');
    print("$tripId");
    Uri uri = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_activity_reviews&activity_id=$tripId");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseTripReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Car Review Service
  static List<CarReview> parseCarReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarReview>((json) => CarReview.fromJson(json)).toList();
  }

  static Future<List<CarReview>> carReviewItem(carId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var hotelId = prefs.getString('hotelId');
    print("hello lll $carId");
    Uri uri = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_car_reviews&car_id=$carId");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseCarReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Guide Review Service
  static List<GuideReview> parseGuideReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<GuideReview>((json) => GuideReview.fromJson(json))
        .toList();
  }

  static Future<List<GuideReview>> guideReviewItem(guideId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var hotelId = prefs.getString('hotelId');
    // print("hello lll $carId");
    Uri uri = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_guide_reviews&guide_id=$guideId");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseGuideReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add hotel Review Service
  static List<TicketModel> parseAddHotelReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketModel>((json) => TicketModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addHotelReviewItems(hotelId, comments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var name = prefs.getString('name');

    print("hello world");
    Map<String, String> body = {
      "action": "add_hotel_review",
      "hotel_id": "$hotelId",
      "name": "$name",
      "email": "$email",
      "comment": "$comments"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddHotelReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Trip reviews service
  static Future<Object?> addTripReviewItems(tripId, comments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var name = prefs.getString('name');

    print("hello world");
    Map<String, String> body = {
      "action": "add_activity_review",
      "activity_id": "$tripId",
      "name": "$name",
      "email": "$email",
      "comment": "$comments"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddHotelReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add hotel Rating by category Service
  static List<RatingsModel> parseHotelRating(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RatingsModel>((json) => RatingsModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addHotelRatingItems(
      service, organization, friendliness, areaExpert, safety, hotelId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "insert_hotel_rating",
      "service": "$service",
      "organization": "$organization",
      "friendliness": "$friendliness",
      "area_expert": "$areaExpert",
      "safety": "$safety",
      "hotel_id": "$hotelId",
      "user_id": "$userId"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseHotelRating(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }



  // Add CAr Review Service
  static List<TicketModel> parseAddCarReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketModel>((json) => TicketModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addCarReviewItems(carId, comments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var name = prefs.getString('name');

    print("hello world reviewssss");
    Map<String, String> body = {
      "action": "add_car_review",
      "car_id": "$carId",
      "name": "$name",
      "email": "$email",
      "comment": "$comments"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddHotelReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // add trip rating service
  static Future<Object?> addTripRatingItems(
      service, organization, friendliness, areaExpert, safety, tripId) async {
    print("trip id$tripId");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "insert_activity_rating",
      "service": "$service",
      "organization": "$organization",
      "friendliness": "$friendliness",
      "area_expert": "$areaExpert",
      "safety": "$safety",
      "activity_id": "$tripId",
      "user_id": "$userId"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseHotelRating(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Car Rating Service
  static List<RatingsModel> parseCarRating(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<RatingsModel>((json) => RatingsModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addCarRatingItems(
      service, organization, friendliness, areaExpert, safety, carId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "insert_car_rating",
      "service": "$service",
      "organization": "$organization",
      "friendliness": "$friendliness",
      "area_expert": "$areaExpert",
      "safety": "$safety",
      "car_id": "$carId",
      "user_id": "$userId"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseHotelRating(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Add Guide Review Service
  static List<TicketModel> parseAddGuideReview(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketModel>((json) => TicketModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addGuideReviewItems(carId, comments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var name = prefs.getString('name');

    print("hello world");
    Map<String, String> body = {
      "action": "add_guide_review",
      "guide_id": "$carId",
      "name": "$name",
      "email": "$email",
      "comment": "$comments"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddHotelReview(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //  Get Tikeckts service
  static List<TicketModel> parseGetTickets(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketModel>((json) => TicketModel.fromJson(json))
        .toList();
  }

  static Future<List<TicketModel>> getGetTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var userEmail = prefs.getString('email');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_tickets&user_email=$userEmail');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseGetTickets(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //  Get popular Cities service
  static List<PopularCitiesModel> parseGetPopularCities(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PopularCitiesModel>((json) => PopularCitiesModel.fromJson(json))
        .toList();
  }

  static Future<List<PopularCitiesModel>> getPopularCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_locations');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseGetPopularCities(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
  // static Stream<List<PopularCitiesModel>> streamGetPopularCities() async* {
  //   while (true) {
  //     await Future.delayed(Duration(milliseconds: 500));
  //     Stream<List<PopularCitiesModel>> someProduct = getPopularCities() ;
  //     yield* someProduct;
  //   }
  // }

  // Get Chat
  static List<ConversationModel> parseGetChat(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ConversationModel>((json) => ConversationModel.fromJson(json))
        .toList();
  }

  static Stream<List<ConversationModel>> getGetChat() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_chat&user_id=$userId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      yield parseGetChat(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Stream<List<ConversationModel>> productsStreamchat() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      Stream<List<ConversationModel>> someProduct = getGetChat();
      yield* someProduct;
    }
  }

  // send chat
  static Future sentChat(sender, user, msg, picked) async {
    // var picked = await FilePicker.platform.pickFiles();

    print('upload started');
    // File _image = File(picked!.paths.toString());
    // print(" image print : $_image");
    //  var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
    // var length = await _image!.length();
    var uri = Uri.parse("${AppConfig.apiSrcLink}tApi.php");
    // var arr = _image!.path.split('/');
    var request = http.MultipartRequest("POST", uri);
    request.fields['action'] = "insert_message";
    request.fields['sender_id'] = "$sender";
    request.fields['receiver_id'] = "1";
    request.fields['user'] = "$user";
    request.fields['admin'] = "1";
    request.fields['msg'] = "$msg";
    if (picked != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'picture', picked.paths[0].toString()));
    }
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.statusCode);
    print("file name: $response");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // Get TicketConv
  static List<TicketConvModel> parseGetTicketConv(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketConvModel>((json) => TicketConvModel.fromJson(json))
        .toList();
  }

  static Stream<List<TicketConvModel>> getGetTicketConv(ticketId) async* {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_ticket_conv&ticket_id=$ticketId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      yield parseGetTicketConv(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Stream<List<TicketConvModel>> productsStreamConv(ticketId) async* {
    print("stream file name: $ticketId");
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      Stream<List<TicketConvModel>> someProduct = getGetTicketConv(ticketId);
      yield* someProduct;
    }
  }

  // send conv
  static Future sentConv(ticketId, msg) async {
    // var picked = await FilePicker.platform.pickFiles();

    print('upload started');
    // File _image = File(picked!.paths.toString());
    // print(" image print : $_image");
    //  var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
    // var length = await _image!.length();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var uri = Uri.parse("${AppConfig.apiSrcLink}tApi.php");
    // var arr = _image!.path.split('/');
    var request = http.MultipartRequest("POST", uri);
    request.fields['action'] = "insert_ticket_conv";
    request.fields['ticket_id'] = "$ticketId";
    request.fields['sender'] = "$userId";
    request.fields['reciever'] = "1";
    request.fields['message'] = "$msg";
    // if(picked != null){
    //   request.files.add(await http.MultipartFile.fromPath('picture', picked.paths[0].toString()));
    //
    // }
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.statusCode);
    print("file name: $response");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // send ticket
  static Future sendTicket(subject, description, picked) async {
    // var picked = await FilePicker.platform.pickFiles();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var name = prefs.getString("name");
    print('upload started: $picked');

    // File?     _image = File(picked!.path);
    // print(" image print : $_image");
    //  var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
    // var length = await _image!.length();
    var uri = Uri.parse("${AppConfig.apiSrcLink}tApi.php");
    // var arr = _image!.path.split('/');
    var request = http.MultipartRequest("POST", uri);
    print("name :  u $name");
    request.fields['action'] = "insert_ticket";
    request.fields['u_name'] = "$name";
    request.fields['email'] = "$email";
    request.fields['issue'] = "$subject";
    request.fields['description'] = "$description";
    if (picked != null) {
      request.files.add(
          // await http.MultipartFile.fromPath('picture', picked.path));
          await http.MultipartFile.fromPath(
              'picture', picked.paths[0].toString()));
    }

    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.statusCode);
    print("file name: $response");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // Update status
  static Future sendTicketStatus(ticketId) async {
    var uri = Uri.parse("${AppConfig.apiSrcLink}tApi.php");
    // var arr = _image!.path.split('/');
    var request = http.MultipartRequest("POST", uri);
    // print("name :  u $name");
    request.fields['action'] = "update_ticket_status";
    request.fields['status'] = "approved";
    request.fields['ticket_id'] = "$ticketId";
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.statusCode);
    print("file name: $response");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  // booking hotel service
  static List<OrderId> parseBookingHotel(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OrderId>((json) => OrderId.fromJson(json)).toList();
  }


  static Future<List<OrderId>> addHotelBooking(
      hoteId, price,nights,totalRooms,roomIds, checkinDate, checkoutDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!... $hoteId $userId $price $checkoutDate $checkinDate");
    Map<String, String> body = {
      "action": "hotelbooking",
      "hotel_id": "$hoteId",
      "user_id": "$userId",
      "price": "$price",
      "night":"$nights",
      "total_room":"$totalRooms",
      "room_ids":"$roomIds",
      "checkindate": "$checkinDate",
      "checkoutdate": "$checkoutDate"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseBookingHotel(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  static List<OrderId> parseBookingCar(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OrderId>((json) => OrderId.fromJson(json)).toList();
  }

  static Future<List<OrderId>> addCarBooking(
      carId, total, pickdate, dropdate, passengers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "carbooking",
      "car_id": "$carId",
      "user_id": "$userId",
      "total": "$total",
      "pickdate": "$pickdate",
      "dropdate": "$dropdate",
      "passengers": "$passengers"
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {

      return parseBookingCar(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //booking guide service
  static List<OrderId> parseBookingGuide(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OrderId>((json) => OrderId.fromJson(json)).toList();
  }

  static Future<List<OrderId>> addGuideBooking(
      guideId, total, checkin, checkout) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "guidebooking",
      "guide_id": "$guideId",
      "user_id": "$userId",
      "total": "$total",
      "checkin": "$checkin",
      "checkout": "$checkout",
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseBookingGuide(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //booking tour service
  static List<OrderId> parseBookingTour(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OrderId>((json) => OrderId.fromJson(json)).toList();
  }

  static Future<List<OrderId>> addTourBooking(tripId, total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "tripbooking",
      "tripid": "$tripId",
      "userid": "$userId",
      "price": "$total",
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseBookingTour(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Sent Chat
  // static List<ConversationModel> parseChat(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<ConversationModel>((json) => ConversationModel.fromJson(json)).toList();
  // }
  //
  // static Future<Object?> addChatItems(reciever,sender, msg, ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userId = prefs.getString('id');
  //
  //
  //   print("hello world!...");
  //   Map<String, String> body = {
  //     "action":"insert_message",
  //     "receiver_id":"$reciever",
  //     "sender_id":"$sender",
  //     "admin":"1",
  //     "user":"$userId",
  //     "msg":"$msg",
  //     "file":"file.png",
  //     // "user_id":"$userId"
  //   };
  //   Uri uri =
  //   Uri.parse('${AppConfig.apiSrcLink}tApi.php');
  //   final response = await http.post(uri,body: body);
  //   if (response.statusCode == 200) {
  //     print(response.body.toString());
  //     // return parseHotelRating(response.body);
  //   } else {
  //     throw Exception('Unable to fetch products from the REST API');
  //   }
  // }

  // static Future<http.Response> uploadFile(issue, imageEncode,desc) async {
  //   try {
  //     var request = new http.MultipartRequest(
  //         "POST", Uri.parse("https://****/***/fileupload.php"));
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var email = prefs.getString('email');
  //     var name = prefs.getString("name");
  //     print("he $file h");
  //     for (var i = 0; i < ImageEncode.length; i++) {
  //       selectedFilesBytes = List.from(uploadedImage[i]);
  //       request.files.add(http.MultipartFile.fromBytes(
  //           'file[]', selectedFilesBytes,
  //           contentType: MediaType('application', 'octet-stream'),
  //           filename: files[i].name));
  //     }
  //
  //     print("request.files.length");
  //     print(request.files.length);
  //     // request.fields['file']='$fileName';
  //     request.fields['name'] = '$name';
  //     request.fields['email'] = '$email';
  //     request.fields['issue'] = '$issue';
  //     request.fields['description'] = '$desc';
  //
  //     var streamedResponse = await request.send();
  //
  //     return await http.Response.fromStream(streamedResponse);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Add Tickets Service
  static List<TicketModel> parseAddTicketModel(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<TicketModel>((json) => TicketModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addTicketModelItems(issue, file, desc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var name = prefs.getString("name");
    print("he $file h");
    Map<String, String> body = {
      "action": "insert_ticket",
      "name": "$name",
      "email": "$email",
      "issue": "$issue",
      "file": "$file",
      "description": "$desc"
    };

    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddTicketModel(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Plans Service
  static List<Plans> parsePlansItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Plans>((json) => Plans.fromJson(json)).toList();
  }

  static Future<List<Plans>> plansItems() async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_plans');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body.toString());
      return parsePlansItems(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
  // static Stream<List<Plans>> streamPlanItems() async* {
  //   while (true) {
  //     await Future.delayed(Duration(milliseconds: 500));
  //     Stream<List<Plans>> someProduct = plansItems() ;
  //     yield* someProduct;
  //   }
  // }

  static Future uploadProfileImage(image) async {
    File? _image;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    // var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    print('upload started');
    _image = File(image!.path);
    print(" image print : $_image");
    // var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
    var length = await _image.length();
    var uri = Uri.parse("${AppConfig.apiSrcLink}tApi.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['action'] = "edit_image";
    request.fields['user_email'] = "$email";

    request.files
        .add(await http.MultipartFile.fromPath('picture', _image.path));
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    print(response.statusCode);
    print("file name: $response");
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    print(" file n: $_image");
  }



  // Car RAting Service
  static List<RatingsModel> carRatings = [];
  static Future<List<RatingsModel>> carRating(carId) async {
    carRatings.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_car_rating&car_id=$carId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        carRatings.add(RatingsModel.fromJson(i));
      }
      return carRatings;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Car RAting Service
  static List<RatingsModel> hotelRatings = [];
  static Future<List<RatingsModel>> hotelRating(hotelId) async {
    hotelRatings.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_hotel_rating&hotel_id=$hotelId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        hotelRatings.add(RatingsModel.fromJson(i));
      }
      return hotelRatings;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  // Car RAting Service
  static List<RatingsModel> tripRatings = [];
  static Future<List<RatingsModel>> tripRating(tripId) async {
    tripRatings.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_activity_rating&activity_id=$tripId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        tripRatings.add(RatingsModel.fromJson(i));
      }
      return tripRatings;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //update rating column in hotel
  static Future<Object?> addCarRateItems(rating, carId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "update_car_rating",
      "rating": "$rating",
      "car_id": "$carId",
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseHotelRating(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //update rating column in hotel
  static Future<Object?> addHotelRateItems(rating, hotelId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...");
    Map<String, String> body = {
      "action": "update_hotel_rating",
      "rating": "$rating",
      "hotel_id": "$hotelId",
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseHotelRating(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //update rating column in trip
  static Future<Object?> addTripRateItems(rating, tripId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    print("hello world!...$rating");
    Map<String, String> body = {
      "action": "update_trip_rating",
      "rating": "$rating",
      "activity_id": "$tripId",
    };
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseHotelRating(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //Notification
  static List<Notification> parseNotification(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Notification>((json) => Notification.fromJson(json))
        .toList();
  }

  static Stream<List<Notification>> getNotification() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_noti_counter&user_id=$userId');
    final response = await http.get(uri);
    // var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      yield parseNotification(response.body);
      // oldcounter = response.body;

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Stream<List<Notification>> productsNotification() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      Stream<List<Notification>> someProduct = getNotification();
      yield* someProduct;
    }
  }

  // Notification status
  static List<ConversationModel> parseNotStatus(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ConversationModel>((json) => ConversationModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addNotStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    Map<String, String> body = {
      "action": "update_seen_status",
      "user_id": "$userId",
    };

    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddTicketModel(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //Customer support notification
  static List<Notification> parseCustomerSupportNotification(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Notification>((json) => Notification.fromJson(json))
        .toList();
  }

  static Stream<List<Notification>> getCustomerSupportNotification() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_ticket_noti_count&user_id=$userId');
    final response = await http.get(uri);
    // var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      yield parseNotification(response.body);
      // oldcounter = response.body;

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Stream<List<Notification>>
      productsCustomerSupportNotification() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      Stream<List<Notification>> someProduct = getCustomerSupportNotification();
      yield* someProduct;
    }
  }

  // Notification status
  static List<ConversationModel> parseCustomerSupportNotStatus(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ConversationModel>((json) => ConversationModel.fromJson(json))
        .toList();
  }

  static Future<Object?> addCustomersupportNotStatus(ticketId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    Map<String, String> body = {
      "action": "update_ticket_seen_status",
      "ticket_id": "$ticketId",
    };

    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php');
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print(response.body.toString());
      // return parseAddTicketModel(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static List<Notification> parseNotiEnquiry(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Notification>((json) => Notification.fromJson(json))
        .toList();
  }

  static Stream<List<Notification>> getNotiEnquiry(ticketId) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_noti_count_by_ticket_id&ticket_id=$ticketId');
    final response = await http.get(uri);
    // var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      yield parseNotiEnquiry(response.body);
      // oldcounter = response.body;

    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  static Stream<List<Notification>> productsNotiEnquiry(ticketId) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      Stream<List<Notification>> someProduct = getNotiEnquiry(ticketId);
      yield* someProduct;
    }
  }

  // Filter attributes in car
  static List<FilterAttributes> parseFilterCarAttributes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterAttributes>((json) => FilterAttributes.fromJson(json))
        .toList();
  }

  static Future<List<FilterAttributes>> filterCarAtrributes() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var userId = prefs.getString('id');

    // Map<String, String> body = {
    //   "action":"update_seen_status",
    //   "user_id":"$userId",
    // };

    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_car_attr');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterCarAttributes(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter terms in car
  static List<FilterTerms> parseFilterCarTerms(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterTerms>((json) => FilterTerms.fromJson(json))
        .toList();
  }

  static Future<List<FilterTerms>> filterCarTerms(attrId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var userId = prefs.getString('id');

    // Map<String, String> body = {
    //   "action":"update_seen_status",
    //   "user_id":"$userId",
    // };

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_car_terms&attr_id=$attrId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterCarTerms(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter attributes in hotel
  static List<FilterAttributes> parseFilterHotelAttributes(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterAttributes>((json) => FilterAttributes.fromJson(json))
        .toList();
  }

  static Future<List<FilterAttributes>> filterHotelAtrributes() async {
    Uri uri =
        Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_hotel_attr');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterHotelAttributes(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter terms in hotel
  static List<FilterTerms> parseFilterHotelTerms(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterTerms>((json) => FilterTerms.fromJson(json))
        .toList();
  }

  static Future<List<FilterTerms>> filterHotelTerms(attrId) async {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_hotel_terms&attr_id=$attrId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterHotelTerms(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter attributes in gudie
  static List<FilterAttributes> parseFilterGuideAttributes(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterAttributes>((json) => FilterAttributes.fromJson(json))
        .toList();
  }

  static Future<List<FilterAttributes>> filterGuideAtrributes() async {
    Uri uri =
        Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_guide_attr');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterGuideAttributes(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter terms in gudie
  static List<FilterTerms> parseFilterGuideTerms(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterTerms>((json) => FilterTerms.fromJson(json))
        .toList();
  }

  static Future<List<FilterTerms>> filterGuideTerms(attrId) async {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_guide_terms&attr_id=$attrId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterGuideTerms(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter attributes in trip
  static List<FilterAttributes> parseFilterTripAttributes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterAttributes>((json) => FilterAttributes.fromJson(json))
        .toList();
  }

  static Future<List<FilterAttributes>> filterTripAtrributes() async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_act_attr');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterTripAttributes(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Filter terms in trip
  static List<FilterTerms> parseFilterTripTerms(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<FilterTerms>((json) => FilterTerms.fromJson(json))
        .toList();
  }

  static Future<List<FilterTerms>> filterTripTerms(attrId) async {
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_act_terms&attr_id=$attrId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseFilterTripTerms(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // check car in wishlist
  static List<CheckInWishlist> parseCheckCarInWishlist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<CheckInWishlist>((json) => CheckInWishlist.fromJson(json))
        .toList();
  }

  static Future<bool> checkCarInWishlist(carId) async {
    List getCars = [];
    print(carId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=check_car_wishlist&user_id=$userId&car_id=$carId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      // return parseCheckCarInWishlist(response.body);
      String check = response.body;
      if (check == '[1]') {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //check hotel in wishlist
  static Future<bool> checkHotelInWishlist(hotelId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=check_hotel_wishlist&user_id=$userId&hotel_id=$hotelId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      // return parseCheckCarInWishlist(response.body);
      String check = response.body;
      if (check == '[1]') {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //check guide in wishlist
  static Future<bool> checkGuideInWishlist(guideId) async {
    // print(carId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=check_guide_wishlist&user_id=$userId&guide_id=$guideId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      // return parseCheckCarInWishlist(response.body);
      String check = response.body;
      if (check == '[1]') {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //check guide in wishlist
  static Future<bool> checkTripInWishlist(tripId) async {
    // print(carId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');

    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=check_trip_wishlist&user_id=$userId&trip_id=$tripId');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      // return parseCheckCarInWishlist(response.body);
      String check = response.body;
      if (check == '[1]') {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //User data
  static List<UserProfile> parseUserData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserProfile>((json) => UserProfile.fromJson(json))
        .toList();
  }

  static Future<List<UserProfile>> userData(email) async {
    var url = Uri.parse(
        "${AppConfig.apiSrcLink}tApi.php?action=get_profile&user_email=$email");

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("response1" + response.body.toString());
      return parseUserData(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //Easypaissa form Service
  static List<EasypaisaForm> parseEasypaisa(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<EasypaisaForm>((json) => EasypaisaForm.fromJson(json))
        .toList();
  }

  static List<EasypaisaForm> easypaisa = [];

  static Future<List<EasypaisaForm>> easypaisform(
      payOption, amount, orderRef, email, contact, type) async {
    // print("$payOption, $amount, $orderRef, $email, $contact, $type");
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?');
    Map<String, String> body = {
      "action": "easypaisa_form",
      "payment_option": "$payOption",
      "amount": "$amount",
      "orderRefNum": "$orderRef",
      "email": "$email",
      "contact": "$contact",
      "booking_type": "$type"
    };
    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      print("1st api resposne: ");
      print(response.body.toString());
      print(response.headers["location"].toString());
      final List<EasypaisaForm> easypaisa =
          easypaisaFormFromJson(response.body);
      return easypaisa;
      // return parseEasypaisa(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //Easypaisa auth token
  static List<EasypaisaForm> parseEasypaisaToken(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<EasypaisaForm>((json) => EasypaisaForm.fromJson(json))
        .toList();
  }

  static Future<Object> easypaisaAuthToken(transactionUrl1, amount, storeId,
      orderId, postBackURL, paymentMethod, email, contact, mercahnt) async {
    print("turl1: $transactionUrl1");
    Uri uri = Uri.parse('$transactionUrl1');
    Map<String, String> body = {
      "amount": "$amount",
      "storeId": "$storeId",
      "postBackURL": "$postBackURL",
      "orderRefNum": "$orderId",
      "autoRedirect": "1",
      "paymentMethod": "$paymentMethod",
      "emailAddr": "$email",
      "mobileNum": "$contact",
      "merchantHashedReq": "$mercahnt"
    };

    // "amount":"1.0","storeId":"64340","postBackURL":"http://mobicell.net/Yaseo/tApi.php","orderRefNum":"60","autoRedirect":"1","paymentMethod":"CC_PAYMENT_METHOD","emailAddr":"aazamjafferi@gmail.com","mobileNum":"03423144460","merchantHashedReq":"ZKDGdKfHJDuzIURSHleA3pEH7oCEipInC7DCLMjaRxDogiSEhmT4eFj2jx3Iya6jrSIm4NiLsXLrsA9S460E79iYLhTWCGAzZFW9kzbs7K\/MJt8+Btr\/H7dO9OP88jaPpT4McFA8VJVzv5BiSnG6spwo4RPBcn7y7zrl\/MStUp33oiE+jqWrz6dlp02cEV4s\/DrrfIDR2Ewl0C\/bzXxfZ6fCebhsDr9OSaVFJ1F+5aBFNyILEhaR0shHPBWnYvJL"};
    final response = await http.post(uri, body: body);
    print("2nd api resposne: ");
    print(body.toString());
    print(response.headers["location"].toString());
    var url = response.headers["location"].toString();


    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseEasypaisaToken(response.body);
    } else if (response.statusCode == 302) {
      // print(response.body.toString());
      return url;
      // return parseEasypaisaToken("${response.headers["location"]}");
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }

  }

  // 3rd api
  static Future<List<EasypaisaForm>> easypaisaGetLastData(url) async {
    print("turl1: $url");
    Uri uri = Uri.parse('$url');

    // "amount":"1.0","storeId":"64340","postBackURL":"http://mobicell.net/Yaseo/tApi.php","orderRefNum":"60","autoRedirect":"1","paymentMethod":"CC_PAYMENT_METHOD","emailAddr":"aazamjafferi@gmail.com","mobileNum":"03423144460","merchantHashedReq":"ZKDGdKfHJDuzIURSHleA3pEH7oCEipInC7DCLMjaRxDogiSEhmT4eFj2jx3Iya6jrSIm4NiLsXLrsA9S460E79iYLhTWCGAzZFW9kzbs7K\/MJt8+Btr\/H7dO9OP88jaPpT4McFA8VJVzv5BiSnG6spwo4RPBcn7y7zrl\/MStUp33oiE+jqWrz6dlp02cEV4s\/DrrfIDR2Ewl0C\/bzXxfZ6fCebhsDr9OSaVFJ1F+5aBFNyILEhaR0shHPBWnYvJL"};
    final response = await http.get(uri);
    print("3rd api resposne: ");
    print(response.body.toString());
    // print(response.headers["location"].toString());

    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseEasypaisaToken(response.body);
    } else if (response.statusCode == 302) {
      // print(response.body.toString());
      return parseEasypaisaToken(response.body);

      // return parseEasypaisaToken("${response.headers["location"]}");
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  //Easypaisa auth token
  static List<OrderStatus> parseEasypaisaMsg(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<OrderStatus>((json) => OrderStatus.fromJson(json))
        .toList();
  }
  static Future<List<OrderStatus>> easypaisaMsg(url) async {
    print("turl2: $url");
    Uri uri = Uri.parse('$url');

    // "amount":"1.0","storeId":"64340","postBackURL":"http://mobicell.net/Yaseo/tApi.php","orderRefNum":"60","autoRedirect":"1","paymentMethod":"CC_PAYMENT_METHOD","emailAddr":"aazamjafferi@gmail.com","mobileNum":"03423144460","merchantHashedReq":"ZKDGdKfHJDuzIURSHleA3pEH7oCEipInC7DCLMjaRxDogiSEhmT4eFj2jx3Iya6jrSIm4NiLsXLrsA9S460E79iYLhTWCGAzZFW9kzbs7K\/MJt8+Btr\/H7dO9OP88jaPpT4McFA8VJVzv5BiSnG6spwo4RPBcn7y7zrl\/MStUp33oiE+jqWrz6dlp02cEV4s\/DrrfIDR2Ewl0C\/bzXxfZ6fCebhsDr9OSaVFJ1F+5aBFNyILEhaR0shHPBWnYvJL"};
    final response = await http.get(uri);
    print("4rd api resposne: ");
    print(response.body.toString());
    // print(response.headers["location"].toString());

    if (response.statusCode == 200) {
      print(response.body.toString());
      return parseEasypaisaMsg(response.body);
    } else if (response.statusCode == 302) {
      // print(response.body.toString());
      return parseEasypaisaMsg(response.body);

      // return parseEasypaisaToken("${response.headers["location"]}");
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  //Paypal booking status update
  static List<OrderStatus> parsePaypalMsg(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<OrderStatus>((json) => OrderStatus.fromJson(json))
        .toList();
  }
  static Future<List<OrderStatus>> paypalMsg(url) async {
    print("turl2: $url");
    Uri uri = Uri.parse('$url');

    // "amount":"1.0","storeId":"64340","postBackURL":"http://mobicell.net/Yaseo/tApi.php","orderRefNum":"60","autoRedirect":"1","paymentMethod":"CC_PAYMENT_METHOD","emailAddr":"aazamjafferi@gmail.com","mobileNum":"03423144460","merchantHashedReq":"ZKDGdKfHJDuzIURSHleA3pEH7oCEipInC7DCLMjaRxDogiSEhmT4eFj2jx3Iya6jrSIm4NiLsXLrsA9S460E79iYLhTWCGAzZFW9kzbs7K\/MJt8+Btr\/H7dO9OP88jaPpT4McFA8VJVzv5BiSnG6spwo4RPBcn7y7zrl\/MStUp33oiE+jqWrz6dlp02cEV4s\/DrrfIDR2Ewl0C\/bzXxfZ6fCebhsDr9OSaVFJ1F+5aBFNyILEhaR0shHPBWnYvJL"};
    final response = await http.get(uri);
    print("4rd api resposne: ");
    print(response.body.toString());
    // print(response.headers["location"].toString());

    if (response.statusCode == 200) {
      print(response.body.toString());
      return parsePaypalMsg(response.body);
    } else if (response.statusCode == 302) {
      // print(response.body.toString());
      return parsePaypalMsg(response.body);

      // return parseEasypaisaToken("${response.headers["location"]}");
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Order Car History
  static List<OrderHistory> orderHistoryByTypeList = [];
  static Future<List<OrderHistory>> orderHistoryByType(type) async {
    orderHistoryByTypeList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=getbooking&type=$type&user_id=$userId');
    print("uri $uri");
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        orderHistoryByTypeList.add(OrderHistory.fromJson(i));
      }
      return orderHistoryByTypeList;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }
  // Order Hotel History
  static List<OrderHistory> carOrders = [];
  static Future<List<OrderHistory>> carOrderHistory() async {
    carOrders.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_carbooking&user_id=$userId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        carOrders.add(OrderHistory.fromJson(i));
      }
      return carOrders;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Order Hotel History
  static List<OrderHistory> hotelOrders = [];
  static Future<List<OrderHistory>> hotelOrderHistory() async {
    hotelOrders.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_hotelbooking&user_id=$userId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        hotelOrders.add(OrderHistory.fromJson(i));
      }
      return hotelOrders;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Order Car History
  static List<OrderHistory> guideOrders = [];
  static Future<List<OrderHistory>> guideOrderHistory() async {
    guideOrders.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_guidebooking&user_id=$userId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        guideOrders.add(OrderHistory.fromJson(i));
      }
      return guideOrders;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Order Trip History
  static List<OrderHistory> tripOrders = [];
  static Future<List<OrderHistory>> tripOrderHistory() async {
    tripOrders.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    Uri uri = Uri.parse(
        '${AppConfig.apiSrcLink}tApi.php?action=get_tripbooking&user_id=$userId');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());
      for (Map<String, dynamic> i in data) {
        tripOrders.add(OrderHistory.fromJson(i));
      }
      return tripOrders;
      // return parseCarWishListProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }



  // car recommeded for Trip
  static List<CarModel> parseCarRecommendedItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarModel>((json) => CarModel.fromJson(json)).toList();
  }
  static Future<List<CarModel>> carRecommendedItems(carLoc) async {
    print(" trips by id: $carLoc");
    print(carLoc.toString());

    print(carLoc.join(","));
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_carsByLocation&selectedTrips=${carLoc.join(",")}');

    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseHireACarProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // hotel recommeded for Trip
  static List<HotelModel> parseHotelRecommendedItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<HotelModel>((json) => HotelModel.fromJson(json)).toList();
  }
  static Future<List<HotelModel>> hotelRecommendedItems(hotelLoc) async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_hotelsByLocation&selectedTrips=${hotelLoc.join(",")}');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseHotelRecommendedItems(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // guide recommeded for Trip
  static List<TourGuideModel> parseGuideRecommendedItems(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TourGuideModel>((json) => TourGuideModel.fromJson(json)).toList();
  }
  static Future<List<TourGuideModel>> guideRecommendedItems(guideLoc) async {
    Uri uri = Uri.parse('${AppConfig.apiSrcLink}tApi.php?action=get_guideByLocation&selectedTrips=${guideLoc.join(",")}');
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body.toString());

      return parseGuideRecommendedItems(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

}
