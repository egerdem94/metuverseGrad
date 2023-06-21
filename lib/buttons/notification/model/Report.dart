class ReportList {
  List<Report>? items;
  int? total;
  String? message;

  ReportList({this.items, this.total, this.message});

  ReportList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Report>[];
      json['items'].forEach((v) {
        items!.add(new Report.fromJson(v));
      });
    }
    total = json['total'];
    message = json['message'];
  }
}

class Report {
  String? fullName;
  String? profilePicture;
  int? postID;
  int? pageID;
  int? reportReasonID;
  String? reportingUserPublicToken;

  Report(
      {this.fullName,
        this.profilePicture,
        this.postID,
        this.pageID,
        this.reportReasonID,
        this.reportingUserPublicToken});

  Report.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    pageID = json['pageID'];
    reportReasonID = json['reportReasonID'];
    reportingUserPublicToken = json['reportingUserPublicToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['postID'] = this.postID;
    data['pageID'] = this.pageID;
    data['reportReasonID'] = this.reportReasonID;
    data['reportingUserPublicToken'] = this.reportingUserPublicToken;
    return data;
  }
}
