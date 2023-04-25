class OutgoingMessageRequestListX {
  List<OutgoingMessageRequest>? items;
  int? total;

  OutgoingMessageRequestListX({this.items, this.total});

  OutgoingMessageRequestListX.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OutgoingMessageRequest>[];
      json['items'].forEach((v) {
        items!.add(new OutgoingMessageRequest.fromJson(v));
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

class OutgoingMessageRequest {
  String? relatedUserPublicToken;
  String? fullName;
  String? profilePicture;
  String? requestAndResponseDate;

  OutgoingMessageRequest(
      {this.relatedUserPublicToken,
        this.fullName,
        this.profilePicture,
        this.requestAndResponseDate});

  OutgoingMessageRequest.fromJson(Map<String, dynamic> json) {
    relatedUserPublicToken = json['relatedUserPublicToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    requestAndResponseDate = json['requestAndResponseDate'];
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relatedUserPublicToken'] = this.relatedUserPublicToken;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['requestAndResponseDate'] = this.requestAndResponseDate;
    return data;
  }*/
}
