import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(174, 0, 0, 0),
          Color.fromARGB(120, 0, 0, 0),
          Color.fromARGB(0, 88, 88, 88),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets-images/metuverse_login_screen2.png'),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(Color.fromARGB(52, 0, 0, 0), BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
