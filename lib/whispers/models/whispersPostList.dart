//import 'dart:ffi';

class WhispersPostList {
  List<Post>? items;
  int? total;

  WhispersPostList({this.items, this.total});

  WhispersPostList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Post>[];
      json['items'].forEach((v) {
        items!.add(new Post.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Post {
  bool? belongToUser;
  String? fullName;
  String? profilePicture;
  int? postID;
  String? media;
  String? description;

  Post({
    this.belongToUser,
    this.fullName,
    this.profilePicture,
    this.postID,
    this.media,
    this.description,
  });

  List<String> mediaList() {
    List<String> mediaList = [];
    if (this.media != null) {
      mediaList.add(this.media!);
    } else {
      mediaList.add(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s");
    }
    return mediaList;
  }

  String getProfilePicture() {
    if (this.profilePicture != null) {
      return this.profilePicture!;
    } else {
      //return "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
      return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s";
    }
  }

  Post.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    media = json['media'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['belongToUser'] = this.belongToUser;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['postID'] = this.postID;
    data['media'] = this.media;
    data['description'] = this.description;

    return data;
  }
}
