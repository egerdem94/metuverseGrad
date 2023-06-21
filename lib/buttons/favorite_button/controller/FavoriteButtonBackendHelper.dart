import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:metuverse/buttons/whatsapp/model/GeneralResponse.dart';
import 'package:metuverse/user/User.dart';

class FavoriteButtonBackendHelper{
  Future<bool> toggleFavoriteRequest(postID, previousCondition) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/all/all_addandremoveFavoritePost.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "postID": postID.toString()
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = GeneralResponse.fromJson(jsonObject);
    if(temp.message == "1" && previousCondition == false){
      return true;
    }
    else if(temp.message == "2" && previousCondition == true){
      return true;
    }
    else return false;
  }
}