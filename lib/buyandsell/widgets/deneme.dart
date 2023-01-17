import 'dart:io';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

class bottom extends StatefulWidget {
  const bottom({Key? key}) : super(key: key);

  @override
  State<bottom> createState() => _bottomState();
}

class _bottomState extends State<bottom> {
  final picker = ImagePicker();
  File? file;
  XFile? pickedImage;
  bool isLoading = false;
  List<File?> fileList = [];

  Future pickImageFromGallery() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedImage!.path);
      fileList.add(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 79, 79, 79),
            width: 0.2,
          ),
        ),
      ),
      child: BottomAppBar(
        // ignore: sort_child_properties_last
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                pickImageFromGallery();
              },
              icon: const Icon(
                Icons.photo_size_select_actual_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              onPressed: () {},
              //onPressed: widget.onLocationButtonPressed,
            ),
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  void dltImages(data) {
    fileList.remove(data);
  }
}
