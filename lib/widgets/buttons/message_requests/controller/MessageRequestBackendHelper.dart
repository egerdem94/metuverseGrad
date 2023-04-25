import 'dart:convert';

import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/IncomingMessageRequest.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/OutgoingMessageRequest.dart';
import 'package:metuverse/widgets/buttons/whatsapp/model/IncomingMessageRequest.dart';
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
}