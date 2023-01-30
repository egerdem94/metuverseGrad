import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metuverse/buyandsell/widgets/buySellBottom.dart';
import 'package:metuverse/buyandsell/widgets/buyandSellAppBar.dart';
import 'package:metuverse/buyandsell/widgets/BuyPostContainer.dart';
import 'package:metuverse/util/GlobalBuyPostList.dart';
import 'package:metuverse/util/models/NewBuySellPostList.dart';
import 'package:metuverse/util/user.dart';
import 'package:metuverse/widgets/app_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../widgets/NewBuyPostContainer.dart';


class NewBuyPage extends StatefulWidget {
  const NewBuyPage({
    Key? key,
  }) : super(key: key);

  @override
  _NewBuyPageState createState() => _NewBuyPageState();
}

class _NewBuyPageState extends State<NewBuyPage> {
  NewBuySellPostList? buyandsellPostsListObject;
  //GlobalBuyPostList globalBuyPostList = GlobalBuyPostList();


  @override
  void initState() {
    super.initState();
    GlobalBuyPostList.apiCall().then((_) {
      setState(() {
        buyandsellPostsListObject = GlobalBuyPostList.getBuySellPostList();
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
              return NewBuyPostContainer(
                  newPost: buyandsellPostsListObject!.items![index]);
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
