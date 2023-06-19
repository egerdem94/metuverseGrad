import 'package:flutter/material.dart';
import 'package:metuverse/buttons/favorite_button/view/FavoriteButton.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
class BuySellPostBottom extends StatefulWidget {
  const BuySellPostBottom({
    Key? key,
    required this.post,
  }) : super(key: key);

  final BuySellPost post;

  @override
  _BuySellPostBottomState createState() => _BuySellPostBottomState();
}

class _BuySellPostBottomState extends State<BuySellPostBottom> {
  @override
  void initState() {
    super.initState();
  }
@override
Widget build(BuildContext context) {
  return Row(
    children: [
      FavoriteButton(post: widget.post,),
      Spacer(),
      Chip(
        label: Text(
          widget.post.productStatus! == 1 ? 'Available' : 'Sold',
          style: TextStyle(
            color:
            widget.post.productStatus! == 1 ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor:
        widget.post.productStatus! == 1 ? Colors.green : Colors.red,
      ),
    ],
  );
}
}
