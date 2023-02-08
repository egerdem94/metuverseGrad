import 'package:metuverse/storage/db_example/DatabaseHelper.dart';

class NewBuySellPostListX {
  List<NewBuySellPostX>? newBuySellPostListX;
  int? total;

  NewBuySellPostListX({this.newBuySellPostListX, this.total});

  NewBuySellPostListX.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      newBuySellPostListX = <NewBuySellPostX>[];
      json['items'].forEach((v) {
        newBuySellPostListX!.add(new NewBuySellPostX.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newBuySellPostListX != null) {
      data['items'] = this.newBuySellPostListX!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class NewBuySellPostX {
  bool? belongToUser;
  String? fullName;
  String? profilePicture;
  int? postID;
  int? updateVersion;
  String? media;
  String? description;
  int? productPrice;
  String? currency;
  int? productStatus;

  NewBuySellPostX(
      {this.belongToUser,
        this.fullName,
        this.profilePicture,
        this.postID,
        this.updateVersion,
        this.media,
        this.description,
        this.productPrice,
        this.currency,
        this.productStatus});

  NewBuySellPostX.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
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
    data['updateVersion'] = this.updateVersion;
    data['media'] = this.media;
    data['description'] = this.description;
    data['productPrice'] = this.productPrice;
    data['currency'] = this.currency;
    data['productStatus'] = this.productStatus;
    return data;
  }
  // Converts a NewBuySellPostX object into a Map object
  Map<String, dynamic> toDbMap() {
    return {
      DatabaseHelper.columnPostID: postID,
      DatabaseHelper.columnFullName: fullName,
      DatabaseHelper.columnProfilePicture: profilePicture,
      DatabaseHelper.columnBelongToUser: belongToUser,
      DatabaseHelper.columnUpdateVersion: updateVersion,
      DatabaseHelper.columnMedia: media,
      DatabaseHelper.columnDescription: description,
      DatabaseHelper.columnProductPrice: productPrice,
      DatabaseHelper.columnCurrency: currency,
      DatabaseHelper.columnProductStatus: productStatus,
    };
  }
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
      //return "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
      return "http://birikikoli.com/images/blank-profile-picture.jpg";
    }
  }
}