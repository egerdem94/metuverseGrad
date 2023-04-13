import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:metuverse/login/model/LoginModelX.dart';
import 'package:metuverse/storage/User.dart';
class LoginBackend{
  Future<LoginModelX> login(email,password) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user_login.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "email": email,
      "passwordHash": password,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    LoginModelX? loginObject = LoginModelX.fromJson(jsonObject);
    if(loginObject.loginStatus == true){
      User.insertUserCredentials(
          loginObject.token ?? '',
          loginObject.fullName ?? '',
          loginObject.profilePicture);
    }
    return loginObject;
  }

}