import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

class MetuverseDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 148, 148, 148),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Menu item 1",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                // navigate to the corresponding page
              },
            ),
            ListTile(
              title: Text(
                "Menu item 2",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                // navigate to the corresponding page
              },
            ),
          ],
        ),
      ),
    );
  }
}
