import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
//import 'package:get/get.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:metuverse/Chat/components/screens/chats/chats_screen.dart';
//import 'package:metuverse/widgets/search.dart/search.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 79, 79, 79),
            width: 0.3,
          ),
        ),
      ),
      child: AppBar(
        title: Text(
          "Messages",
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
            icon: Icon(Icons.notifications),
            onPressed: () {
              // handle notification button press
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
