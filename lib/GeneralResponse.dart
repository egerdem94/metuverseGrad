class GeneralResponse {
  String? message;
  bool? processStatus;

  GeneralResponse({this.message, this.processStatus});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
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