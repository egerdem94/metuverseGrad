import 'package:shared_preferences/shared_preferences.dart';

class User{
 static late String fullName;
 static late String token;
 static late String profilePicture;
 static String userName = "userName";

  static void deleteUserCredentialsFromCache() {
    fullName = '';
    token = '';
    profilePicture = '';
  }
  static void insertUserCredentialsFromCache(String token, String fullName, String? profilePicture) {
   User.token = token;
   User.fullName = fullName;
   if(profilePicture != null) {
     User.profilePicture = profilePicture;
   }
   else{
     User.profilePicture = "http://birikikoli.com/images/blank-profile-picture.jpg";
   }
 }
 static void saveData() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('userToken', token);
   await prefs.setString('fullName', fullName);
   await prefs.setString('profilePicture',profilePicture);
   await prefs.setString('userName', userName);
 }
 static Future<void> clearData() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.remove('userToken');
   await prefs.remove('fullName');
   await prefs.remove('profilePicture');
   await prefs.remove('userName');
 }
 static Future<bool> checkLoginStatus() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('userToken');
   String? fullName = prefs.getString('fullName');
   String? profilePicture = prefs.getString('profilePicture');
   String? userName = prefs.getString('userName');

   if (token != null && fullName != null && profilePicture != null && userName != null) {
     return true;
   } else {
     return false;
   }
 }

}