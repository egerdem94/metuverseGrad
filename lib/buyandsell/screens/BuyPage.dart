import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/CustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/buyandsell/widgets/buyandSellAppBar.dart';
import 'package:metuverse/buyandsell/widgets/BuyPostContainer.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../../storage/User.dart';
import '../models/SellPostList.dart';
import '../widgets/SellPostContainer.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({
    Key? key,
    required this.searchKey,
    required this.filteredProductPrice,
    required this.filteredCurrency,
  }) : super(key: key);

  final String searchKey;
  final String filteredProductPrice;
  final String filteredCurrency;
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  //late List<Product> products;
  BuySellPostList? buyandsellPostsListObject;

  Future _buyandsell_posts_searchandfilter() async {
    String serviceAddress =
    //'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter.php';
        'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter_deneme.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    //print("yavuz_token: " + User.token);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      "buyerOrSeller": "b", //seller
      "searchKey": widget.searchKey,
      "filteredProductPrice": widget.filteredProductPrice,
      "filteredCurrency": widget.filteredCurrency,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      buyandsellPostsListObject = BuySellPostList.fromJson(jsonObject);
    });
  }

  @override
  void initState() {
    super.initState();
    //_loadProducts();
    //products = dummyProducts;
    _buyandsell_posts_searchandfilter();
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
        child: buyandsellPostsListObject != null ? ListView.builder(
          itemCount: buyandsellPostsListObject?.total,
          itemBuilder: (context, index) {
            return BuyPostContainer(
                post: buyandsellPostsListObject!.items![index]);
          },
        )
      :Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Loading..."),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text("Retry"),
                onPressed: () => _buyandsell_posts_searchandfilter(),
              )
            ],
          ),
        )
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
