import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';

class OverflowMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        print('Selected: $value');
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Option 1',
            child: Text('Option 1'),
          ),
          PopupMenuItem<String>(
            value: 'Option 2',
            child: Text('Option 2'),
          ),
          PopupMenuItem<String>(
            value: 'Option 3',
            child: Text('Option 3'),
          ),
        ];
      },
      icon: Icon(Icons.more_vert, color: kwhiteText.color),
    );
  }
}