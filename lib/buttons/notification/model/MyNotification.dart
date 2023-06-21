class NotificationList {
  List<MyNotification>? items;
  int? total;
  String? message;

  NotificationList({this.items, this.total, this.message});

  NotificationList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <MyNotification>[];
      json['items'].forEach((v) {
        items!.add(new MyNotification.fromJson(v));
      });
    }
    total = json['total'];
    message = json['message'];
  }
}

class MyNotification {
  String? fullName;
  String? profilePicture;
  int? postID;
  String? description;
  int? pageID;

  MyNotification(
      {this.fullName,
        this.profilePicture,
        this.postID,
        this.description,
        this.pageID});

  MyNotification.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    description = json['description'];
    pageID = json['pageID'];
  }
}
