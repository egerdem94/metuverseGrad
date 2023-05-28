import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:metuverse/buttons/friends/controller/FriendsController.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/friends/view/FriendsPage.dart';
import 'package:metuverse/buttons/whatsapp/view/WhatsappButton2.dart';
import 'package:metuverse/screens/profile/screens/OtherUserProfilePage.dart';

class FriendListTab extends StatefulWidget {
  FriendListTab();

  @override
  _FriendListTabState createState() => _FriendListTabState();
}

class _FriendListTabState extends State<FriendListTab> {
  FriendList? friendList;
  FriendsController messageRequestController = FriendsController();

  @override
  void initState() {
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
            backgroundImage: NetworkImage(friend.profilePicture ??
                "https://www.birikikoli.com/mv_services/user/user_default_profile_picture.png"),
          ),
          title: Text(friend.fullName!),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              WhatsappButton2(friend: friend),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  _showRemoveFriendDialog(friend, index,() {
                    setState(() {
                      friendList!.items!.removeAt(index);
                    });
                  });
                },
                child: Text("Remove Friend"),
              ),
            ],
          ),
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

  void _showRemoveFriendDialog(Friend friend, int index,Function function) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove Friend"),
          content: Text("Are you sure you want to remove ${friend.fullName}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _removeFriend(friend).then((isRemoved) {
                  if (isRemoved) {
                    function();
                  }
                  Navigator.of(context).pop();
                });
              },
              child: Text("Remove"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _removeFriend(Friend friend) async {
    return await messageRequestController.removeFriend(friend.relatedUserPublicToken);
  }
}
