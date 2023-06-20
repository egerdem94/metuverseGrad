import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyAndSellAppBar.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyPostContainer.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuySellBottomNavigationBar.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/SellPostContainer.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/BuySellPostHandler.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/LoadingIndicator.dart';
import 'package:metuverse/widgets/NothingToDisplay.dart';
import 'package:metuverse/widgets/bottom_navigation_bar.dart';
import 'package:metuverse/widgets/drawer.dart';

import '../../create_edit_post/view/BuySellCreatePostPage.dart';

class BuySellNotificationPage extends StatefulWidget {
  final buyOrSell;
  final int postID;
  const BuySellNotificationPage({
    required this.buyOrSell,
    required this.postID,
    Key? key,
  }) : super(key: key);

  @override
  _BuySellNotificationPageState createState() => _BuySellNotificationPageState();
}

class _BuySellNotificationPageState extends State<BuySellNotificationPage> {
  late BuySellPostHandler buySellPostHandler;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    buySellPostHandler = BuySellPostHandler();
    buySellPostHandler.init().then((_) {

    buySellPostHandler
        .handlePostList(widget.buyOrSell, true,true,widget.postID)
        .then((_) {
      setState(() {});
    });
    _startDelayedFuture();
    });
  }

  void _startDelayedFuture() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return; // Check if the widget is still mounted
      if (!buySellPostHandler.ready) {
        _startDelayedFuture(); // Call the method again to continue checking
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuySellAppBar(
        buyOrSell: widget.buyOrSell,
      ),
      //drawer: MetuverseDrawer(),

      body: Column(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: GeneralUtil.sellBuyBoxDecoration(),
              child: _isLoading
                  ? LoadingIndicator()
                  : RefreshIndicator(
                onRefresh: _handleRefresh,
                child: !buySellPostHandler.sellPostList.isEmpty() ||
                    !buySellPostHandler.buyPostList.isEmpty()
                    ? buildPostListView()
                    : NothingToDisplay(),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BuySellSubpageNavigator(),
    );
  }

  ListView buildPostListView() {
    return ListView.builder(
      itemCount: widget.buyOrSell == 's'
          ? buySellPostHandler.sellPostList.length()
          : buySellPostHandler.buyPostList.length(),
      itemBuilder: (context, index) {
        return widget.buyOrSell == 's'
            ? SellPostContainer(
          post: buySellPostHandler.sellPostList.posts![index],
          onDeletePressedArgument: () {
            setState(() {
              buySellPostHandler.sellPostList.posts!.removeAt(index);
            });
          },
          onToggleArgument:(){
            setState(() {
            });
          },
          onlineOrOfflineImage: 'offline', // onlineOrOffline value here
        )
            : BuyPostContainer(
          post: buySellPostHandler.buyPostList.posts![index],
          onDeletePressedArgument: () {
            setState(() {
              buySellPostHandler.buyPostList.posts!.removeAt(index);
            });
          },
          onlineOrOfflineImage: 'offline', onUpdateArgument:(){
          setState(() {
          });
        }, // onlineOrOffline value here
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    Future.delayed(Duration(seconds: 3)).then((_) {
      setState(() {});
    });
  }
}
