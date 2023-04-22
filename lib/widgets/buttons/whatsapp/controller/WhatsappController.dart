import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/widgets/buttons/whatsapp/controller/PhoneNumberRelatedBackendHelper.dart';
import 'package:metuverse/widgets/buttons/whatsapp/model/PhoneNumberResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappController{
  PhoneNumberRelatedBackendHelper phoneNumberRelatedBackendHelper = PhoneNumberRelatedBackendHelper();

  Future<void> launchWhatsApp(String phoneNumber, String message) async {
    final Uri url = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
    launchUrl(url, mode: LaunchMode.externalApplication);
  }
  Future phoneNumberProcedure(BuildContext context,BasePost post) async {
    PhoneNumberResponse phoneNumberResponse =
    await phoneNumberRelatedBackendHelper.sendPhoneNumberRequest(post.postID.toString());
    if (phoneNumberResponse.message == '1' ||
        phoneNumberResponse.message == '2') {
      launchWhatsApp(phoneNumberResponse.relatedPhoneNumber!,
          "I'm interested in your post having description: " + post.description!);
    } else {
      // Display a dialog asking if the user wants to send a friendship request
      showDialog(
        context: context, // Make sure to pass the BuildContext 'context' to this function
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Send Friendship Request'),
            content: Text(
                'Do you want to send a friendship request to this user?'),
            actions: [
              TextButton(
                onPressed: () async {
                  // Send friendship request if the user clicks "Yes"
                  await phoneNumberRelatedBackendHelper
                      .sendFriendshipRequest(
                      phoneNumberResponse.relatedUserPublicToken);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  // Do nothing if the user clicks "No"
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );
    }
  }
}