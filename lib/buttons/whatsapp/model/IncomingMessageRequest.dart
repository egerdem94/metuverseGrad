class IncomingMessageRequestList {
  List<IncomingMessageRequest>? items;
  int? total;

  IncomingMessageRequestList({this.items, this.total});

  IncomingMessageRequestList.fromJson(Map<String, dynamic> json) {
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
  int? notificationType;
  String? fullName;
  String? profilePicture;

  IncomingMessageRequest(
      {this.relatedUserPublicToken,
        this.notificationType,
        this.fullName,
        this.profilePicture});

  IncomingMessageRequest.fromJson(Map<String, dynamic> json) {
    relatedUserPublicToken = json['relatedUserPublicToken'];
    notificationType = json['notificationType'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relatedUserPublicToken'] = this.relatedUserPublicToken;
    data['notificationType'] = this.notificationType;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }*/
}
