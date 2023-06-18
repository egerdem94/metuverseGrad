import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/model/BuySellPost.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyAndSellAppBar.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/view/widget/BuySellCreateEditPostBody.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/drawer.dart';

class BuySellEditPostPage extends StatefulWidget {
  final buyOrSell;
  final BuySellPost buySellPost;
  const BuySellEditPostPage({super.key, required this.buyOrSell, required this.buySellPost});
  @override
  _BuySellEditPostPageState createState() => _BuySellEditPostPageState();
}

class _BuySellEditPostPageState extends State<BuySellEditPostPage> {
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController productCurrency;
  late PhotoList photoList;
  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(text: widget.buySellPost.description);
    priceController = TextEditingController(text: widget.buySellPost.productPrice!.toString());
    productCurrency = TextEditingController(text: widget.buySellPost.currency);
    photoList = widget.buySellPost.photoList;
  }
  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
    productCurrency.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuySellAppBar(
        buyOrSell: widget.buyOrSell,
      ),
      //drawer: MetuverseDrawer(),
      body: BuySellCreateEditPostBody(editOrCreate:"e",
        descriptionController: descriptionController,
        priceController: priceController,
        productCurrency: productCurrency,
        photoList: photoList,
        selectedCurrency: GeneralUtil.currencyConverter2(widget.buySellPost.currency),),
    );
  }
}