import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/storage/models/CreatePostItem.dart';
import 'package:metuverse/screens/new_transportation/create_edit_post/view/widget/TransportationCreateEditPostBody.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class TransportationEditPostPage extends StatefulWidget {
  final TransportationPost transportationPost;

  const TransportationEditPostPage({
    super.key,
    required this.transportationPost
  });
  @override
  _TransportationEditPostPageState createState() =>
      _TransportationEditPostPageState();
}

class _TransportationEditPostPageState extends State<TransportationEditPostPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController totalPersonController;
  late TextEditingController availablePersonController;
  late TextEditingController seatController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.transportationPost.transportationPrice.toString());
    descriptionController= TextEditingController(text: widget.transportationPost.description);
    totalPersonController = TextEditingController(text: widget.transportationPost.availablePerson.toString());
    availablePersonController = TextEditingController(text: widget.transportationPost.availablePerson.toString());
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
      body: TransportationCreatePostBody(
        editOrCreate: 'e',
        createProduct: _createProduct,
        submitForm: _submitForm,
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