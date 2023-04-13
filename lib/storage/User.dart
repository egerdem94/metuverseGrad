class User{
 static late String fullName;
 static late String token;
 static late String profilePicture;
 static String username = "username";

  static void deleteUserCredentials() {
    fullName = '';
    token = '';
    profilePicture = '';
  }
  static void insertUserCredentials(String token, String fullName, String? profilePicture) {
   User.token = token;
   User.fullName = fullName;
   if(profilePicture != null) {
     User.profilePicture = profilePicture;
   }
   else{
     User.profilePicture = "http://birikikoli.com/images/blank-profile-picture.jpg";
   }
 }

}