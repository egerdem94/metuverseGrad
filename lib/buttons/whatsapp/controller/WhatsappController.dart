import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/whatsapp/controller/PhoneNumberRelatedBackendHelper.dart';
import 'package:metuverse/buttons/whatsapp/model/PhoneNumberResponse.dart';
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
  Future phoneNumberProcedure2(BuildContext context, Friend friend) async {
    if (friend.phoneNumber != null) {
      var greeting = "Hey " + friend.fullName!.split(" ")[0] + "!";
      launchWhatsApp(friend.phoneNumber!, greeting);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("No Phone Number"),
            content: Text("${friend.fullName} doesn't have a phone number."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}