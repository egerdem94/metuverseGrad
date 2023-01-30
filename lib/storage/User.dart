class User{
 static late String fullName;
 static late String token;
 static late String profilePicture;

  static void logout() {
    fullName = '';
    token = '';
    profilePicture = '';
  }

}