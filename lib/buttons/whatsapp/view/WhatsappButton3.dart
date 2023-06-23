import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/whatsapp/controller/WhatsappController.dart';

class WhatsappButton3 extends StatelessWidget {
  WhatsappButton3({
    super.key, required this.phoneNumber, required this.isFriend,
  });

  final String phoneNumber;
  final bool isFriend;
  final WhatsappController whatsappController = WhatsappController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        MdiIcons.whatsapp,
        color: Colors.green,
      ),
      onPressed: () {
        if(phoneNumber != "")
          whatsappController.phoneNumberProcedure3(context,phoneNumber);
        else {
          if(isFriend)
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("This user has no phone number!"),
            ));
          else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("First, you need to add the user as friend!"),
            ));
        }
      },
    );
  }
}