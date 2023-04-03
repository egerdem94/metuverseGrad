/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:metuverse/new_transportation/model/TransportationPost.dart';
import 'package:metuverse/new_transportation/widget/CustomTransportationBottomNavigationBar.dart';
import 'package:metuverse/new_transportation/widget/TransportationCustomerContainer.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';


class TransportationPage extends StatefulWidget {
  final driverOrPassenger;
  final searchModeFlag;

  const TransportationPage({super.key, required this.driverOrPassenger, required this.searchModeFlag});
  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  List<TransportationPost> dummyList = [
    TransportationPost(
      belongToUser: true,
      fullName: "Yavuz Erbaş",
      profilePicture: null,
      postID: 1,
      description: "If anyone going to girne. I can join",
      productPrice: 200,
      currency: "USD",
      transportationStatus: 1,
    ),
    TransportationPost(
      belongToUser: false,
      fullName: "Batuhan SANDIKCI",
      profilePicture: null,
      postID: 2,
      description: "I will go to Ercan wednesday 9pm.",
      productPrice: null,
      currency: null,
      transportationStatus: 0,
    ),
    TransportationPost(
      belongToUser: true,
      fullName: "Ali Veli",
      profilePicture: null,
      postID: 3,
      description: "Me and my friends looking for ride to lefkoşa tonight.",
      productPrice: 1000,
      currency: "USD",
      transportationStatus: 1,
    ),
    TransportationPost(
      belongToUser: true,
      fullName: "Yavuz Erbaş",
      profilePicture: null,
      postID: 1,
      description: "If anyone going to girne. I can join",
      productPrice: 200,
      currency: "USD",
      transportationStatus: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadDummyProducts();
  }

  void _loadDummyProducts() {
    setState(() {
      transportationPostsListObject =
          TransportationPostsList(items: dummyList, total: dummyList.length);
    });
  }

  //late List<Product> products;
  TransportationPostsList? transportationPostsListObject;

  Future<void> _refreshPosts() async {
    // This is where you would normally make an HTTP request to fetch new data.
    // For this example, we just simulate a delay.
    await Future.delayed(Duration(seconds: 2));
    _loadDummyProducts();
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
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshPosts,
          child: ListView.builder(
            itemCount: transportationPostsListObject?.total,
            itemBuilder: (context, index) {
              return TransportationContainer(
                singlePostItem: transportationPostsListObject!.items![index],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomTransportationBottomNavigationBar(),
    );
  }
}
*/
