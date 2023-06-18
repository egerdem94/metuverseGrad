import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TransportationDriverPostBottom extends StatelessWidget {
  final int seatsTaken;
  final int totalSeats;
  final VoidCallback onSeatPressed; // Callback function

  TransportationDriverPostBottom({
    required this.seatsTaken,
    required this.totalSeats,
    required this.onSeatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (false)
          TextButton(
            onPressed: () {
              // Change description
            },
            child: Text(
              'Change Description',
              style: TextStyle(color: Colors.white),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Change price
            },
            child: Text(
              'Change Price',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Update availability
            },
            child: Text(
              'Update Availability',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Delete post
            },
            child: Text(
              'Delete Post',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (false)
          TextButton(
            onPressed: () {
              // Leave a comment
            },
            child: Text(
              'Comment',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        if (!false)
          IconButton(
            onPressed: () {
              // Add product to favorites
            },
            icon: Icon(
              MdiIcons.humanGreeting,
            ),
            color: Colors.blue,
          ),
        IconButton(
          onPressed: () {
            // Leave a comment
          },
          icon: Icon(Icons.comment_rounded),
          color: Colors.blue,
        ),
        IconButton(
          onPressed: () {
            // Leave a comment
          },
          icon: Icon(Icons.send_rounded),
          color: Colors.blue,
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            MdiIcons.seatPassenger,
            color: seatsTaken == totalSeats ? Colors.red : Colors.green,
          ),
          onPressed: onSeatPressed, // Call the callback function here
        ),
        Text(
          "$seatsTaken/$totalSeats",
          style: TextStyle(
            color: seatsTaken == totalSeats ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
