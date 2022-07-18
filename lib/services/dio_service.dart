

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/functions/app_config.dart';
import 'package:untitled/models/conversation_model.dart';

final Dio dio = Dio();

class DioService{

  static List<ConversationModel> parseGetChat(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ConversationModel>((json) => ConversationModel.fromJson(json)).toList();
  }
  static Future<List<ConversationModel>> getChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    var response = await dio.get('${AppConfig.apiSrcLink}tApi.php?action=get_chat&user_id=$userId');
    if(response.statusCode == 200){
      return parseGetChat(response.data);

    }
    else{
      throw "Geting msgs";
    }
  }
}