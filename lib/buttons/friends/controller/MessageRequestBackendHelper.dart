import 'dart:convert';

import 'package:metuverse/user/User.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/friends/model/IncomingMessageRequest.dart';
import 'package:metuverse/buttons/friends/model/OutgoingMessageRequest.dart';
import 'package:http/http.dart' as http;

class MessageRequestBackendHelper{
  Future<IncomingMessageRequestListX?> incomingMessageRequest() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_IncomingMessageRequestList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['total'] == '0'){
      return null;
    }
    IncomingMessageRequestListX incomingMessageRequestList = IncomingMessageRequestListX.fromJson(jsonObject);
    return incomingMessageRequestList;
  }
  Future<OutgoingMessageRequestListX?> outgoingMessageRequest() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_OutgoingMessageRequestList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['total'] == '0'){
      return null;
    }
    OutgoingMessageRequestListX outgoingMessageRequestList = OutgoingMessageRequestListX.fromJson(jsonObject);
    return outgoingMessageRequestList;
  }
  Future<FriendList?> friendListRequest() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_GetList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['total'] == '0'){
      return null;
    }
    FriendList friendList = FriendList.fromJson(jsonObject);
    return friendList;
  }
  Future<bool> sendAnswerToIncomingMessageRequest(answer,otherUserToken) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_YesNoInsertRelationTable.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "relatedUserPublicToken": otherUserToken,
      "answer": answer,
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['message'] == "1"){
      return true;
    }
    else{
      return false;
    }
  }
  Future<int> cancelOutgoingRequest(otherUserToken) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/phoneAccess/phoneAccess_CancelMessageRequest.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
      "relatedUserPublicToken": otherUserToken
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['message'] == "255"){
      //Go to login page
      return 255;
    }
    else if(jsonObject['message'] == "1"){
      return 1;
    }
    else{
      return 0;
    }
  }

}