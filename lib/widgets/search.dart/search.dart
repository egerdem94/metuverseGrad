import 'package:flutter/material.dart';
import 'package:metuverse/widgets/app_bar.dart';
import '../GeneralBottomNavigation.dart';
class SearchPersonPage extends StatefulWidget {
  @override
  _SearchPersonPageState createState() => _SearchPersonPageState();
}

class _SearchPersonPageState extends State<SearchPersonPage> {
  final _searchController = TextEditingController();

  void _submitSearch() {
    // code to perform search with the text in _searchController
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
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
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
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,),
    );
  }
}
