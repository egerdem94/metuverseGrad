import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/screens/auth_screens/login/model/LoginModelX.dart';
import 'package:metuverse/user/User.dart';

class LoginBackend {
  Future<LoginModelX> login(email, password) async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/user_loginProcess.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "email": email,
      "passwordHash": password,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    LoginModelX? loginObject = LoginModelX.fromJson(jsonObject);
    if (loginObject.loginStatus == true) {
      User.insertUserCredentialsToCache(
          loginObject.token ?? '',
          loginObject.publicToken ?? '',
          loginObject.fullName ?? '',
          loginObject.profilePicture,
          loginObject.userRoleID ?? '');
      User.saveData(); // TODO Should we do this here?
    }
    return loginObject;
  }
}
