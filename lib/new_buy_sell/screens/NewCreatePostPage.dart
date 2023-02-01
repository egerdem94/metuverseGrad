import 'dart:io';
import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyAndSellAppBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewCreatePostBody.dart';
import 'package:metuverse/storage/models/NewCreatePostItem.dart';
import 'package:metuverse/widgets/drawer.dart';

class NewCreatePostPage extends StatefulWidget {
  @override
  _NewCreatePostPageState createState() => _NewCreatePostPageState();
}

class _NewCreatePostPageState extends State<NewCreatePostPage> {
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

  NewCreatePostItem _createProduct() {
    return NewCreatePostItem(
      productPrice: _priceController.text,
      description: _descriptionController.text,
      currency: _currencyController.text,
      // imageUrl: _imageUrls,
    );
  }

  void _submitForm() {
    // if (_formKey.currentState!.validate()) {
    NewCreatePostItem singlePostSendingItem = _createProduct();
    // code to store newProduct in thedatabase
    Navigator.pop(context);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(),
      drawer: MetuverseDrawer(),
      body: NewCreatePostBody(
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
