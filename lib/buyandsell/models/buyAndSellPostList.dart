//import 'dart:ffi';

class BuySellPostList {
  List<Post>? items;
  int? total;

  BuySellPostList({this.items, this.total});

  BuySellPostList.fromJson(Map<String, dynamic> json) {
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
  int? productPrice;
  String? currency;
  int? productStatus;

  Post(
      {this.belongToUser,
      this.fullName,
      this.profilePicture,
      this.postID,
      this.media,
      this.description,
      this.productPrice,
      this.currency,
      this.productStatus});

  List<String> mediaList(){
    List<String> mediaList = [];
    if (this.media != null) {
      mediaList.add(this.media!);
    }
    else{
      mediaList.add("https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp");
    }
    return mediaList;
  }
  String getProfilePicture(){
    if (this.profilePicture != null) {
      return this.profilePicture!;
    }
    else{
      return "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
    }
  }

  Post.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    media = json['media'];
    description = json['description'];
    productPrice = json['productPrice'];
    currency = json['currency'];
    productStatus = json['productStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['belongToUser'] = this.belongToUser;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['postID'] = this.postID;
    data['media'] = this.media;
    data['description'] = this.description;
    data['productPrice'] = this.productPrice;
    data['currency'] = this.currency;
    data['productStatus'] = this.productStatus;
    return data;
  }

}

class PostItem {
  String? description;
  String? productPrice;
  String? currency;

  PostItem({
    this.description,
    this.productPrice,
    this.currency,
  });
}
