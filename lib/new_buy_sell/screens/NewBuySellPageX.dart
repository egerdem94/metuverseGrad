import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyAndSellAppBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewBuyPostContainer.dart';
import 'package:metuverse/new_buy_sell/widgets/NewCustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/new_buy_sell/widgets/NewSellPostContainer.dart';
import 'package:metuverse/storage/GlobalBuySellPostList.dart';
import 'package:metuverse/storage/models/NewBuySellPostListX.dart';
import 'package:metuverse/widgets/drawer.dart';



class NewBuySellPageX extends StatefulWidget {
  final buyOrSell;
  final searchModeFlag;
  const NewBuySellPageX({
    required this.buyOrSell,
    required this.searchModeFlag,
    Key? key,
  }) : super(key: key);

  @override
  _NewBuySellPageXState createState() => _NewBuySellPageXState();
}

class _NewBuySellPageXState extends State<NewBuySellPageX> {
  NewBuySellPostListX? newBuySellPostList2;

  @override
  void initState() {
    super.initState();
    GlobalBuySellPostList.initialBuySellApiCall(widget.buyOrSell).then((_) {
      setState(() {
        newBuySellPostList2 = GlobalBuySellPostList.getBuySellPostList(widget.buyOrSell);
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
          child: newBuySellPostList2 != null ?
            widget.buyOrSell == 's' ? ListView.builder(
              itemCount: newBuySellPostList2!.total,
              itemBuilder: (context, index) {
                return NewSellPostContainer(
                    post: newBuySellPostList2!.newBuySellPostListX![index]);
              },
            ):ListView.builder(
              itemCount: newBuySellPostList2!.total,
              itemBuilder: (context, index) {
                return NewBuyPostContainer(
                    newPost: newBuySellPostList2!.newBuySellPostListX![index]);
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
