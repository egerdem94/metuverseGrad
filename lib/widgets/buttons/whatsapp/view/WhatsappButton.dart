import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/storage/models/BasePost.dart';
import 'package:metuverse/widgets/buttons/whatsapp/controller/WhatsappController.dart';

class WhatsappButton extends StatelessWidget {
   WhatsappButton({
    super.key,
    required this.post,
  });

  final BasePost post;
  final WhatsappController whatsappController = WhatsappController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        MdiIcons.whatsapp,
        color: Colors.white,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Send Request'),
              content: Text(
                  'Do you want to send a request to ${post.fullName}?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Replace the following line with the user's phone number
                    final String phoneNumber =
                        '+905385288785'; // User's phone number
                    final String message = 'Ege amk.';
                    if (phoneNumber.isNotEmpty) {
                      whatsappController.launchWhatsApp(phoneNumber, message);
                      Navigator.of(context).pop(); // Close the dialog
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please enter a valid phone number'),
                        ),
                      );
                    }
                  },
                  child: Text('Send Request'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}