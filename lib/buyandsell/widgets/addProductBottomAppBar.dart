import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomAddProductBottomNavigationBar extends StatefulWidget {
  final Function(File) onImageIconSelected;
  final Function() onLocationButtonPressed;
  const CustomAddProductBottomNavigationBar({
    required this.onImageIconSelected,
    required this.onLocationButtonPressed,
  });

  @override
  _CustomAddProductBottomNavigationBarState createState() =>
      _CustomAddProductBottomNavigationBarState();
}

class _CustomAddProductBottomNavigationBarState
    extends State<CustomAddProductBottomNavigationBar> {
  Widget _bottomIconWidget() {
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
                setImage(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.photo_size_select_actual_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setImage(ImageSource.camera);
              },
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
              onPressed: widget.onLocationButtonPressed,
            ),
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  void setImage(ImageSource source) {
    ImagePicker()
        .pickImage(source: source, imageQuality: 20)
        .then((XFile? file) {
      setState(() {
        //_image = file;

        widget.onImageIconSelected(File(file!.path));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bottomIconWidget(),
    );
  }
}
