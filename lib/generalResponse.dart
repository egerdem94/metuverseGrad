class generalResponse {
  String? message;
  bool? processStatus;

  generalResponse({this.message, this.processStatus});

  generalResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    processStatus = json['processStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['processStatus'] = this.processStatus;
    return data;
  }
}