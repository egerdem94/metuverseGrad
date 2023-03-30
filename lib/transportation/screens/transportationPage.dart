import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/transportation/widget/transportationContainer.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../../storage/User.dart';
import '../model/transportationPostList.dart';
import '../widget/transportationBottom.dart';
import '../widget/transportationCarContainer.dart';

class TransportationPage extends StatefulWidget {
  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  List<SinglePostItem> dummyList = [
    SinglePostItem(
      belongToUser: true,
      fullName: "Yavuz Erbaş",
      profilePicture: null,
      postID: 1,
      description: "If anyone going to girne. I can join",
      productPrice: 200,
      currency: "USD",
      productStatus: 1,
    ),
    SinglePostItem(
      belongToUser: false,
      fullName: "Batuhan SANDIKCI",
      profilePicture: null,
      postID: 2,
      description: "I will go to Ercan wednesday 9pm.",
      productPrice: null,
      currency: null,
      productStatus: 0,
    ),
    SinglePostItem(
      belongToUser: true,
      fullName: "Ali Veli",
      profilePicture: null,
      postID: 3,
      description: "Me and my friends looking for ride to lefkoşa tonight.",
      productPrice: 1000,
      currency: "USD",
      productStatus: 1,
    ),
    SinglePostItem(
      belongToUser: true,
      fullName: "Yavuz Erbaş",
      profilePicture: null,
      postID: 1,
      description: "If anyone going to girne. I can join",
      productPrice: 200,
      currency: "USD",
      productStatus: 1,
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
          transportationPostsList(items: dummyList, total: dummyList.length);
    });
  }

  //late List<Product> products;
  transportationPostsList? transportationPostsListObject;

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
