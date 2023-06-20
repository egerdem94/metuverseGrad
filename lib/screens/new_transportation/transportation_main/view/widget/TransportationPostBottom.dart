import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';

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
        Spacer(),
        Icon(MdiIcons.humanGreeting, color: post.transportationStatus! == 1 ? Colors.green : Colors.red,),
        Text(
            "${post.totalPerson}",
            style: TextStyle(color: post.transportationStatus! == 1 ? Colors.green : Colors.red,)
        ),
        SizedBox(width: 8.0,),
        Chip(
          label: Text(
            post.transportationStatus! == 1 ? 'Looking' : 'Found',
            style: TextStyle(
              color:
                  post.transportationStatus! == 1 ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor:
              post.transportationStatus! == 1 ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
