import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationBox extends StatelessWidget {
  final TextEditingController enterInfo;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final FocusNode previousFocusNode;
  final someFocusNode = FocusNode();

  VerificationBox({
    required this.enterInfo,
    required this.focusNode,
    required this.nextFocusNode,
    required this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,//40
      height: 50,//50
      child: TextField(
        keyboardType: TextInputType.text,
        controller: enterInfo,
        focusNode: focusNode,
        textInputAction: TextInputAction.done,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            focusNode.unfocus();
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          } else if (value.isEmpty) {
            focusNode.unfocus();
            if (previousFocusNode != null) {
              FocusScope.of(context).requestFocus(previousFocusNode);
            }
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
