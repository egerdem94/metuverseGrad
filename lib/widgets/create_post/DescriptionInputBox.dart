import 'package:flutter/material.dart';

class DescriptionInputBox extends StatelessWidget {
  const DescriptionInputBox({
    Key? key,
    required this.hint,
    required this.descriptionController,
  }) : super(key: key);

  final String hint;

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 8.0, top: 20),
      child: TextFormField(
        style: TextStyle(
          color:
          Colors.black, // Set the text color to black
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
        controller: descriptionController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Description',
          labelStyle: TextStyle(color: Colors.blue),
          hintText: hint,
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 111, 111, 111)),
          enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent),
          ),
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
