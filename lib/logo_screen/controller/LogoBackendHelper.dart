import 'dart:convert';

import 'package:metuverse/logo_screen/model/LogoResponse.dart';
import 'package:metuverse/user/User.dart';
import 'package:http/http.dart' as http;

class LogoBackendHelper{
  Future<bool> validateToken() async {
    bool previousDataExists = await User.getPreviousLoginInformation();
    if(!previousDataExists) {
      return false;
    }
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/user/user_Logo_tokenControl.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.privateToken,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if(jsonObject['message'] == "1"){
      LogoResponse logoResponse = LogoResponse.fromJson(jsonObject);
      User.fullName = logoResponse.fullName ?? ""; //never intended to be null
      User.profilePicture = logoResponse.profilePicture ?? ""; //can be null
      return true;
    }
    else{
      return false;
    }

  }
}