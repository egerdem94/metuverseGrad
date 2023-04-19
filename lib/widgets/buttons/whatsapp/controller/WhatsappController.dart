import 'dart:convert';

import 'package:metuverse/user/User.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class WhatsappController{
  Future<void> launchWhatsApp(String phoneNumber, String message) async {
    final Uri url = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<String> telephoneNumberRequest(postID,token) async{
    String serviceAddress =
        "x";
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "postID": postID,
      "userToken": "",
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    if (jsonObject['statusCode'] == '1') {
      return jsonObject['phoneNumber'];
    }
    else{
      return jsonObject['statusCode'];
    }
  }
  Future<int> friendshipRequest(postID,token) async{
    String serviceAddress =
        "y";
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": User.token,
      "postID": postID,
      "userToken": "",
    });
    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);
    return int.parse(jsonObject['statusCode']);
  }

}