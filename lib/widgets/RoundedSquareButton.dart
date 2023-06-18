import 'package:flutter/material.dart';

class RoundedSquareButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final String imageUrl;

  const RoundedSquareButton({
    required this.text,
    required this.onPressed,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: TextButton(
        child: Text(text),
        onPressed: onPressed,
      ),
    );
  }
}
