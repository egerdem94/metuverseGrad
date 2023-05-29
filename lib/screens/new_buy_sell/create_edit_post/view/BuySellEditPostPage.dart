import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyAndSellAppBar.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/view/widget/BuySellEditPost.dart';
import 'package:metuverse/widgets/drawer.dart';

class BuySellEditPostPage extends StatefulWidget {
  final buyOrSell;
  final post;
  const BuySellEditPostPage({super.key, required this.buyOrSell, required this.post});
  @override
  _BuySellEditPostPageState createState() => _BuySellEditPostPageState();
}

class _BuySellEditPostPageState extends State<BuySellEditPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(
        buyOrSell: widget.buyOrSell,
      ),
      drawer: MetuverseDrawer(),
      body: BuySellEditPostBody(),
    );
  }
}
