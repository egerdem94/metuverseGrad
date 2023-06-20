import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationLocations.dart';
class CreateEditPostBackEnd{
  Future sendPostToBackend({
    required String selectedDeparture,
    required String selectedDestination,
    required String availablePerson,
    required String totalPerson,
    required String customerOrDriver,
    required String productPrice,
    required String description,
  }) async {
    var url = "http://www.birikikoli.com/mv_services/postPage/transportation/createPost.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['token'] = User.privateToken;
    request.fields['departureID'] = selectedDeparture;
    request.fields['destinationID'] = selectedDestination;
    request.fields['departureDate'] = DateTime.now().toString();
    request.fields['availablePerson'] = availablePerson;
    request.fields['totalPerson'] = totalPerson;
    request.fields['customerOrDriver'] = customerOrDriver.toLowerCase()[0];
    request.fields['transportationPrice'] = productPrice;
    request.fields['description'] = description;
    request.fields['currency'] = '₺';

    var responseStream = await request.send();
    var response = await http.Response.fromStream(responseStream);
    var message = jsonDecode(response.body);
    return message['processStatus'];
  }

}