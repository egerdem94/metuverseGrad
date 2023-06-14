import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:metuverse/buttons/whatsapp/model/GeneralResponse.dart';
import 'package:metuverse/user/User.dart';

class TransportationOverflowBackend{
  Future<bool> deletePostRequest(postID) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/all/all_deletePost.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "postID": postID
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = GeneralResponse.fromJson(jsonObject);
    if(temp.message == "1"){
      return true;
    }
    return false;
  }
  Future<bool> selectAsFoundRequest(postID) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/postPage/buyandsell/buyandsell_switchProductStatus.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "postID": postID
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = GeneralResponse.fromJson(jsonObject);
    if(temp.message == "1"){
      return true;
    }
    return false;
  }
}