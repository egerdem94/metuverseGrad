import 'package:flutter/foundation.dart';
import 'package:metuverse/storage/database/database_helper_parent/DatabaseHelperParent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static late String fullName;
  static late String privateToken;
  static late String publicToken;
  static late String profilePicture;
  static late int userRoleID;
  static DatabaseHelperParent dbHelper = DatabaseHelperParent();
  //static String userName = "userName";

  static Future<void> logout() async {
    fullName = '';
    privateToken = '';
    publicToken = '';
    profilePicture = '';
    userRoleID = -1;
    await (User.clearData());
    await dbHelper.init();
    await dbHelper.clearDatabase();
  }

  static void insertUserCredentialsToCache(String token, String publicToken,
      String fullName, String? profilePicture, userRoleID) {
    debugPrint("token: $token");
    User.privateToken = token;
    User.publicToken = publicToken;
    User.fullName = fullName;
    User.userRoleID = userRoleID;
    if (profilePicture != null) {
      User.profilePicture = profilePicture;
    } else {
      User.profilePicture =
          "http://birikikoli.com/images/blank-profile-picture.jpg";
    }
  }

  static void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateToken', privateToken);
    await prefs.setString('publicToken', publicToken);
    await prefs.setString('fullName', fullName);
    await prefs.setString('profilePicture', profilePicture);
    await prefs.setInt('userRoleID', userRoleID);
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privateToken');
    await prefs.remove('publicToken');
    await prefs.remove('fullName');
    await prefs.remove('profilePicture');
    await prefs.remove('userRoleID');
  }

  static Future<bool> getPreviousLoginInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateToken = prefs.getString('privateToken') ?? '';
    publicToken = prefs.getString('publicToken') ?? '';
    fullName = prefs.getString('fullName') ?? '';
    profilePicture = prefs.getString('profilePicture') ?? '';
    userRoleID = prefs.getInt('userRoleID') ?? -1;
    if (privateToken == '' ||
        publicToken == '' ||
        fullName == '' ||
        //profilePicture == '' ||
        userRoleID == -1) {
      return false;
    } else {
      return true;
    }
  }
}
