class login {
  bool? loginStatus;
  String? currentUserToken;
  String? fullName;
  Null? profilePicture;

  login(
      {this.loginStatus,
        this.currentUserToken,
        this.fullName,
        this.profilePicture});

  login.fromJson(Map<String, dynamic> json) {
    loginStatus = json['loginStatus'];
    currentUserToken = json['currentUserToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginStatus'] = this.loginStatus;
    data['currentUserToken'] = this.currentUserToken;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
