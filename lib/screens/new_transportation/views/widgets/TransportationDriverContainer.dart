import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/buttons/overflow_menu_button/commercial_overflow_menu_button/view/CommercialOverflowMenuButton.dart';
import 'package:metuverse/screens/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/screens/new_transportation/model/TransportationLocations.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_transportation/views/widgets/DepartureDestinationBox.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';

class TransportationDriverContainer extends StatefulWidget {
  final NewTransportationPost post;
  TransportationDriverContainer({required this.post});

  @override
  _TransportationDriverContainerState createState() =>
      _TransportationDriverContainerState();
}
class _TransportationDriverContainerState
    extends State<TransportationDriverContainer> {
  int seatsTaken = 0;
  int totalSeats = 4;

  void takeSeat() {
    setState(() {
      seatsTaken++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GeneralUtil.buildPostBoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //post.belongToUser!?TopLeftOwnPost(post: post):TopLeftPost(post: post),
              TopLeftCommercialPost(post: widget.post),
              Spacer(),
              Text(
                  '${widget.post.transportationPrice ?? 0} ${GeneralUtil.currencyConverter(widget.post.currency ?? "")} ₺',
                  style: kwhiteText),
              SizedBox(width: 8.0),
              CommercialOverflowMenu(post: widget.post,),
            ],
          ),
          SizedBox(height: 8.0),
          Text(widget.post.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          DepartureDestinationBoxes(post: widget.post),
          SizedBox(height: 8.0),
          Row(
            children: [
              FavoriteButton(post: widget.post,),
              /*if (!widget.post.belongToUser!)
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    MdiIcons.humanGreeting,
                  ),
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
              IconButton(
                icon: Icon(MdiIcons.seatPassenger,
                    color:
                        seatsTaken == totalSeats ? Colors.red : Colors.green),
                onPressed: takeSeat,
              ),
              Text(
                "$seatsTaken/$totalSeats",
                style: TextStyle(
                    color:
                        seatsTaken == totalSeats ? Colors.red : Colors.green),
              ),
            ],
          )
        ],
      ),
    );
  }
}