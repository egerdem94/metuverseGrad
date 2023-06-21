import 'package:flutter/material.dart';
import 'package:metuverse/screens/whisper/whisper_create_edit_post/view/widget/WhisperCreateEditPostBody.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/widget/WhisperAppBar.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/widgets/drawer.dart';

class WhisperCreatePostPage extends StatefulWidget {
  const WhisperCreatePostPage({super.key});
  @override
  _WhisperCreatePostPageState createState() => _WhisperCreatePostPageState();
}

class _WhisperCreatePostPageState extends State<WhisperCreatePostPage> {
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhisperAppBar(),
      //drawer: MetuverseDrawer(),
      body: WhisperCreateEditPostBody(
        editOrCreate: "c",
        descriptionController: descriptionController,
        photoList: PhotoList(),
      ),
    );
  }
}