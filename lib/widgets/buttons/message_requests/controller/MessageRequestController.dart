import 'package:metuverse/widgets/buttons/message_requests/controller/MessageRequestBackendHelper.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/IncomingMessageRequest.dart';

class MessageRequestController{
  MessageRequestBackendHelper messageRequestBackendHelper = MessageRequestBackendHelper();
  IncomingMessageRequestListX? incomingMessageRequestList;

  Future<void> handleMessageRequests(incomingOrOutgoing) async {
    incomingMessageRequestList = await messageRequestBackendHelper.incomingMessageRequest();
  }
  IncomingMessageRequestListX? getIncomingMessageRequestList(){
    return incomingMessageRequestList;
  }
}