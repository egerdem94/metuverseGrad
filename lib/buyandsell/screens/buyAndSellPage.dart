import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/buyandsell/widgets/buyandSellAppBar.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../../util/user.dart';
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

  const BuySellPage({
    Key? key,
    required this.searchKey,
    required this.filteredProductPrice,
    required this.filteredCurrency,
  }) : super(key: key);

  final String searchKey;
  final String filteredProductPrice;
  final String filteredCurrency;

  @override
  _BuySellPageState createState() => _BuySellPageState();
}

class _BuySellPageState extends State<BuySellPage> {
  //late List<Product> products;
  buyandsellPostsList? buyandsellPostsListObject;

  Future _buyandsell_posts_searchandfilter() async {
    String serviceAddress =
        'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter.php';
        //'http://www.birikikoli.com/mv_services/buyandsell_posts_create_deneme.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    print("yavuz_token: " + User.token);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      "buyerOrSeller": "s", //seller
      "searchKey": widget.searchKey,
      "filteredProductPrice": widget.filteredProductPrice,
      "filteredCurrency": widget.filteredCurrency,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      buyandsellPostsListObject = buyandsellPostsList.fromJson(jsonObject);
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
        child: ListView.builder(
          itemCount: buyandsellPostsListObject?.total,
          itemBuilder: (context, index) {
            return ProductContainer(
                singlePostItem: buyandsellPostsListObject!.items![index]);
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
