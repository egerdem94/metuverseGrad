import 'dart:io';
import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/views/widgets/BuyAndSellAppBar.dart';
import 'package:metuverse/screens/new_buy_sell/views/widgets/BuySellCreatePostBody.dart';
import 'package:metuverse/storage/models/CreatePostItem.dart';
import 'package:metuverse/widgets/drawer.dart';

class BuySellCreatePostPage extends StatefulWidget {
  final buyOrSell;

  const BuySellCreatePostPage({super.key, required this.buyOrSell});
  @override
  _BuySellCreatePostPageState createState() => _BuySellCreatePostPageState();
}

class _BuySellCreatePostPageState extends State<BuySellCreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  List<String> _imageUrls = [];

  void updateImageUrls(List<String> newImageUrls) {
    setState(() {
      _imageUrls = newImageUrls;
    });
  }

  void _onImageSelected(File image) {
    setState(() {
      // Use the image in the description area of the form
    });
  }

  CreatePostItem _createProduct() {
    return CreatePostItem(
      productPrice: _priceController.text,
      description: _descriptionController.text,
      currency: _currencyController.text,
      // imageUrl: _imageUrls,
    );
  }

  void _submitForm() {
    // if (_formKey.currentState!.validate()) {
    CreatePostItem singlePostSendingItem = _createProduct();
    // code to store newProduct in thedatabase
    Navigator.pop(context);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(
        buyOrSell: widget.buyOrSell,
      ),
      drawer: MetuverseDrawer(),
      body: BuySellCreatePostBody(
        updateImageUrls: updateImageUrls,
        createProduct: _createProduct,
        submitForm: _submitForm,
        onImageSelected: _onImageSelected,
      ),
      /* bottomNavigationBar:
            const bottom() CustomAddProductBottomNavigationBar(
        onLocationButtonPressed: () {},
        onImageIconSelected: (File) {},
      ),*/
    );
  }
}
