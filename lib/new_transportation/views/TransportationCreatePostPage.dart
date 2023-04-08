import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/storage/models/CreatePostItem.dart';
//import 'package:metuverse/buyandsell/models/SellPostList.dart';
//import 'package:metuverse/buyandsell/widgets/addProductBottomAppBar.dart';
//import 'package:metuverse/buyandsell/widgets/add_product_body.dart';
//import 'package:metuverse/buyandsell/widgets/deneme.dart';
import 'package:metuverse/new_transportation/widget/TransportationCreatePostBody.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class TransportationCreatePostPage extends StatefulWidget {
  @override
  _TransportationCreatePostPageState createState() =>
      _TransportationCreatePostPageState();
}

class _TransportationCreatePostPageState extends State<TransportationCreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  List<String> _imageUrls = [];

  CreatePostItem _createProduct() {
    return CreatePostItem(
      productPrice: _priceController.text,
      description: _descriptionController.text,
      currency: _currencyController.text,
      // imageUrl: _imageUrls,
    );
  }

  void _submitForm() {
    //if (_formKey.currentState!.validate()) {
    CreatePostItem singlePostSendingItem = _createProduct();

    // code to store newProduct in thedatabase
    Navigator.pop(context);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
      drawer: MetuverseDrawer(),
      body: TransportationCreatePostBody(
        createProduct: _createProduct,
        submitForm: _submitForm,
      ),
      /* bottomNavigationBar:
            const bottom() CustomAddProductBottomNavigationBar(
        onLocationButtonPressed: () {},
        onImageIconSelected: (File) {},
      ),*/
    );
  }
}

/*To add the product to the server, you can make a HTTP POST request to the server's API endpoint with the product data in the request body. Here's an example of how you can do this using the http library:
Product product = ...; // the product to be added
http.Response response = await http.post(
  'http://yourserver.com/api/products',
  body: json.encode(product.toJson()),
  headers: {'Content-Type': 'application/json'},
);
if (response.statusCode == 200) {
  // product was successfully added to the server
} else {
  // there was an error adding the product to the server
}
*/