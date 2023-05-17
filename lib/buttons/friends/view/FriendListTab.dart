import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:metuverse/buttons/friends/controller/MessageRequestController.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/whatsapp/view/WhatsappButton2.dart';
import 'package:metuverse/screens/profile/screens/OtherUserProfilePage.dart';

class FriendListTab extends StatefulWidget {
  @override
  _FriendListTabState createState() => _FriendListTabState();
}

class _FriendListTabState extends State<FriendListTab> {
  FriendList? friendList;
  MessageRequestController messageRequestController =
  MessageRequestController();

  @override
  initState() {
    super.initState();
    messageRequestController.getFriendsList().then((value) {
      setState(() {
        friendList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (friendList == null) {
      return Center(
        child: Text("There is nothing to display"),
      );
    }

    return ListView.builder(
      itemCount: friendList!.items!.length,
      itemBuilder: (context, index) {
        Friend friend = friendList!.items![index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(friend.profilePicture ?? "https://www.birikikoli.com/mv_services/user/user_default_profile_picture.png"),
          ),
          title: Text(friend.fullName!),
          trailing: WhatsappButton2(friend: friend,),
          onTap: () {
            Get.to(OtherUserProfilePage(
              userFullName: friend.fullName,
              profilePicture: friend.profilePicture,
            ));
          },
        );
      },
    );
  }
}
