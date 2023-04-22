import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/buttons/whatsapp/model/GeneralResponse.dart';
import 'package:metuverse/widgets/buttons/whatsapp/model/PhoneNumberResponse.dart';
class PhoneNumberRelatedBackendHelper{

  Future<PhoneNumberResponse> sendPhoneNumberRequest(postID) async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_General.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "postID": postID,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = PhoneNumberResponse.fromJson(jsonObject);
    return temp;
  }
  Future<GeneralResponse> sendFriendshipRequest(relatedUserPublicToken) async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_YesInsertWaitingTable.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    debugPrint("relatedUserPublicToken: " + relatedUserPublicToken);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "relatedUserPublicToken": relatedUserPublicToken,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    var temp = GeneralResponse.fromJson(jsonObject);
    return temp;
  }

}