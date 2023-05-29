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
import 'package:metuverse/user/User.dart';

import 'package:image/image.dart' as IMG;
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/create_post/DescriptionInputBox.dart';
import 'package:metuverse/widgets/create_post/PriceInputBox.dart';
import 'package:metuverse/widgets/create_post/ProfilePicture.dart';
import 'package:path_provider/path_provider.dart';

class BuySellEditPostBody extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  BuySellEditPostBody() : super();

  @override
  _BuySellEditPostBodyState createState() => _BuySellEditPostBodyState();
}

class _BuySellEditPostBodyState extends State<BuySellEditPostBody> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
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
  GeneralResponse? generalResponseObject;
  var generalResponseCreatePost;

  Future _sendPostToBackend() async {
    var url = "http://www.birikikoli.com/mv_services/postPage/buyandsell/buyandsell_createPost.php";
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
        /* var pic = await http.MultipartFile.fromPath("image$i", fL!.path);*/

        request.files.add(pic);
        i++;
      }
    }
    //request.fields['userID'] = '€'.toString();
    request.fields['token'] = User.privateToken;
    request.fields['buyerOrSeller'] = _buyerOrSeller.toLowerCase()[0];
    request.fields['description'] = descriptionController.text;
    request.fields['productPrice'] = priceController.text;
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
                      PriceInputBox(priceController: priceController,initialPrice: ""),
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
                        DescriptionInputBox(descriptionController: descriptionController,initialValue: "",hint: "What are you selling"),
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