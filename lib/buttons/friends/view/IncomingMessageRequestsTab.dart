import 'package:flutter/material.dart';
import 'package:metuverse/buttons/friends/controller/FriendsController.dart';
import 'package:metuverse/buttons/friends/model/IncomingMessageRequest.dart';

class IncomingMessageRequestsTab extends StatefulWidget {
  @override
  _IncomingMessageRequestsTabState createState() =>
      _IncomingMessageRequestsTabState();
}

class _IncomingMessageRequestsTabState extends State<IncomingMessageRequestsTab> {
  IncomingMessageRequestList? incomingMessageRequestList;
  FriendsController messageRequestController =
  FriendsController();

  @override
  initState() {
    super.initState();
    messageRequestController.handleMessageRequests('i').then((value) {
      setState(() {
        incomingMessageRequestList =
            messageRequestController.getIncomingMessageRequestList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // If incomingMessageRequestList is null, show "There is nothing to display"
    if (incomingMessageRequestList == null) {
      return Center(
        child: Text("There is nothing to display"),
      );
    }

    // If the list is not null, display the message request items
    return ListView.builder(
      itemCount: incomingMessageRequestList!.items!.length,
      itemBuilder: (context, index) {
        IncomingMessageRequest request =
        incomingMessageRequestList!.items![index];
        return MessageRequestItem(
          fullName: request.fullName!,
          profilePicture: request.getProfilePicture,
          onAccept: () {
            messageRequestController.messageRequestBackendHelper
                .sendAnswerToIncomingMessageRequest(
                "y",
                incomingMessageRequestList!
                    .items![index].relatedUserPublicToken!
            );
            setState(() {
              incomingMessageRequestList!.items!.removeAt(index);
            });
          },
          onDecline: () {
            messageRequestController.messageRequestBackendHelper
                .sendAnswerToIncomingMessageRequest(
                "n",
                incomingMessageRequestList!
                    .items![index].relatedUserPublicToken!);
            setState(() {
              incomingMessageRequestList!.items!.removeAt(index);
            });
          },
        );
      },
    );
  }
}

class MessageRequestItem extends StatelessWidget {
  final String fullName;
  final String profilePicture;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  MessageRequestItem({
    required this.fullName,
    required this.profilePicture,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom:
          BorderSide(color: Color.fromARGB(255, 57, 57, 57), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePicture),
            radius: 24.0,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(fullName,
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ),
          TextButton(
            onPressed: onAccept,
            child: Text('Accept',
                style: TextStyle(color: Colors.greenAccent[700])),
          ),
          SizedBox(width: 8.0),
          TextButton(
            onPressed: onDecline,
            child:
            Text('Decline', style: TextStyle(color: Colors.redAccent[700])),
          ),
        ],
      ),
    );
  }
}