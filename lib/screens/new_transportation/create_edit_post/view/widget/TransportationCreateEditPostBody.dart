import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/screens/new_transportation/create_edit_post/controller/CreateEditPostBackend.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationLocations.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationPage.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/create_post/DescriptionInputBox.dart';


class TransportationCreatePostBody extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final Function createProduct;
  final Function submitForm;
  final String editOrCreate;
  final TextEditingController productPrice;// = TextEditingController();
  final TextEditingController totalPersonController;// = TextEditingController();
  final TextEditingController availablePersonController;// = TextEditingController();
  final TextEditingController seatController;// = TextEditingController();
  final TextEditingController descriptionController;// = TextEditingController();
  TransportationCreatePostBody({
    required this.createProduct,
    required this.descriptionController,
    required this.submitForm,
    required this.productPrice,
    required this.totalPersonController,
    required this.availablePersonController,
    required this.seatController, required this.editOrCreate,
  }) : super();

  @override
  _TransportationCreatePostBodyState createState() => _TransportationCreatePostBodyState();
}

class _TransportationCreatePostBodyState extends State<TransportationCreatePostBody> {

  String _customerOrDriver = 'Customer';
  //List<String> _who = ['Customer', 'Driver'];
  String _selectedDeparture = 'Campus';
  String _selectedDestination = 'Güzelyurt';
  bool _showPrice = true;
  bool isButtonClicked = false;
  bool isResponseReceived = false;
  var generalResponseCreatePost;
  CreateEditPostBackEnd createEditPostBackEnd = CreateEditPostBackEnd();
  Future _sendPostToBackend() async {
    var booleanRequestResponse = await createEditPostBackEnd.sendPostToBackend(
        selectedDeparture: TransportationLocations.getIndexOfLocation(_selectedDeparture).toString(),
        selectedDestination: TransportationLocations.getIndexOfLocation(_selectedDestination).toString(),
        availablePerson: getAvailablePerson(_customerOrDriver),
        totalPerson: "4",
        customerOrDriver: _customerOrDriver.toLowerCase()[0],
        productPrice: widget.productPrice.text,
        description: widget.descriptionController.text
    );
    if(booleanRequestResponse == true){
      if (_customerOrDriver == 'Customer') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TransportationPage(customerOrDriver: 'c', searchModeFlag: false,)
            )
        );
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TransportationPage(customerOrDriver: 'd', searchModeFlag: false,)
            )
        );
      }
    }
    else {
      isButtonClicked = false;
      isResponseReceived = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.editOrCreate == 'c' ?"Post create failed." : "Post update failed."),
      ));
    }
  }
  String getAvailablePerson(String customerOrDriver){
    if(customerOrDriver == 'Customer'){
      return widget.totalPersonController.text;
    }else{
      return widget.seatController.text;
    }
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
                      color: _customerOrDriver == 'Customer'
                          ? Colors.black
                          : Colors.white,
                    ),
                    child: _customerOrDriver == 'Customer'
                        ? Container()
                        : TextFormField(
                            controller: widget.seatController,
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
                      color: _customerOrDriver == 'Customer'
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Colors.white,
                    ),
                    child: _customerOrDriver == 'Customer'
                        ? TextFormField(
                            controller: widget.totalPersonController,
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
                            controller: widget.productPrice,
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
                                    items: TransportationLocations.locationList.map<
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
                                    items: TransportationLocations.locationList.map<
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
                        DescriptionInputBox(descriptionController: widget.descriptionController,hint: "Describe your trip..."),
                        Container(
                          height: 35,
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(right: 10.0, bottom: 18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (isButtonClicked == false) {
                                isButtonClicked = true;
                                _sendPostToBackend(); //TODO
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
                  _customerOrDriver = 'Customer';
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
                  _customerOrDriver = 'Driver';
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
/*
  Future _sendPostToBackend2() async {
    var url = "http://www.birikikoli.com/mv_services/postPage/transportation/createPost.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['token'] = User.privateToken;
    request.fields['departureID'] = TransportationLocations.getIndexOfLocation(_selectedDeparture).toString();
    request.fields['destinationID'] = TransportationLocations.getIndexOfLocation(_selectedDestination).toString();
    request.fields['departureDate'] = DateTime.now().toString(); //TODO
    request.fields['availablePerson'] = getAvailablePerson(_customerOrDriver);
    request.fields['customerOrDriver'] = _customerOrDriver.toLowerCase()[0];
    request.fields['transportationPrice'] = widget.productPrice.text;
    request.fields['description'] = widget.descriptionController.text;
    //request.fields['currency'] = '₺';

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
          if (_customerOrDriver == 'Customer') {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TransportationPage(customerOrDriver: 'c', searchModeFlag: false,)
                )
            );
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TransportationPage(customerOrDriver: 'd', searchModeFlag: false,)
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
    });
  }
 */