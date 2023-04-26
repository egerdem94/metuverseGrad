import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User{
 static late String fullName;
 static late String privateToken;
 static late String publicToken;
 static late String profilePicture;
 //static String userName = "userName";

  static void deleteUserCredentialsFromCache() {
    fullName = '';
    privateToken = '';
    publicToken = '';
    profilePicture = '';
  }
  static void insertUserCredentialsToCache(String token,String publicToken,String fullName, String? profilePicture) {
    debugPrint("token: $token");
    User.privateToken = token;
   User.publicToken = publicToken;
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
   await prefs.setString('privateToken', privateToken);
   await prefs.setString('publicToken', publicToken);
   await prefs.setString('fullName', fullName);
   await prefs.setString('profilePicture',profilePicture);
 }
 static Future<void> clearData() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.remove('privateToken');
   await prefs.remove('publicToken');
   await prefs.remove('fullName');
   await prefs.remove('profilePicture');
 }
 static Future<bool> getPreviousLoginInformation() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   privateToken = prefs.getString('privateToken') ?? '';
   publicToken = prefs.getString('publicToken') ?? '';
   fullName = prefs.getString('fullName') ?? '';
   profilePicture = prefs.getString('profilePicture') ?? '';
    if(privateToken == '' || publicToken == '' || fullName == '' || profilePicture == ''){
      return false;
    }
    else{
      return true;
    }
 }

}