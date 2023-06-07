class LoginModelX {
  bool? loginStatus;
  String? token;
  String? fullName;
  String? profilePicture;

  LoginModelX(
      {this.loginStatus,
        this.token,
        this.fullName,
        this.profilePicture});

  LoginModelX.fromJson(Map<String, dynamic> json) {
    loginStatus = json['loginStatus'];
    token = json['currentUserToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
  }

  get getFullName => this.fullName;
  get getToken => this.token;
  get getProfilePicture => this.profilePicture;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginStatus'] = this.loginStatus;
    data['currentUserToken'] = this.token;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
