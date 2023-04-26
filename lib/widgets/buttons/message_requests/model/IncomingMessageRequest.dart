class IncomingMessageRequestListX {
  List<IncomingMessageRequest>? items;
  int? total;

  IncomingMessageRequestListX({this.items, this.total});

  IncomingMessageRequestListX.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <IncomingMessageRequest>[];
      json['items'].forEach((v) {
        items!.add(new IncomingMessageRequest.fromJson(v));
      });
    }
    total = json['total'];
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }*/
}

class IncomingMessageRequest {
  String? relatedUserPublicToken;
  String? fullName;
  String? profilePicture;
  String? requestAndResponseDate;

  IncomingMessageRequest(
      {this.relatedUserPublicToken,
        this.fullName,
        this.profilePicture,
        this.requestAndResponseDate});

  IncomingMessageRequest.fromJson(Map<String, dynamic> json) {
    relatedUserPublicToken = json['relatedUserPublicToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    requestAndResponseDate = json['requestAndResponseDate'];
  }
  String get getProfilePicture{
    if(profilePicture == null){
      return "https://www.birikikoli.com/mv_services/user/user_default_profile_picture.png";
    }
    else{
      return profilePicture!;
    }
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relatedUserPublicToken'] = this.relatedUserPublicToken;
    data['notificationType'] = this.notificationType;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['requestAndResponseDate'] = this.requestAndResponseDate;
    return data;
  }*/
}
