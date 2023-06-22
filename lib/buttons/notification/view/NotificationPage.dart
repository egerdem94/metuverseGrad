import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/notification/controller/NotificationController.dart';
import 'package:metuverse/buttons/notification/model/MyNotification.dart';
import 'package:metuverse/buttons/notification/view/ReportPage.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellNotificationPage.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';

import '../../friends/view/FriendsButton.dart';

class NotificationPage extends StatefulWidget {

  const NotificationPage();

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
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
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
          if (User.userRoleID == 0)
            TextButton(
              onPressed: () {
                Get.to(ReportPage());
              },
              child: Text(
                "Admin Panel",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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
              if(notification.pageID == 201 || notification.pageID == 202){
                var buyOrSell = notification.pageID == 201?'s':'b';
                /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuySellNotificationPage(buyOrSell: buyOrSell, postID: notification.postID!,
                        )));*/
                Get.to(BuySellNotificationPage(buyOrSell: buyOrSell, postID: notification.postID!));
              }
            },
          );
        },
      ),
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,),
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
    );
  }
}
