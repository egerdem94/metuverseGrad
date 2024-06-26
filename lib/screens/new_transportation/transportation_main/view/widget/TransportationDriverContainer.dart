import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/screens/new_transportation/button/transportation_overflow_menu_button/view/TransportationOverflowMenuButton.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/DepartureDestinationBox.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/TopLeftCommercialPost.dart';

class TransportationDriverContainer extends StatefulWidget {
  final TransportationPost post;
  final Function onDeletePressedArgument;
  final Function onUpdateArgument;
  TransportationDriverContainer({required this.post, required this.onDeletePressedArgument, required this.onUpdateArgument});

  @override
  _TransportationDriverContainerState createState() =>
      _TransportationDriverContainerState();
}
class _TransportationDriverContainerState
    extends State<TransportationDriverContainer> {
 /* late Color color;

  @override
  void initState() {
    super.initState();
    if(widget.post.availablePerson! == 0)
      color = Colors.green;
    else if(widget.post.availablePerson! < widget.post.totalPerson!)
      color = Colors.yellow;
    else
      color = Colors.red;
  }*/
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
              TransportationOverflowMenu(post: widget.post,
                onDeletePressedArgument: widget.onDeletePressedArgument, onUpdateArgument: widget.onUpdateArgument,
              ),
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
              Spacer(),
              Icon(MdiIcons.seatPassenger, color:widget.post.availablePerson! == widget.post.totalPerson ? Colors.red : (widget.post.availablePerson! == 0 ? Colors.green : Colors.yellow) ,),
              Text(
                "${widget.post.availablePerson!}/${widget.post.totalPerson!}",
                style: TextStyle(color:widget.post.availablePerson! == widget.post.totalPerson ? Colors.red : (widget.post.availablePerson! == 0 ? Colors.green : Colors.yellow))
              ),
              SizedBox(width: 8.0,),
              Chip(
                label: Text(
                  widget.post.transportationStatus! == 1 ? 'Looking' : 'Found',
                  style: TextStyle(
                    color:
                    widget.post.transportationStatus! == 1 ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor:
                widget.post.transportationStatus! == 1 ? Colors.green : Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}