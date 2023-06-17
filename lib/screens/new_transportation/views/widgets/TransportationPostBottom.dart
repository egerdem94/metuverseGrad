import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/screens/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/palette.dart';

class TransportationCustomerPostBottom extends StatelessWidget {
  const TransportationCustomerPostBottom({
    super.key,
    required this.post,
  });

  final TransportationPost post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FavoriteButton(post: post),
        /*if (!false)
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
        ),*/
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