import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyAndSellAppBar.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/view/widget/BuySellCreatePostBody.dart';
import 'package:metuverse/widgets/drawer.dart';

class BuySellCreatePostPage extends StatefulWidget {
  final buyOrSell;
  const BuySellCreatePostPage({super.key, required this.buyOrSell});
  @override
  _BuySellCreatePostPageState createState() => _BuySellCreatePostPageState();
}

class _BuySellCreatePostPageState extends State<BuySellCreatePostPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController productCurrency = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(
        buyOrSell: widget.buyOrSell,
      ),
      drawer: MetuverseDrawer(),
      body: BuySellCreatePostBody(descriptionController: descriptionController, priceController: priceController, productCurrency: productCurrency,),
    );
  }
}