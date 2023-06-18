import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metuverse/palette.dart';

/*class VerificationBox extends StatelessWidget {
  final TextEditingController enterInfo;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  const VerificationBox({
    Key? key,
    required this.enterInfo,
    required this.focusNode,
    required this.nextFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 50,
      child: TextField(
        controller: enterInfo,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white, // Set the fill color to white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
}*/
