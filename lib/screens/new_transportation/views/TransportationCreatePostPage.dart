import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/CreatePostItem.dart';
import 'package:metuverse/screens/new_transportation/views/widgets/TransportationCreatePostBody.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class TransportationCreatePostPage extends StatefulWidget {
  @override
  _TransportationCreatePostPageState createState() =>
      _TransportationCreatePostPageState();
}

class _TransportationCreatePostPageState extends State<TransportationCreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();

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
      //drawer: MetuverseDrawer(),
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