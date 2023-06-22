import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordBackend{

  Future<bool> sendVerificationCode(String email) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/forgetPassword/forgetPassword_verificationCode_send.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    try {
      final response = await http.post(serviceUri, body: {
        "email": email
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        if (responseBody.containsKey("processStatus") && responseBody["processStatus"] == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error occured: $e");
      return false;
    }
  }
  Future<bool> checkVerificationCode(String email,String passwordHash,String verificationCode) async{
    String serviceAddress = 'http://www.birikikoli.com/mv_services/user/forgetPassword/forgetPassword_verificationCode_check.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    try {
      final response = await http.post(serviceUri, body: {
        "email": email,
        "passwordHash": passwordHash,
        "verificationCode": verificationCode
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        if (responseBody.containsKey("processStatus") && responseBody["processStatus"] == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error occured: $e");
      return false;
    }
  }


}