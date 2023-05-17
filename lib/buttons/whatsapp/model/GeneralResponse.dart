class GeneralResponse {
  //TODO Yavuz Move this file to the general model folder
  //message = 1 success
  String? message;

  GeneralResponse({this.message});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
