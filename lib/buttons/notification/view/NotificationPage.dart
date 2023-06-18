import 'package:flutter/material.dart';
import 'package:metuverse/buttons/notification/controller/NotificationController.dart';
import 'package:metuverse/buttons/notification/model/MyNotification.dart';
import 'package:metuverse/widgets/bottom_navigation_bar.dart';

import '../../friends/view/FriendsButton.dart';

class NotificationPage extends StatefulWidget {
  final NotificationList notificationList;

  const NotificationPage({required this.notificationList});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController notificationController = NotificationController();
  List<MyNotification>? notifications;
  @override
  void initState() {
    super.initState();
    notificationController.getNotifications().then((_) {
      setState(() {
        notifications = notificationController.notificationList?.items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //final List<MyNotification>? notifications = widget.notificationList.items;

    return Scaffold(
      appBar: AppBar(
        // leading: NotificationButton(),
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        actions: [
          FriendsButton(),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications?.length ?? 0,
        itemBuilder: (context, index) {
          final notification = notifications![index];
          return NotificationItem(
            fullName: notification?.fullName ?? '',
            profilePicture: notification?.profilePicture ?? '',
            postID: notification?.postID ?? 0,
            description: notification?.description ?? '',
            pageID: 1,
            onTap: () {
              // Handle notification item tap
              // Navigate to the corresponding post screen or perform any desired action
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String fullName;
  final String? profilePicture;
  final int postID;
  final String description;
  final int pageID;
  final VoidCallback onTap;

  const NotificationItem({
    required this.fullName,
    required this.profilePicture,
    required this.postID,
    required this.description,
    required this.pageID,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profilePicture ??
            "https://www.birikikoli.com/mv_services/user/user_default_profile_picture.png"),
      ),
      title: Text(
        fullName,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        description,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
      tileColor: Colors.black,
      // Add any necessary UI elements to display the notification item
    );
  }
}
