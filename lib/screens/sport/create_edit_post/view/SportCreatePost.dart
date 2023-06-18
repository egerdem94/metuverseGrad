import 'package:flutter/material.dart';
import 'package:metuverse/screens/sport/create_edit_post/view/widget/SportCreateEditPotstBody.dart';
import 'package:metuverse/screens/sport/sport_main/view/widget/SportAppBar.dart';
import 'package:metuverse/storage/models/Photo.dart';

class SportCreatePostPage extends StatefulWidget {
  const SportCreatePostPage({super.key});
  @override
  _SportCreatePostPage createState() => _SportCreatePostPage();
}

class _SportCreatePostPage extends State<SportCreatePostPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController productCurrency = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SportAppBar(
      ),
      //drawer: MetuverseDrawer(),
      body: SportCreateEditPostBody(editOrCreate: "c",descriptionController: descriptionController,),
    );
  }
}