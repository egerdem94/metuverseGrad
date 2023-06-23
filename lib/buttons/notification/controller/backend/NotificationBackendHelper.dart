import 'dart:convert';

import 'package:metuverse/buttons/notification/model/MyNotification.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/buttons/notification/model/Report.dart';
import 'package:metuverse/user/User.dart';
class NotificationBackendHelper{
  Future<NotificationList> getNotifications() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/posts/userPosts_incomingRecommendedNotificationPostList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['total'] == '0'){
      NotificationList.empty();
    }
    NotificationList notificationList = NotificationList.fromJson(jsonObject);
    return notificationList;
  }

  Future<ReportList> getReports() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/admin/report/report_getReportList.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['total'] == '0'){
      return ReportList.empty();
    }
    ReportList reportList = ReportList.fromJson(jsonObject);
    return reportList;
  }

}