import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/palette.dart';

import '../../storage/User.dart';

class TransportationPostBody extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();
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
  String _driverOrPassenger = 'Passenger';
  List<String> _who = ['Driver', 'Passenger'];
  String _selectedDeparture = 'Kalkanli';
  List<String> _locationList = [
    'Ercan',
    'Girne',
    'Güzelyurt',
    'Kalkanli',
    'Karpaz',
    'Lefke',
    'Lefkoşa',
    'Mağusa'
  ];
  String _selectedDestination = 'Kalkanli';
  List<String> _destinationList = [
    'Ercan',
    'Girne',
    'Güzelyurt',
    'Kalkanli',
    'Karpaz',
    'Lefke',
    'Lefkoşa',
    'Mağusa'
  ];
  bool _showPrice = true;
  bool isButtonClicked = false;

  Future _sendPostToBackend() async {
/*    //var img = await picker.pickImage(source: media);
    //var uri = "http://www.birikikoli.com/mv_services/create223.php";

    var url = "x";
    var request = http.MultipartRequest('POST', Uri.parse(url));

    //request.fields['userID'] = '€'.toString();
    request.fields['token'] = User.token;
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
                    builder: (context) => BuySellPage(buyOrSell: 's', searchModeFlag: false,)
                )
            );
          } else {
            //Get.to(BuyPage(searchKey: "", filteredProductPrice: "", filteredCurrency: ""));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BuySellPage(buyOrSell: 'b', searchModeFlag: false,)
                )
            );
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
    });*/
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
                  Spacer(),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16.0, right: 16),
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(4.0),
                      color: _driverOrPassenger == 'Passenger'
                          ? Colors.black
                          : Colors.white,
                    ),
                    child: _driverOrPassenger == 'Passenger'
                        ? Container()
                        : TextFormField(
                            controller: widget._seatController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter seats';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Seats',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 8.0),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16.0, right: 16),
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(4.0),
                      color: _driverOrPassenger == 'Passenger'
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Colors.white,
                    ),
                    child: _driverOrPassenger == 'Passenger'
                        ? TextFormField(
                            controller: widget._personController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter person';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Person',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 8.0),
                            ),
                            keyboardType: TextInputType.number,
                          )
                        : TextFormField(
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
              Container(
                  margin: EdgeInsets.only(
                      top: 20, left: 16.0, right: 16.0, bottom: 8.0),
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
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: DropdownButton<String>(
                                    items: _locationList.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDeparture = newValue!;
                                      });
                                    },
                                    value: _selectedDeparture,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.place,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: DropdownButton<String>(
                                    items: _destinationList.map<
                                            DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDestination = newValue!;
                                      });
                                    },
                                    value: _selectedDestination,
                                  ),
                                ),
                              ],
                            ),
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
                  _driverOrPassenger = 'Passenger';
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
                  _driverOrPassenger = 'Driver';
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