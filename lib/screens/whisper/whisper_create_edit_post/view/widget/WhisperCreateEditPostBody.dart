import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/GeneralResponse.dart';
import 'package:metuverse/screens/whisper/whisper_create_edit_post/controller/Util.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperPage.dart';
import 'package:metuverse/user/User.dart';

import 'package:image/image.dart' as IMG;
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/create_post/DescriptionInputBox.dart';
import 'package:metuverse/widgets/create_post/ProfilePicture.dart';
import 'package:path_provider/path_provider.dart';

class WhisperCreateEditPostBody extends StatefulWidget {
  late final GlobalKey<FormState> _formKey;
  final TextEditingController descriptionController;
  final  photoList;
  final String editOrCreate;
  final postID;
  WhisperCreateEditPostBody({ required this.editOrCreate,
    required this.descriptionController,
    this.photoList,
    this.postID}) : super();

  @override
  _WhisperCreateEditPostBodyState createState() => _WhisperCreateEditPostBodyState();
}

class _WhisperCreateEditPostBodyState extends State<WhisperCreateEditPostBody> {
  @override
  void initState() {
    super.initState();
    widget._formKey = GlobalKey<FormState>();
    // Check if the mode is "edit", and if so, populate fileList from photoList
    if (widget.editOrCreate == "e" && widget.photoList != null && widget.photoList.photos.isNotEmpty) {
      for (var photo in widget.photoList.photos) {
        // Create a File from photoData
        final tempDir = Directory.systemTemp;
        final file = File('${tempDir.path}/${photo.photoID}.jpg');
        file.writeAsBytesSync(photo.photoData);

        // Add file to fileList
        fileList.add(file);
      }
    }
  }

  final picker = ImagePicker();
  File? file;
  XFile? pickedImage;
  bool isLoading = false;
  bool isButtonClicked = false; //to prevent multiple clicks
  bool isResponseReceived = false;
  List<File?> fileList = [];
  GeneralResponse? generalResponseObject;
  var generalResponseCreatePost;

  Future _sendPostToBackend() async {
    var url;
    if(widget.editOrCreate == 'c'){
      url = "http://www.birikikoli.com/mv_services/postPage/whisper/whisper_createPost.php";
    }
    else{
      url = "http://www.birikikoli.com/mv_services/postPage/whisper/whisper_updatePost.php";
    }
    var request = http.MultipartRequest('POST', Uri.parse(url));

    int i = 0;
    for (var fL in fileList) {
      if (fL != null) {
        IMG.Image? img = IMG.decodeImage(await fL.readAsBytes());
        List<int> resizeDimList =
            Util.getResizedDimensions(200, img!.width, img.height);
        IMG.Image resized = IMG.copyResize(img,
            width: resizeDimList[0], height: resizeDimList[1]);

        final dir = await getTemporaryDirectory();
        final path =
            "${dir.path}/test${User.fullName.removeAllWhitespace}${DateTime.now().toString().removeAllWhitespace}.png";
        final newImg = await File(path).writeAsBytes(IMG.encodePng(resized));

        var pic = await http.MultipartFile.fromPath("image$i", newImg.path);

        request.files.add(pic);
        i++;
      }
    }
    request.fields['token'] = User.privateToken;
    request.fields['description'] = widget.descriptionController.text;
    if(widget.editOrCreate == 'e'){
      request.fields['postID'] = widget.postID;
    }

    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        var message = jsonDecode(response.body);
        isResponseReceived = true;
        generalResponseCreatePost = message;

        // show snackbar if input data successfully
        final snackBar =
            SnackBar(content: Text(generalResponseCreatePost['message']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (generalResponseCreatePost['processStatus'] == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WhisperPage(
                    searchModeFlag: false, searchKey: '',
                  )
              )
          );
        } else {
          isButtonClicked = false;
          isResponseReceived = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget.editOrCreate == 'c' ? "Post create failed." : "Post Update failed."),
          ));
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
  Future pickImageFromGallery() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedImage!.path);
      fileList.add(file);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        child: SingleChildScrollView(
          reverse: true,
          key: widget._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePicture(),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 16.0, left: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DescriptionInputBox(descriptionController: widget.descriptionController,hint: "Describe your post"),
                        Container(
                          height: 200,
                          child: GridView.builder(
                            itemCount: fileList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.file(
                                        File(fileList[i]!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        right: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              dltImages(fileList[i]);
                                            });
                                          },
                                          child: const Icon(Icons.cancel,
                                              color: Colors.blue),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(right: 10.0, bottom: 18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isButtonClicked == false) {
                                isButtonClicked = true;
                                _sendPostToBackend();
                              }
                              // Validate the form
                              // if (widget._formKey.currentState!.validate()) {
                              // If the form is valid, submit the form
                              //widget.submitForm();
                              //}
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.editOrCreate == 'c'? 'Post': 'Update'), // <-- Text
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: GeneralUtil.createPostBottomNavigationDecoration(),
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
            ],
          ),
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
    void dltImages(data) {
    fileList.remove(data);
  }
}