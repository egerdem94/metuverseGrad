import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/screens/sport/sport_main/view/SportPage.dart';
import 'package:metuverse/widgets/app_bar.dart';

class SportSearchPage extends StatefulWidget {

  const SportSearchPage({super.key});
  @override
  _SportSearchPageState createState() =>
      _SportSearchPageState();
}

class _SportSearchPageState extends State<SportSearchPage> {
  final searchController = TextEditingController();
  String selectedSport = 'Not Selected';

  final List<String> _sportOptions = [
    'Not Selected',
    'Football',
    'Basketball',
    'Volleyball',
    'Tennis',
    'Squash',
    'Mini Golf',
    'Chess',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _submitSearch() {
    int count = 0;
    if (selectedSport == 'Not Selected' || selectedSport == '') {
      selectedSport = '';
      count++;
    } else {
      selectedSport = _sportOptions.indexOf(selectedSport) as String;
    }
    if (searchController.text == '') {
      count++;
    }
    if (count == 2) {
      Get.snackbar('Error',
          'Please fill at least one field'); //TODO Ege - Change this snack bar with more readable one
      return;
    }
    Get.offAll(
        SportPage(
        searchModeFlag: true,
        searchKey: searchController.text,
        selectedSportID: selectedSport,
        notificationMode: false,
        )
    );
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
              key: ValueKey('searchField'),
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              key: ValueKey('departureDropdown'),
              isExpanded: true,
              value: selectedSport,
              hint: Text('Select Sport'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSport = newValue!;
                });
              },
              items: _sportOptions
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              key: ValueKey('searchButton'),
              child: Text('Search'),
              onPressed: _submitSearch,
            ),
          ],
        ),
      ),
      /*bottomNavigationBar: TransportationSubpageNavigation(
        customerOrDriver: widget.customerOrDriver,
      ),*/
    );
  }
}
