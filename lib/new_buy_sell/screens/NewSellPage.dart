import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/buyandsell/widgets/buyandSellAppBar.dart';
import 'package:metuverse/buyandsell/widgets/BuyPostContainer.dart';
import 'package:metuverse/new_buy_sell/widgets/NewSellPostContainer.dart';
import 'package:metuverse/storage/GlobalBuyPostList.dart';
import 'package:metuverse/storage/GlobalSellPostList.dart';
import 'package:metuverse/storage/models/NewBuyPostList.dart';
import 'package:metuverse/storage/User.dart';
import 'package:metuverse/storage/models/NewSellPostList2.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../widgets/NewBuyPostContainer.dart';


class NewSellPage extends StatefulWidget {
  const NewSellPage({
    Key? key,
  }) : super(key: key);

  @override
  _NewSellPageState createState() => _NewSellPageState();
}

class _NewSellPageState extends State<NewSellPage> {
  NewSellPostList2? buyandsellPostsListObject;
  //GlobalBuyPostList globalBuyPostList = GlobalBuyPostList();


  @override
  void initState() {
    super.initState();
    GlobalSellPostList.initialApiCall().then((_) {
      setState(() {
        buyandsellPostsListObject = GlobalSellPostList.getSellPostList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuyandSellAppBar(),
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
            ), // set the background color to blue
          ),
          child: buyandsellPostsListObject != null ? ListView.builder(
            itemCount: buyandsellPostsListObject!.total,
            itemBuilder: (context, index) {
              return NewSellPostContainer(
                  post: buyandsellPostsListObject!.items![index]);
            },
          )
              :Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Loading..."),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text("Retry"),
                  onPressed: () => GlobalBuyPostList.apiCall(),
                )
              ],
            ),
          )
      ),
      bottomNavigationBar: CustomBuySellBottomNavigationBar(),
    );
  }

}
