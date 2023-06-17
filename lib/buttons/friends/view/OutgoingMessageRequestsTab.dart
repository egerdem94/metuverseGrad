import 'package:flutter/material.dart';
import 'package:metuverse/buttons/friends/controller/FriendsController.dart';
import 'package:metuverse/buttons/friends/model/OutgoingMessageRequest.dart';

class OutgoingMessageRequestsTab extends StatefulWidget {
  @override
  _OutgoingMessageRequestsTabState createState() =>
      _OutgoingMessageRequestsTabState();
}

class _OutgoingMessageRequestsTabState extends State<OutgoingMessageRequestsTab> {
  OutgoingMessageRequestList? outgoingMessageRequestList;
  FriendsController messageRequestController =
  FriendsController();

  @override
  initState() {
    super.initState();
    messageRequestController.handleMessageRequests('o').then((value) {
      setState(() {
        outgoingMessageRequestList =
            messageRequestController.getOutgoingMessageRequestList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // If outgoingMessageRequestList is null, show "There is nothing to display"
    if (outgoingMessageRequestList == null) {
      return Center(
        child: Text("There is nothing to display"),
      );
    }

    // If the list is not null, display the message request items
    return ListView.builder(
      itemCount: outgoingMessageRequestList!.items!.length,
      itemBuilder: (context, index) {
        OutgoingMessageRequest request =
        outgoingMessageRequestList!.items![index];
        return OutgoingMessageRequestItem(
          fullName: request.fullName!,
          profilePicture: request.getProfilePicture,
          onCancel: () async {
            var status = await messageRequestController.cancelOutgoingMessageRequest(outgoingMessageRequestList!
                .items![index].relatedUserPublicToken!);
            if(status == 1){
              setState(() {
                outgoingMessageRequestList!.items!.removeAt(index);
              });
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Something went wrong"),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class OutgoingMessageRequestItem extends StatelessWidget {
  final String fullName;
  final String profilePicture;
  final VoidCallback onCancel;

  OutgoingMessageRequestItem({
    required this.fullName,
    required this.profilePicture,
    required this.onCancel,
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
            onPressed: onCancel,
            child:
            Text('Cancel', style: TextStyle(color: Colors.redAccent[700])),
          ),
        ],
      ),
    );
  }
}