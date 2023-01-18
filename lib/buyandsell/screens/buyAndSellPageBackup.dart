/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../models/buyAndSellPostList.dart';
import '../models/product.dart';
import '../widgets/productContainer.dart';

List<Product> dummyProducts = [
  Product(
    name: 'Product 1',
    price: 10.0,
    imageUrl: [
      'https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp',
      'https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp',
      'https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp',
      'https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp',
      'https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp',
    ],
    description: 'selling box',
    id: '1',
    sellerId: '123',
    sellerName: 'user 1 ',
    isAvailable: true,
  ),
  Product(
    name: 'Product 2',
    price: 20.0,
    imageUrl: [
      'https://upload.wikimedia.org/wikipedia/commons/4/45/GuitareClassique5.png',
    ],
    description: 'selling guitar',
    id: '2',
    sellerId: '123',
    sellerName: 'user 2',
    isAvailable: false,
  ),
  Product(
    name: 'Product 3',
    price: 30.0,
    imageUrl: [
      'https://upload.wikimedia.org/wikipedia/commons/4/45/GuitareClassique5.png',
    ],
    description: 'selling guitar',
    id: '3',
    sellerId: '123',
    sellerName: 'user 3',
    isAvailable: true,
  ),
];

List<Product> productsFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<Product>.from(
    jsonData.map((x) => Product.fromJson(x)),
  );
}

class BuySellPage extends StatefulWidget {
  @override
  _BuySellPageState createState() => _BuySellPageState();
}

class _BuySellPageState extends State<BuySellPage> {
  late List<Product> products;


  buyandsellPostsList? buyandsellPostsListObject;
  @override
  void initState() {
    super.initState();
    //_loadProducts();
    products = dummyProducts;
    _buyandsell_posts_list();
  }

  void _buyandsell_posts_list() async {
    String serviceAddress = 'http://www.birikikoli.com/mv_services/buyandsell_posts_list.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    buyandsellPostsListObject = buyandsellPostsList.fromJson(jsonObject);
  }

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
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductContainer(singlePostItem: products[index], isSeller: false);
          },
        ),
      ),
      bottomNavigationBar: CustomBuySellBottomNavigationBar(),
    );
  }

*/
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
  }*//*

}
*/
