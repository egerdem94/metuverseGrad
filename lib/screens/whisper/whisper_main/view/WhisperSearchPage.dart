import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/WhisperPage.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';
import 'package:metuverse/widgets/app_bar.dart';

class WhisperSearchPage extends StatefulWidget {

  const WhisperSearchPage();
  @override
  _WhisperSearchPage createState() => _WhisperSearchPage();
}

class _WhisperSearchPage extends State<WhisperSearchPage> {
  final searchController = TextEditingController();

  void _submitSearch() {
    // code to perform search with the text in _searchController
    if(searchController.text == ''){
      Get.snackbar('error', 'Please enter description');
      return;
    }
    Get.offAll(WhisperPage(
        searchModeFlag: true,
        searchKey: searchController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MetuverseAppBar(),
      //drawer: MetuverseDrawer(),
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
            ElevatedButton(
              child: Text('Search'),
              onPressed: _submitSearch,
            ),
          ],
        ),
      ),
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,)
    );
  }
}
