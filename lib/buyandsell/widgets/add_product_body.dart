import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/palette.dart';

import '../../generalResponse.dart';
import '../../util/user.dart';
import '../screens/buyAndSellPage.dart';

class AddProductBody extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> imageUrls;
  final Function updateImageUrls;
  final Function createProduct;
  final Function submitForm;
  final Function(File) onImageSelected;

  AddProductBody({
    this.imageUrls = const [],
    required this.updateImageUrls,
    required this.createProduct,
    required this.submitForm,
    required this.onImageSelected,
  }) : super() {}

  @override
  _AddProductBodyState createState() => _AddProductBodyState();
}

class _AddProductBodyState extends State<AddProductBody> {
  final TextEditingController description = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productCurrency = TextEditingController();

  final picker = ImagePicker();

  String _selectedCurrency = '₺';
  List<String> _currencies = ['₺', '\$', '€', '£'];
  File? file;
  XFile? pickedImage;
  bool isLoading = false;
  List<File?> fileList = [];
  generalResponse? generalResponseObject;


  Future _buyandsell_posts_create() async {

    //var img = await picker.pickImage(source: media);

    //var uri = "http://www.birikikoli.com/mv_services/create223.php";

    var uri = "http://www.birikikoli.com/mv_services/createSonDeneme333.php";

    var request = http.MultipartRequest('POST', Uri.parse(uri));

    if(pickedImage != null) {
      var pic = await http.MultipartFile.fromPath("image", pickedImage!.path);

      request.files.add(pic);
    }
      //request.fields['userID'] = '€'.toString();
      request.fields['token'] = User.token;
      request.fields['buyerOrSeller'] = 's';
      request.fields['description'] = description.text;
      request.fields['productPrice'] = productPrice.text;
      request.fields['currency'] = _selectedCurrency;


      await request.send().then((result) {

        http.Response.fromStream(result).then((response) {

          var message = jsonDecode(response.body);

          // show snackbar if input data successfully
          final snackBar = SnackBar(content: Text(message['message']));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        });

      }).catchError((e) {

        print(e);

      });


  }

  /*
  Future _buyandsell_posts_create() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/buyandsell_posts_create.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      "buyerOrSeller": "s",
      "description": description.text,
      "productPrice": productPrice.text,
      "currency": _selectedCurrency,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      generalResponseObject = generalResponse.fromJson(jsonObject);
    });
  }*/

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
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    padding: EdgeInsets.only(left: 16.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        //'https://i.hbrcdn.com/haber/2022/03/03/kolpacino-ekrem-abi-kimdir-abidin-yerebakan-14770711_6916_amp.jpg',
                        User.profilePicture,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 16.0),
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: productPrice,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a price';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Price',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 8.0),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(top: 16.0, left: 10.0),
                        child: DropdownButton<String>(
                          value: _selectedCurrency,
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCurrency = newValue!;
                            });
                          },
                          style: TextStyle(color: Colors.white),
                          underline: Container(
                            height: 2,
                            color: Colors.grey[800],
                          ),
                          dropdownColor: Color.fromARGB(255, 16, 16, 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: 20, left: 16.0, right: 16.0, bottom: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, left: 16.0, right: 16.0, bottom: 8.0),
                          child: TextFormField(
                            style: kCreateText,
                            controller: description,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(color: Colors.blue),
                              hintText: 'What are you selling?',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 111, 111, 111)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
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
                              _buyandsell_posts_create();
                              Timer(Duration(seconds: 3), () {
                                if (generalResponseObject?.processStatus ==
                                    true || 1 == 1) {
                                  //token = loginObject?.currentUserToken;

                                  Get.to(BuySellPage(searchKey: "", filteredProductPrice: "", filteredCurrency: ""));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Post yaratilamadi."),
                                  ));
                                }
                              });
                              // Validate the form
                              // if (widget._formKey.currentState!.validate()) {
                              // If the form is valid, submit the form
                              //widget.submitForm();
                              //}
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Post'), // <-- Text
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
                onPressed: (() {}),
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
                  onPressed: () {}),
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
