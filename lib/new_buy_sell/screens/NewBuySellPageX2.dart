/*
import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyAndSellAppBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyPostContainer.dart';
import 'package:metuverse/new_buy_sell/widgets/NewCustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewSellPostContainer.dart';
import 'package:metuverse/storage/BuySellPostHandler.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';
import 'package:metuverse/widgets/drawer.dart';



class NewBuySellPageX2 extends StatefulWidget {
  final buyOrSell;
  final searchModeFlag;
  const NewBuySellPageX2({
    required this.buyOrSell,
    required this.searchModeFlag,
    Key? key,
  }) : super(key: key);

  @override
  _NewBuySellPageX2State createState() => _NewBuySellPageX2State();
}

class _NewBuySellPageX2State extends State<NewBuySellPageX2> {
  List<NewBuySellPostListX?> newBuySellPostListOfListX = [];

  @override
  void initState() {
    super.initState();
    GlobalBuySellPostList.handlePostList(widget.buyOrSell,true).then((_) {
      setState(() {
        newBuySellPostListOfListX = GlobalBuySellPostList.getBuySellPostLists(widget.buyOrSell);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(),
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
          child: newBuySellPostListOfListX != null ?
          widget.buyOrSell == 's' ? ListView.builder(
            itemCount: newBuySellPostListOfListX.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for(int i = 0; i < newBuySellPostListOfListX.length; i++){
                      Row(
                        children:[
                          Ex
                      ],
                      )
                  }
            }

                ],
              );
return NewSellPostContainer(
                  post: newBuySellPostListOfListX!.newBuySellPostListOfListX![index]);

            },
          ):ListView.builder(
            itemCount: newBuySellPostListOfListX.length,
            itemBuilder: (context, index) {
return NewBuyPostContainer(
                  newPost: newBuySellPostListOfListX!.newBuySellPostListOfListX![index]);

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
                  onPressed: () => GlobalBuySellPostList.handlePostList(widget.buyOrSell,true),
                )
              ],
            ),
          )
      ),
      bottomNavigationBar: NewCustomBuySellBottomNavigationBar(),
    );
  }

}
*/
