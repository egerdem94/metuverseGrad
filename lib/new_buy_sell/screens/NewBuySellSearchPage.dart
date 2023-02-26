import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/new_buy_sell/screens/NewBuySellPageX.dart';
import 'package:metuverse/new_buy_sell/widgets/NewCustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/storage/BuySellPostHandler.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class NewBuySellSearchPage extends StatefulWidget {
  @override
  _NewBuySellSearchPageState createState() => _NewBuySellSearchPageState();
}

class _NewBuySellSearchPageState extends State<NewBuySellSearchPage> {
  final _searchController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _currencyController = TextEditingController();

  void _submitSearch() {
    // code to perform search with the text in _searchController
    //Get.to(SellPage(searchKey: _searchController.text, filteredProductPrice: _maxPriceController.text, filteredCurrency: _currencyController.text));
    BuySellPostHandler.ToDoSearch();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NewBuySellPageX(buyOrSell: 's',searchModeFlag: true,)));
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
      bottomNavigationBar: NewCustomBuySellBottomNavigationBar(),
    );
  }
}
