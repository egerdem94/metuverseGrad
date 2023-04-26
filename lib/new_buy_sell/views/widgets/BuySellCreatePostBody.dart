import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/generalResponse.dart';
import 'package:metuverse/new_buy_sell/views/BuySellPage.dart';
import 'package:metuverse/user/User.dart';

import 'package:image/image.dart' as IMG;
import 'package:path_provider/path_provider.dart';

class BuySellCreatePostBody extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  //final List<String> imageUrls;
  final Function updateImageUrls;
  final Function createProduct;
  final Function submitForm;
  final Function(File) onImageSelected;

  BuySellCreatePostBody({
    //this.imageUrls = const [],
    required this.updateImageUrls,
    required this.createProduct,
    required this.submitForm,
    required this.onImageSelected,
  }) : super();

  @override
  _BuySellCreatePostBodyState createState() => _BuySellCreatePostBodyState();
}

class _BuySellCreatePostBodyState extends State<BuySellCreatePostBody> {
  final TextEditingController description = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productCurrency = TextEditingController();
  final picker = ImagePicker();

  String _selectedCurrency = '₺';
  List<String> _currencies = ['₺', '\$', '€', '£'];
  String _buyerOrSeller = 'Selling';
  List<String> _who = ['Buying', 'Selling'];
  File? file;
  XFile? pickedImage;
  bool isLoading = false;
  bool isButtonClicked = false; //to prevent multiple clicks
  bool isResponseReceived = false;
  List<File?> fileList = [];
  generalResponse? generalResponseObject;
  var generalResponseCreatePost;

  List<int> getResizedDimensions(int desiredHeight, int width, int height) {
    if (height <= desiredHeight) return [height, width];
    double ratio = height / desiredHeight;
    return [(width / ratio).round(), desiredHeight];
  }

  Future _sendPostToBackend() async {
    var url = "http://www.birikikoli.com/mv_services/createSonDeneme333.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));

    int i = 0;
    for (var fL in fileList) {
      if (fL != null) {
        IMG.Image? img = IMG.decodeImage(await fL.readAsBytes());
        List<int> resizeDimList =
            getResizedDimensions(200, img!.width, img.height);
        IMG.Image resized = IMG.copyResize(img,
            width: resizeDimList[0], height: resizeDimList[1]);

        final dir = await getTemporaryDirectory();
        final path =
            "${dir.path}/test${User.fullName.removeAllWhitespace}${DateTime.now().toString().removeAllWhitespace}.png";
        final newImg = await File(path).writeAsBytes(IMG.encodePng(resized));

        var pic = await http.MultipartFile.fromPath("image$i", newImg.path);
        /* var pic = await http.MultipartFile.fromPath("image$i", fL!.path);*/

        request.files.add(pic);
        i++;
      }
    }
    //request.fields['userID'] = '€'.toString();
    request.fields['token'] = User.privateToken;
    request.fields['buyerOrSeller'] = _buyerOrSeller.toLowerCase()[0];
    request.fields['description'] = description.text;
    request.fields['productPrice'] = productPrice.text;
    request.fields['currency'] = _selectedCurrency;

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
          //token = loginObject?.currentUserToken;
          if (_buyerOrSeller == 'Selling') {
            //Get.to(SellPage(searchKey: "", filteredProductPrice: "", filteredCurrency: ""));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BuySellPage(
                          buyOrSell: 's',
                          searchModeFlag: false,
                        )));
          } else {
            //Get.to(BuyPage(searchKey: "", filteredProductPrice: "", filteredCurrency: ""));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BuySellPage(
                          buyOrSell: 'b',
                          searchModeFlag: false,
                        )));
          }
        } else {
          isButtonClicked = false;
          isResponseReceived = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Post create failed."),
          ));
        }
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
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 16.0, left: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: DropdownButton<String>(
                        value: _buyerOrSeller,
                        items: _who.map((String value) {
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
                            _buyerOrSeller = newValue!;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        dropdownColor: Colors.blue,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(top: 16.0),
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                          color: Color.fromARGB(255, 255, 255, 255),
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
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          margin: EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0, top: 20),
                          child: TextFormField(
                            style: TextStyle(
                              color:
                                  Colors.black, // Set the text color to black
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                            ),
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
              BackButton(
                color: Colors.white,
              ),
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
