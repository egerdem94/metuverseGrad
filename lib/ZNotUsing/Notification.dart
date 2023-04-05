import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();
    // Fetch notifications from your services here
    fetchNotifications();
  }

  void fetchNotifications() async {
    List<NotificationItem> fetchedNotifications = [
      NotificationItem(
        title: 'New item for sale!',
        content: 'A new item has been posted for sale.',
        service: 'Buy and Sell',
      ),
      NotificationItem(
        title: 'New transportation post!',
        content: 'A new transportation post has been created.',
        service: 'Transportation',
      ),
    ];

    setState(() {
      notifications = fetchedNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(notifications[index].title ?? ''),
            subtitle: Text(notifications[index].content ?? ''),
            leading: Icon(
              Icons.notifications,
              color: notifications[index].service == 'Buy and Sell'
                  ? Colors.green
                  : Colors.blue,
            ),
          );
        },
      ),
    );
  }
}