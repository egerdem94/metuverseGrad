class LogoResponse {
  String? message;
  String? fullName;
  String? profilePicture;

  LogoResponse({this.message, this.fullName, this.profilePicture});

  LogoResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
  }
}
