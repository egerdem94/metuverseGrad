import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
//import 'package:metuverse/buyandsell/widgets/BuyPostContainer.dart';
import 'package:metuverse/transportation/widget/transportationCarContainer.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';
import '../model/transportationPostList.dart';
import '../widget/transportationBottom.dart';

class TransportationCarPage extends StatefulWidget {
  @override
  _TransportationCarPageState createState() => _TransportationCarPageState();
}

class _TransportationCarPageState extends State<TransportationCarPage> {
  List<SinglePostItem> dummyList = [
    SinglePostItem(
      belongToUser: true,
      fullName: "Ali Veli",
      profilePicture: null,
      postID: 1,
      description:
          "I am going to girne if anyone want to join. We can split gas.",
      productPrice: 200,
      currency: "USD",
      productStatus: 1,
    ),
    SinglePostItem(
      belongToUser: false,
      fullName: "Jane Doe",
      profilePicture: null,
      postID: 2,
      description: "Going Lefkoşa",
      productPrice: 100,
      currency: null,
      productStatus: 0,
    ),
    SinglePostItem(
      belongToUser: true,
      fullName: "Bob Johnson",
      profilePicture: null,
      postID: 3,
      description: "Going Ercan tonight. I have 3 available seats",
      productPrice: 100,
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
      transportationCarPostsListObject =
          transportationPostsList(items: dummyList, total: dummyList.length);
    });
  }

  //late List<Product> products;
  transportationPostsList? transportationCarPostsListObject;

  Future _lookingfor_posts_list() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/buyandsell_posts_list.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      "token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      //"buyerorseller":"b",
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      transportationCarPostsListObject =
          transportationPostsList.fromJson(jsonObject);
    });
  }

  /* @override
  void initState() {
    super.initState();
    //_loadProducts();
    //products = dummyProducts;
    _lookingfor_posts_list();
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
          itemCount: transportationCarPostsListObject?.total,
          itemBuilder: (context, index) {
            return TransportationCarContainer(
                singlePostItem:
                    transportationCarPostsListObject!.items![index]);
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
