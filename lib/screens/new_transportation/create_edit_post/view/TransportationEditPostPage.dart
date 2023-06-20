import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/NewTransportationPost.dart';
import 'package:metuverse/storage/models/CreatePostItem.dart';
import 'package:metuverse/screens/new_transportation/create_edit_post/view/widget/TransportationCreateEditPostBody.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class TransportationCreatePostPage extends StatefulWidget {
  final TransportationPost transportationPost;

  const TransportationCreatePostPage({
    super.key,
    required this.transportationPost
  });
  @override
  _TransportationCreatePostPageState createState() =>
      _TransportationCreatePostPageState();
}

class _TransportationCreatePostPageState extends State<TransportationCreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController personController;
  late TextEditingController seatController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.transportationPost.transportationPrice.toString());
    descriptionController= TextEditingController(text: widget.transportationPost.description);
    personController = TextEditingController(text: widget.transportationPost.availablePerson.toString());
    seatController = TextEditingController(text: widget.transportationPost.availablePerson.toString());
  }
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
      body: TransportationCreateEditPostBody(
        createProduct: _createProduct,
        submitForm: _submitForm,
        createOrEdit: 'c',
        productPrice: priceController,
        personController: personController,
        seatController: seatController,
        descriptionController: descriptionController,
      ),
      /* bottomNavigationBar:
            const bottom() CustomAddProductBottomNavigationBar(
        onLocationButtonPressed: () {},
        onImageIconSelected: (File) {},
      ),*/
    );
  }
}