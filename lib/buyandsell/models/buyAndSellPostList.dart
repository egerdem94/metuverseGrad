//import 'dart:ffi';

class buyandsellPostsList {
  List<SinglePostItem>? items;
  int? total;

  buyandsellPostsList({this.items, this.total});

  buyandsellPostsList.fromJson(Map<String, dynamic> json) {
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
  bool? belongToUser;
  String? fullName;
  String? profilePicture;
  int? postID;
  String? description;
  int? productPrice;
  String? currency;
  int? productStatus;

  SinglePostItem(
      {this.belongToUser,
      this.fullName,
      this.profilePicture,
      this.postID,
      this.description,
      this.productPrice,
      this.currency,
      this.productStatus});

  List<String> mediaList(){
    List<String> mediaList = [];
    if (this.profilePicture != null) {
      mediaList.add(this.profilePicture!);
    }
    else{
      mediaList.add("https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp");
    }
    return mediaList;
  }

  SinglePostItem.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
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
    data['description'] = this.description;
    data['productPrice'] = this.productPrice;
    data['currency'] = this.currency;
    data['productStatus'] = this.productStatus;
    return data;
  }

}

class SinglePostSendingItem {
  String? description;
  String? productPrice;
  String? currency;

  SinglePostSendingItem({
    this.description,
    this.productPrice,
    this.currency,
  });
}
