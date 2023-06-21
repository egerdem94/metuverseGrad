import 'package:flutter/material.dart';
import 'package:metuverse/screens/whisper/whisper_create_edit_post/view/widget/WhisperCreateEditPostBody.dart';
import 'package:metuverse/screens/whisper/whisper_main/model/WhisperPost.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/widget/WhisperAppBar.dart';
import 'package:metuverse/storage/models/Photo.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/drawer.dart';

class WhisperEditPostPage extends StatefulWidget {
  final WhisperPost whisperPost;
  const WhisperEditPostPage({super.key, required this.whisperPost});
  @override
  _WhisperEditPostPageState createState() => _WhisperEditPostPageState();
}

class _WhisperEditPostPageState extends State<WhisperEditPostPage> {
  late TextEditingController descriptionController;
  late PhotoList photoList;
  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(text: widget.whisperPost.description);
    photoList = widget.whisperPost.photoList;
  }
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhisperAppBar(),
      //drawer: MetuverseDrawer(),
      body: WhisperCreateEditPostBody(editOrCreate:"e",
        descriptionController: descriptionController,
        photoList: photoList,
        postID: widget.whisperPost.postID.toString(),),
    );
  }
}