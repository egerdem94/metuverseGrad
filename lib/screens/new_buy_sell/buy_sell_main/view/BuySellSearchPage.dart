import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/CustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/BuySellPostHandler.dart';
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
    if(searchController.text == '' && maxPriceController.text == '' && currencyController.text == ''){
      Get.snackbar('error', 'Please enter at least one search parameter');
      return;
    }
    Get.offAll(BuySellPage(
        buyOrSell: widget.buyOrSell,
        searchModeFlag: true,
        searchKey: searchController.text,
        filteredProductPrice: maxPriceController.text,
        filteredCurrency: currencyController.text,
        notificationMode: false,));
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
