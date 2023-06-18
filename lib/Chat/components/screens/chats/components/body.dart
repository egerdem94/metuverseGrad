/**import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../filled_outline_button.dart';
import '../../../models/Chat.dart';
import '../../messages/message_screen.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            child: ListView.builder(
              itemCount: chatsData.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                    color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 79, 79, 79),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: kDefaultPadding / 4),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ChatCard(
                  chat: chatsData[index - 1],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessagesScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
**/