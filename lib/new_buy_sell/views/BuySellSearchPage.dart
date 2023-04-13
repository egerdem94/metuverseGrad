import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/new_buy_sell/views/BuySellPage.dart';
import 'package:metuverse/new_buy_sell/views/widgets/CustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/BuySellPostHandler.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class BuySellSearchPage extends StatefulWidget {
  final buyOrSell;

  const BuySellSearchPage({super.key, required this.buyOrSell});
  @override
  _BuySellSearchPageState createState() => _BuySellSearchPageState();
}

class _BuySellSearchPageState extends State<BuySellSearchPage> {
  final searchController = TextEditingController();
  final maxPriceController = TextEditingController();
  final currencyController = TextEditingController();
/*  late BuySellPostHandler buySellPostHandler;
  @override
  void initState() {
    super.initState();
    buySellPostHandler = BuySellPostHandler();
    buySellPostHandler.init().then((_) {});
  }*/

  void _submitSearch() {
    // code to perform search with the text in _searchController
    //Get.to(SellPage(searchKey: _searchController.text, filteredProductPrice: _maxPriceController.text, filteredCurrency: _currencyController.text));
    Get.offAll(BuySellPage(
        buyOrSell: widget.buyOrSell,
        searchModeFlag: true,
        searchKey: searchController.text,
        filteredProductPrice: maxPriceController.text,
        filteredCurrency: currencyController.text));
/*    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BuySellPage(buyOrSell: 's',searchModeFlag: true,)));*/
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
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: maxPriceController,
              decoration: InputDecoration(
                hintText: 'Max Price...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: currencyController,
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
      bottomNavigationBar: CustomBuySellBottomNavigationBar(
        buyOrSell: widget.buyOrSell,
      ),
    );
  }
}
