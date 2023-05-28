class FriendList {
  List<Friend>? items;

  FriendList({this.items});

  FriendList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Friend>[];
      json['items'].forEach((v) {
        items!.add(new Friend.fromJson(v));
      });
    }
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}

class Friend {
  String? relatedUserPublicToken;
  String? fullName;
  String? profilePicture;
  String? phoneNumber;
  Friend({this.relatedUserPublicToken, this.fullName, this.profilePicture});

  Friend.fromJson(Map<String, dynamic> json) {
    relatedUserPublicToken = json['relatedUserPublicToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    phoneNumber = json['phoneNumber'];
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relatedUserPublicToken'] = this.relatedUserPublicToken;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }*/
}