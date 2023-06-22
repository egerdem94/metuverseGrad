import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/GeneralResponse.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_buy_sell/create_edit_post/controller/Util.dart';
import 'package:metuverse/screens/sport/create_edit_post/model/SportTypes.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportPage.dart';
import 'package:metuverse/user/User.dart';

import 'package:image/image.dart' as IMG;
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/create_post/DescriptionInputBox.dart';
import 'package:metuverse/widgets/create_post/PriceInputBox.dart';
import 'package:metuverse/widgets/create_post/ProfilePicture.dart';
import 'package:path_provider/path_provider.dart';

class SportCreateEditPostBody extends StatefulWidget {
  late final GlobalKey<FormState> _formKey;
  final TextEditingController descriptionController;
  final String editOrCreate;
  final String selectedSport;
  final postID;
  SportCreateEditPostBody({ required this.editOrCreate,required this.descriptionController, required this.selectedSport, this.postID,}) : super();

  @override
  _SportCreateEditPostBodyState createState() => _SportCreateEditPostBodyState();
}

class _SportCreateEditPostBodyState extends State<SportCreateEditPostBody> {
  @override
  void initState() {
    super.initState();
    widget._formKey = GlobalKey<FormState>();
    _selectedSport = widget.selectedSport;
  }
  bool isButtonClicked = false; //to prevent multiple clicks
  bool isResponseReceived = false;
  GeneralResponse? generalResponseObject;
  var generalResponseCreatePost;
  late String _selectedSport;
  Future _sendPostToBackend() async {
    var url;
    if(widget.editOrCreate == 'c'){
      url = "http://www.birikikoli.com/mv_services/postPage/sport/sport_createPost.php";
    }
    else{
      url = "http://www.birikikoli.com/mv_services/postPage/sport/sport_updatePost.php";
    }
    var request = http.MultipartRequest('POST', Uri.parse(url));

    int i = 0;
    request.fields['token'] = User.privateToken;
    if(widget.editOrCreate == 'e')
      request.fields['postID'] = widget.postID;
    request.fields['sportID'] = (SportTypes.getIndexOfSportType(_selectedSport) +1).toString();
    request.fields['eventDate'] = "TODO";
    request.fields['totalPerson'] = "4"; //TODO change
    request.fields['description'] = widget.descriptionController.text;

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
                  builder: (context) => SportPage(searchModeFlag: false, notificationMode: false)
              )
          );

        } else {
          isButtonClicked = false;
          isResponseReceived = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget.editOrCreate == 'c'?"Post create failed.":"Post update failed."),
          ));
        }
      });
    }).catchError((e) {
      print(e);
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: DropdownButton<String>(
                                    items: SportTypes.sportTypeList.map<
                                        DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedSport = newValue!;
                                      });
                                    },
                                    value: _selectedSport,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DescriptionInputBox(descriptionController: widget.descriptionController,hint: "Describe your post"),
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
                                Text(widget.editOrCreate == 'c'?'Post':"Update"), // <-- Text
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: GeneralUtil.createPostBottomNavigationDecoration(),
        child: BottomAppBar(
          // ignore: sort_child_properties_last
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}