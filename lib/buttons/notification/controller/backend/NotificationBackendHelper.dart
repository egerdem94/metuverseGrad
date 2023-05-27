import 'dart:convert';

import 'package:metuverse/buttons/notification/model/MyNotification.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/user/User.dart';
class NotificationBackendHelper{
  Future<NotificationList?> getNotifications() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/posts/userPosts_incomingRecommendedNotificationPostList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['total'] == '0'){
      return null;
    }
    NotificationList notificationList = NotificationList.fromJson(jsonObject);
    return notificationList;
  }
}