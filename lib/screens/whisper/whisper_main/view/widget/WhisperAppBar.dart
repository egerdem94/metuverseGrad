import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/notification/view/NotificationButton.dart';
import 'package:metuverse/buttons/friends/view/FriendsButton.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperSearchPage.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';

class WhisperAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  const WhisperAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GeneralUtil.buildPostBoxDecoration(),
      child: AppBar(
        title: Text(
          'Whisper',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              Get.to((WhisperSearchPage()));
            },
          ),
          NotificationButton(),
          FriendsButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}