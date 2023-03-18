import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:metuverse/storage/database/DatabaseHelperPhoto.dart';
import 'package:metuverse/storage/database/PhotoDBHelper.dart';
//import 'package:metuverse/storage/database/PhotoDBHelper.dart';


class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<Uint8List> _photos = [];
  DatabaseHelperPhoto databaseHelperPhoto = DatabaseHelperPhoto();
  @override
  void initState() {
    //WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    _loadPhotos2();
  }

  Future<void> _loadPhotos() async {
    var x = await PhotoDatabase.instance.insertPhotoFromUrl("https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Ava_Addams_AVN_Expo_2015_2.jpg/330px-Ava_Addams_AVN_Expo_2015_2.jpg");
    debugPrint("inserted:" + x.toString());
    final photos = await PhotoDatabase.instance.getPhotos();

    //await databaseHelperPhoto.init();
    //await databaseHelperPhoto.insertPhotoFromUrl(36,"https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Ava_Addams_AVN_Expo_2015_2.jpg/330px-Ava_Addams_AVN_Expo_2015_2.jpg");
    //final photos = await databaseHelperPhoto.getAllPhotosWithPostID(36);
    //final photos = await databaseHelperPhoto.getAllPhotosInDB();
    setState(() {
      //if(photos!= null)
      _photos = photos;
    });
  }
  Future<void> _loadPhotos2() async {
/*    var x = await PhotoDatabase.instance.insertPhotoFromUrl("https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Ava_Addams_AVN_Expo_2015_2.jpg/330px-Ava_Addams_AVN_Expo_2015_2.jpg");
    debugPrint("inserted:" + x.toString());
    final photos = await PhotoDatabase.instance.getPhotos();*/

    await databaseHelperPhoto.init();
    await databaseHelperPhoto.insertPhotoFromUrl(36,"https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Ava_Addams_AVN_Expo_2015_2.jpg/330px-Ava_Addams_AVN_Expo_2015_2.jpg");
    final photos = await databaseHelperPhoto.getAllPhotosWithPostID(36);
    //final photos = await databaseHelperPhoto.getAllPhotosInDB();
    setState(() {
      //if(photos!= null)
      _photos = photos;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: GridView.builder(
        itemCount: _photos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return Image.memory(
            photo,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
