import 'package:metuverse/buttons/notification/controller/backend/NotificationBackendHelper.dart';
import 'package:metuverse/buttons/notification/model/MyNotification.dart';

class NotificationController{
  NotificationBackendHelper notificationBackendHelper = NotificationBackendHelper();
  NotificationList? notificationList;
  Future getNotifications() async{
    notificationList = await notificationBackendHelper.getNotifications();
  }
}