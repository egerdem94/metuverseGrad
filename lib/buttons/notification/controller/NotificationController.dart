import 'package:metuverse/buttons/notification/controller/backend/NotificationBackendHelper.dart';
import 'package:metuverse/buttons/notification/model/MyNotification.dart';
import 'package:metuverse/buttons/notification/model/Report.dart';

class NotificationController{
  NotificationBackendHelper notificationBackendHelper = NotificationBackendHelper();
  NotificationList? notificationList;
  ReportList? reportList;
  Future getNotifications() async{
    notificationList = await notificationBackendHelper.getNotifications();
  }
  Future getReports() async{
    reportList = await notificationBackendHelper.getReports();
  }

  String extractReportReason(int reportReasonID){
    List<String> reportReasons = ['Spam', 'Bad word', 'Sexual content', 'Racism'];
    if(reportReasonID > reportReasons.length) return 'Other';
    return reportReasons[reportReasonID];
  }
}