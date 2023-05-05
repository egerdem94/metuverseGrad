import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/palette.dart';

class TransportationCustomerPostBottom extends StatelessWidget {
  const TransportationCustomerPostBottom({
    super.key,
    required this.post,
  });

  final NewTransportationPost post;

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
              style: kwhiteText,
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
            icon: Icon(MdiIcons.carConnected),
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
        Chip(
          label: Text(
            post.transportationStatus! == 1 ? 'Looking' : 'Found',
            style: TextStyle(
              color: post.transportationStatus! == 1
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          backgroundColor: post.transportationStatus! == 1
              ? Colors.green
              : Colors.red,
        ),
      ],
    );
  }
}