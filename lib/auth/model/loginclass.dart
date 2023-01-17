class login {
  bool? loginStatus;
  String? currentUserToken;

  login({this.loginStatus, this.currentUserToken});

  login.fromJson(Map<String, dynamic> json) {
    loginStatus = json['loginStatus'];
    currentUserToken = json['currentUserToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginStatus'] = this.loginStatus;
    data['currentUserToken'] = this.currentUserToken;
    return data;
  }
}
