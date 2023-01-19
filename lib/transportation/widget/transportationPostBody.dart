import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:metuverse/palette.dart';

import '../../util/user.dart';

class TransportationPostBody extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Function createProduct;
  final Function submitForm;

  TransportationPostBody({
    required this.createProduct,
    required this.submitForm,
  }) : super() {}

  @override
  _TransportationPostBodyState createState() => _TransportationPostBodyState();
}

class _TransportationPostBodyState extends State<TransportationPostBody> {
  /* final picker = ImagePicker();
  String _selectedCurrency = '₺';
  List<String> _currencies = ['₺', '\$', '€', '£'];
  File? file;
  XFile? pickedImage;
  bool isLoading = false;
  List<File?> fileList = [];*/
  bool _showPrice = true;
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
                          controller: widget._priceController,
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
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, left: 16.0, right: 16.0, bottom: 8.0),
                          child: TextFormField(
                            style: kCreateText,
                            controller: widget._descriptionController,
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
                          height: 35,
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(right: 10.0, bottom: 18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate the form
                              // if (widget._formKey.currentState!.validate()) {
                              // If the form is valid, submit the form
                              widget.submitForm();
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
        height: 40,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 79, 79, 79),
              width: 0.2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _showPrice = false;
                });
              },
              child: Icon(
                MdiIcons.humanGreeting,
                color: _showPrice ? Colors.white : Colors.blue,
              ),
            ),
            InkWell(
              onTap: (() {
                setState(() {
                  _showPrice = true;
                });
              }),
              child: new Icon(
                MdiIcons.carConnected,
                color: _showPrice ? Colors.blue : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
