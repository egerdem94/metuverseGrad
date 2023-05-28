import 'package:metuverse/buttons/friends/controller/FriendsBackendHelper.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/friends/model/IncomingMessageRequest.dart';
import 'package:metuverse/buttons/friends/model/OutgoingMessageRequest.dart';

class FriendsController{
  FriendsBackendHelper messageRequestBackendHelper = FriendsBackendHelper();
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

  Future<FriendList?> getFriendsList() async {
    return await messageRequestBackendHelper.friendListRequest();
  }
  Future<bool> removeFriend(otherUserToken) async {
    return await messageRequestBackendHelper.removeFriend(otherUserToken);
  }
}