import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/transportation/widget/transportationContainer.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../../util/user.dart';
import '../model/transportationPostList.dart';
import '../widget/transportationBottom.dart';
import '../widget/transportationCarContainer.dart';

/*
List<Product> productsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Product>.from(
    jsonData.map((x) => Product.fromJson(x)),
  );
}
*/
class TransportationPage extends StatefulWidget {
  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  List<SinglePostItem> dummyList = [
    SinglePostItem(
      belongToUser: true,
      fullName: "Yavuz Erbaş",
      profilePicture: null,
      postID: 1,
      description: "If anyone going to girne. I can join",
      productPrice: 200,
      currency: "USD",
      productStatus: 1,
    ),
    SinglePostItem(
      belongToUser: false,
      fullName: "Batuhan SANDIKCI",
      profilePicture: null,
      postID: 2,
      description: "I will go to Ercan wednesday 9pm.",
      productPrice: null,
      currency: null,
      productStatus: 0,
    ),
    SinglePostItem(
      belongToUser: true,
      fullName: "Ali Veli",
      profilePicture: null,
      postID: 3,
      description: "Me and my friends looking for ride to lefkoşa tonight.",
      productPrice: 1000,
      currency: "USD",
      productStatus: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadDummyProducts();
  }

  void _loadDummyProducts() {
    setState(() {
      transportationPostsListObject =
          transportationPostsList(items: dummyList, total: dummyList.length);
    });
  }

  //late List<Product> products;
  transportationPostsList? transportationPostsListObject;
/*
  Future _transportation_posts_list() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/buyandsell_posts_list.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      //"buyerorseller":"s",
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      transportationPostsListObject =
          transportationPostsList.fromJson(jsonObject);
    });
  }*/

/*  @override
  void initState() {
    super.initState();
    //_loadProducts();
    //products = dummyProducts;
    //SinglePostItem = dummyList;
    //_transportation_posts_list();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
      drawer: MetuverseDrawer(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ), // set the background color to blue
        ),
        child: ListView.builder(
          itemCount: transportationPostsListObject?.total,
          itemBuilder: (context, index) {
            return TransportationContainer(
              singlePostItem: transportationPostsListObject!.items![index],
            );
          },
        ),
      ),
      bottomNavigationBar: CustomTransportationBottomNavigationBar(),
    );
  }

  /*void _loadProducts() async {
    // Replace 'https://example.com/api/products' with the URL of your server's API endpoint
    var response = await http.get('https://example.com/api/products');
    if (response.statusCode == 200) {
      List<Product> fetchedProducts = productsFromJson(response.body);
      setState(() {
        products = fetchedProducts;
      });
    } else {
      // Handle error
    }
  }*/
}
