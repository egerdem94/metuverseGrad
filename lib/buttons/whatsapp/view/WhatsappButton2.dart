import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/whatsapp/controller/WhatsappController.dart';

class WhatsappButton2 extends StatelessWidget {
  WhatsappButton2({
    super.key,
    required this.friend,
  });

  final Friend friend;
  final WhatsappController whatsappController = WhatsappController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        MdiIcons.whatsapp,
        color: Colors.green,
      ),
      onPressed: () {
        //egeMessage(context);
        whatsappController.phoneNumberProcedure2(context,friend);
      },
    );
  }
}