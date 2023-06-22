import 'package:flutter/material.dart';
import 'package:metuverse/screens/sport/create_edit_post/model/SportTypes.dart';
import 'package:metuverse/screens/sport/create_edit_post/view/widget/SportCreateEditPotstBody.dart';
import 'package:metuverse/screens/sport/sport_main/model/SportPost.dart';
import 'package:metuverse/screens/sport/sport_main/view/widget/SportAppBar.dart';

class SportEditPostPage extends StatefulWidget {
  final SportPost sportPost;
  const SportEditPostPage({super.key, required this.sportPost});
  @override
  _SportCreatePostPage createState() => _SportCreatePostPage();
}

class _SportCreatePostPage extends State<SportEditPostPage> {
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(text: widget.sportPost.description);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SportAppBar(
      ),
      //drawer: MetuverseDrawer(),
      body: SportCreateEditPostBody(editOrCreate: "e",descriptionController: descriptionController, selectedSport: SportTypes.getSport(widget.sportPost.sportID!-1),postID: widget.sportPost.postID.toString(),),
    );
  }
}