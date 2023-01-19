import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/buyandsell/widgets/buyandSellAppBar.dart';
import 'package:metuverse/buyandsell/widgets/BuyPostContainer.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../../util/user.dart';
import '../models/buyAndSellPostList.dart';
import '../widgets/SellPostContainer.dart';

class lookingForPage extends StatefulWidget {
  @override
  _lookingForPageState createState() => _lookingForPageState();
}

class _lookingForPageState extends State<lookingForPage> {
  //late List<Product> products;
  BuySellPostList? lookingForPostsListObject;

  Future _lookingfor_posts_list() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/buyandsell_posts_list.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      //"buyerorseller":"b",
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      lookingForPostsListObject = BuySellPostList.fromJson(jsonObject);
    });
  }

  @override
  void initState() {
    super.initState();
    //_loadProducts();
    //products = dummyProducts;
    _lookingfor_posts_list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuyandSellAppBar(),
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
          itemCount: lookingForPostsListObject?.total,
          itemBuilder: (context, index) {
            return BuyPostContainer(
                post: lookingForPostsListObject!.items![index]);
          },
        ),
      ),
      bottomNavigationBar: CustomBuySellBottomNavigationBar(),
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
