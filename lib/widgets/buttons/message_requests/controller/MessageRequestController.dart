import 'package:metuverse/widgets/buttons/message_requests/controller/MessageRequestBackendHelper.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/IncomingMessageRequest.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/OutgoingMessageRequest.dart';

class MessageRequestController{
  MessageRequestBackendHelper messageRequestBackendHelper = MessageRequestBackendHelper();
  IncomingMessageRequestListX? incomingMessageRequestList;
  OutgoingMessageRequestListX? outgoingMessageRequestsList;

  Future<void> handleMessageRequests(incomingOrOutgoing) async {
    if(incomingOrOutgoing == "o"){
      outgoingMessageRequestsList = await messageRequestBackendHelper.outgoingMessageRequest();
    }
    else if(incomingOrOutgoing == "i"){
      incomingMessageRequestList = await messageRequestBackendHelper.incomingMessageRequest();
    }
  }
  IncomingMessageRequestListX? getIncomingMessageRequestList(){
    return incomingMessageRequestList;
  }
  OutgoingMessageRequestListX? getOutgoingMessageRequestList(){
    return outgoingMessageRequestsList;
  }

  Future<int> cancelOutgoingMessageRequest(String s) async{
    return await messageRequestBackendHelper.cancelOutgoingRequest(s);
  }

}