import 'package:flutter/material.dart';
import 'package:metuverse/storage/models/CreatePostItem.dart';
import 'package:metuverse/screens/new_transportation/create_edit_post/view/widget/TransportationCreateEditPostBody.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class TransportationCreatePostPage extends StatefulWidget {
  @override
  _TransportationCreatePostPageState createState() =>
      _TransportationCreatePostPageState();
}

class _TransportationCreatePostPageState extends State<TransportationCreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController totalPersonController = TextEditingController();
  final TextEditingController availablePersonController = TextEditingController();
  final TextEditingController seatController = TextEditingController();

  CreatePostItem _createProduct() {
    return CreatePostItem(
      productPrice: priceController.text,
      description: descriptionController.text,
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
        editOrCreate: 'c',
        productPrice: priceController,
        totalPersonController: totalPersonController,
        seatController: seatController,
        descriptionController: descriptionController,
        availablePersonController: availablePersonController,
      ),
      /* bottomNavigationBar:
            const bottom() CustomAddProductBottomNavigationBar(
        onLocationButtonPressed: () {},
        onImageIconSelected: (File) {},
      ),*/
    );
  }
}