
//import 'dart:ffi';
class TransportationPostsList {
  List<TransportationPost>? items;
  int? total;

  TransportationPostsList({this.items, this.total});

  TransportationPostsList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <TransportationPost>[];
      json['items'].forEach((v) {
        items!.add(new TransportationPost.fromJson(v));
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

class TransportationPost {
  bool? belongToUser; //+
  String? fullName; //+
  Null? profilePicture; //+
  int? postID; //+
  String? description; //+
  int? productPrice;
  String? currency; //+
  int? transportationStatus; //++

  TransportationPost(
      {this.belongToUser,
      this.fullName,
      this.profilePicture,
      this.postID,
      this.description,
      this.productPrice,
      this.currency,
      this.transportationStatus});

  TransportationPost.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    description = json['description'];
    productPrice = json['productPrice'];
    currency = json['currency'];
    transportationStatus = json['productStatus'];
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
    data['productStatus'] = this.transportationStatus;
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


