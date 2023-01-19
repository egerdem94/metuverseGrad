import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/buyandsell/screens/SellPage.dart';
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class BuyandSellSearchPage extends StatefulWidget {
  @override
  _BuyandSellSearchPageState createState() => _BuyandSellSearchPageState();
}

class _BuyandSellSearchPageState extends State<BuyandSellSearchPage> {
  final _searchController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _currencyController = TextEditingController();

  void _submitSearch() {
    // code to perform search with the text in _searchController
    Get.to(BuySellPage(searchKey: _searchController.text, filteredProductPrice: _maxPriceController.text, filteredCurrency: _currencyController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
      drawer: MetuverseDrawer(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _maxPriceController,
              decoration: InputDecoration(
                hintText: 'Max Price...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _currencyController,
              decoration: InputDecoration(
                hintText: 'Currency...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Search'),
              onPressed: _submitSearch,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBuySellBottomNavigationBar(),
    );
  }
}
