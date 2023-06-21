class LoginModelX {
  bool? loginStatus;
  String? token;
  String? fullName;
  String? profilePicture;
  String? publicToken;
  int? userRoleID;

  LoginModelX(
      {this.loginStatus, this.token, this.fullName, this.profilePicture, this.publicToken, this.userRoleID});

  LoginModelX.fromJson(Map<String, dynamic> json) {
    loginStatus = json['loginStatus'];
    token = json['currentUserToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    publicToken = json['publicToken'];
    userRoleID = json['userRoleID'];
  }

  get getFullName => this.fullName;
  get getToken => this.token;
  get getProfilePicture => this.profilePicture;
  get getPublicToken => this.publicToken;
  get getUserRoleID => this.userRoleID;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginStatus'] = this.loginStatus;
    data['currentUserToken'] = this.token;
    data['fullName'] = this.fullName;
    data['profilePicture'] = this.profilePicture;
    data['publicToken'] = this.publicToken;
    data['getUserRoleID'] = this.getUserRoleID;
    return data;
  }
}
