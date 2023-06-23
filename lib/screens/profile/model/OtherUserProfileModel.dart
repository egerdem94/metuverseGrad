class OtherUserProfileModel {
  bool? isFriend;
  String? fullName;
  String? profilePicture;
  String? phoneNumber;
  String? message;

  OtherUserProfileModel(
      {this.isFriend,
        this.fullName,
        this.profilePicture,
        this.phoneNumber,
        this.message});

  OtherUserProfileModel.fromJson(Map<String, dynamic> json) {
    isFriend = json['isFriend'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    phoneNumber = json['phoneNumber'];
    message = json['message'];
  }
}
