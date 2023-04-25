import 'package:flutter/material.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/buttons/message_requests/controller/MessageRequestController.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/IncomingMessageRequest.dart';
import 'package:metuverse/widgets/buttons/message_requests/model/OutgoingMessageRequest.dart';
import 'package:metuverse/widgets/drawer.dart';

class MessageRequestsPage extends StatefulWidget {
  @override
  _MessageRequestsPageState createState() => _MessageRequestsPageState();
}

class _MessageRequestsPageState extends State<MessageRequestsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message Requests"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Incoming"),
            Tab(text: "Outgoing"),
          ],
        ),
      ),
      drawer: MetuverseDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          IncomingMessageRequests(),
          OutgoingMessageRequests(),
        ],
      ),
    );
  }
}

class IncomingMessageRequests extends StatefulWidget {
  @override
  _IncomingMessageRequestsState createState() =>
      _IncomingMessageRequestsState();
}

class _IncomingMessageRequestsState extends State<IncomingMessageRequests> {
  IncomingMessageRequestListX? incomingMessageRequestList;
  MessageRequestController messageRequestController =
      MessageRequestController();

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
          profilePicture: User.profilePicture,
          //TODO resim null gelince patliyor
          onAccept: () {
            messageRequestController.messageRequestBackendHelper
                .sendAnswerToIncomingMessageRequest(
                    "y",
                    incomingMessageRequestList!
                        .items![index].relatedUserPublicToken!);
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

class OutgoingMessageRequests extends StatefulWidget {
  @override
  _OutgoingMessageRequestsState createState() =>
      _OutgoingMessageRequestsState();
}

class _OutgoingMessageRequestsState extends State<OutgoingMessageRequests> {
  OutgoingMessageRequestListX? outgoingMessageRequestList;
  MessageRequestController messageRequestController =
      MessageRequestController();

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
          profilePicture: User.profilePicture,
          onCancel: () {
            messageRequestController.cancelOutgoingMessageRequest(outgoingMessageRequestList!
                    .items![index].relatedUserPublicToken!);
            setState(() {
              outgoingMessageRequestList!.items!.removeAt(index);
            });
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
