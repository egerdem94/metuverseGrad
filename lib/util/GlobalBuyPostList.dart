import 'dart:convert';

import 'package:metuverse/util/models/NewBuySellPostList.dart';
import 'package:http/http.dart' as http;
import 'package:metuverse/util/user.dart';

class GlobalBuyPostList{

  static NewBuySellPostList? newBuySellPostList = NewBuySellPostList(
    items: [
      NewPost(
        belongToUser: true,
        fullName: 'John Doe',
        profilePicture: 'http://www.birikikoli.com/images/profileMedia/userID4.jpg',
        postID: 1,
        media: 'http://www.birikikoli.com/images/nophoto.jpg',
        description: 'A new product',
        productPrice: 100,
        currency: 'TRY',
        productStatus: 1,
      ),
      NewPost(
        belongToUser: false,
        fullName: 'Jane Doe',
        profilePicture: 'http://www.birikikoli.com/images/profileMedia/userID3.jpeg',
        postID: 2,
        media: 'http://www.birikikoli.com/images/postMedia/buyandsellPage/image_picker6619120663119086887.png',
        description: 'Another new product',
        productPrice: 200,
        currency: 'TRY',
        productStatus: 1,
      ),
    ],
    total: 2,
  );

  static Future _buyandsell_posts_searchandfilter() async {
    String serviceAddress =
    //'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter.php';
        'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter_deneme.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    //print("yavuz_token: " + User.token);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      "buyerOrSeller": "b", //seller
      "searchKey": '',
      "filteredProductPrice": '',
      "filteredCurrency": '',
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    //setState(() {
    newBuySellPostList = NewBuySellPostList.fromJson(jsonObject);
    //});
  }
  static Future<bool> apiCall() async {
    await _buyandsell_posts_searchandfilter();
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  static NewBuySellPostList? getBuySellPostList(){
    return newBuySellPostList;
  }
}