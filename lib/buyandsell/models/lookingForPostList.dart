class lookingForList {
  List<SinglePostItem>? items;
  int? total;

  lookingForList({this.items, this.total});

  lookingForList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SinglePostItem>[];
      json['items'].forEach((v) {
        items!.add(new SinglePostItem.fromJson(v));
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

class SinglePostItem {
  String? fullName;
  Null? profilePicture;
  int? postID;
  String? description;
  int? productStatus;

  SinglePostItem(
      {this.fullName,
      this.profilePicture,
      this.postID,
      this.description,
      this.productStatus});

  SinglePostItem.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    description = json['description'];

    productStatus = json['productStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['postID'] = this.postID;
    data['description'] = this.description;
    data['productStatus'] = this.productStatus;
    return data;
  }
}
