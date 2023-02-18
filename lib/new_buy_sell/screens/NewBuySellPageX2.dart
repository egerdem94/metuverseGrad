import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyAndSellAppBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyPostContainer.dart';
import 'package:metuverse/new_buy_sell/widgets/NewCustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewSellPostContainer.dart';
import 'package:metuverse/storage/BuySellPostController.dart';
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
  NewBuySellPostListX? newBuySellPostListX;

  @override
  void initState() {
    super.initState();
    GlobalBuySellPostList.initialBuySellApiCall(widget.buyOrSell).then((_) {
      setState(() {
        newBuySellPostListX = GlobalBuySellPostList.getBuySellPostList(widget.buyOrSell);
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
          child: newBuySellPostListX != null ?
          widget.buyOrSell == 's' ? ListView.builder(
            itemCount: newBuySellPostListX!.length(),
            itemBuilder: (context, index) {
              return NewSellPostContainer(
                  post: newBuySellPostListX!.newBuySellPostListX![index]);
            },
          ):ListView.builder(
            itemCount: newBuySellPostListX!.length(),
            itemBuilder: (context, index) {
              return NewBuyPostContainer(
                  newPost: newBuySellPostListX!.newBuySellPostListX![index]);
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
                  onPressed: () => GlobalBuySellPostList.initialBuySellApiCall(widget.buyOrSell),
                )
              ],
            ),
          )
      ),
      bottomNavigationBar: NewCustomBuySellBottomNavigationBar(),
    );
  }

}
