import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationLocations.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/TransportationPage.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/TransportationBottomNavigationBar.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

class TransportationSearchPage extends StatefulWidget {
  final customerOrDriver;

  const TransportationSearchPage({super.key, required this.customerOrDriver});
  @override
  _TransportationSearchPageState createState() =>
      _TransportationSearchPageState();
}

class _TransportationSearchPageState extends State<TransportationSearchPage> {
  final searchController = TextEditingController();
  String? departure;
  String? destination;

  final List<String> _locationOptions = [
    'Not Selected',
    'Campus',
    'Ercan',
    'Girne',
    'Güzelyurt',
    'Kalkanli',
    'Karpaz',
    'Lefke',
    'Lefkoşa',
    'Mağusa',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _submitSearch() {
    int count = 0;
    if (destination == null ||
        destination == 'Not Selected' ||
        destination == '') {
      destination = '';
      count++;
    } else {
      destination =
          TransportationLocations.getIndexOfLocation(destination!).toString();
    }
    if (departure == null || departure == 'Not Selected' || departure == '') {
      departure = '';
      count++;
    } else {
      departure =
          TransportationLocations.getIndexOfLocation(departure!).toString();
    }
    if (searchController.text == '') {
      count++;
    }
    if (count == 3) {
      Get.snackbar('Error',
          'Please fill at least one field'); //TODO Ege - Change this snack bar with more readable one
      return;
    }
    Get.offAll(TransportationPage(
        customerOrDriver: widget.customerOrDriver,
        searchModeFlag: true,
        searchKey: searchController.text,
        departureLocation: departure,
        destinationLocation: destination));
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
              value: departure,
              hint: Text('Select Departure'),
              onChanged: (String? newValue) {
                setState(() {
                  departure = newValue;
                });
              },
              items: _locationOptions
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              key: ValueKey('destinationDropdown'),
              isExpanded: true,
              value: destination,
              hint: Text('Select Destination'),
              onChanged: (String? newValue) {
                setState(() {
                  destination = newValue;
                });
              },
              items: _locationOptions
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
      bottomNavigationBar: TransportationBottomNavigationBar(
        customerOrDriver: widget.customerOrDriver,
      ),
    );
  }
}
