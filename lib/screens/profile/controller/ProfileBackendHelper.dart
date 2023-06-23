import 'dart:convert';

import 'package:metuverse/buttons/whatsapp/model/GeneralResponse.dart';
import 'package:metuverse/screens/profile/model/OtherUserProfileModel.dart';
import 'package:metuverse/user/User.dart';
import 'package:http/http.dart' as http;

class ProfileBackendHelper{
  Future<OtherUserProfileModel?> getProfileInfo(relatedUserPublicToken) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/user_otherUserProfile.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "relatedUserPublicToken": relatedUserPublicToken
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = OtherUserProfileModel.fromJson(jsonObject);
    if(temp.message == "1"){
      return temp;
    }
    return null;
  }
  Future<bool> addFriend(relatedUserPublicToken) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_YesInsertWaitingTable.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "relatedUserPublicToken": relatedUserPublicToken
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var general = GeneralResponse.fromJson(jsonObject);
    if(general.message == "1"){
      return true;
    }
    return false;
  }
  Future<bool> removeFriend(relatedUserPublicToken) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_RemoveFriend.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "relatedUserPublicToken": relatedUserPublicToken
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var general = GeneralResponse.fromJson(jsonObject);
    if(general.message == "1"){
      return true;
    }
    return false;
  }
}