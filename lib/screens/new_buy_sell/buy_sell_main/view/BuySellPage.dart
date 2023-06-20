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

class BuySellPage extends StatefulWidget {
  final buyOrSell;
  final searchModeFlag;
  final searchKey;
  final filteredProductPrice;
  final filteredCurrency;

  const BuySellPage({
    required this.buyOrSell,
    required this.searchModeFlag,
    Key? key,
    this.searchKey,
    this.filteredProductPrice,
    this.filteredCurrency,
  }) : super(key: key);

  @override
  _BuySellPageState createState() => _BuySellPageState();
}

class _BuySellPageState extends State<BuySellPage> {
  final _scrollController = ScrollController();
  late BuySellPostHandler buySellPostHandler;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    buySellPostHandler = BuySellPostHandler();
    buySellPostHandler.init().then((_) {
      if (widget.searchModeFlag) {
        buySellPostHandler
            .handleSearchPosts(widget.searchKey, widget.filteredProductPrice,
                widget.filteredCurrency, widget.buyOrSell)
            .then((_) {
          setState(() {});
        });
      } else {
        buySellPostHandler
            .handlePostList(widget.buyOrSell, true,false,0)
            .then((_) {
          setState(() {});
        });
      }
      // Start the delayed future to periodically check the condition
      if (widget.searchModeFlag) {
        Future.delayed(Duration(milliseconds: 1000), () {
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        _startDelayedFuture();
      }
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

  void _scrollListener() {
    if (!widget.searchModeFlag) {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Load more data
        setState(() {
          buySellPostHandler
              .handlePostList(widget.buyOrSell, false,false,0)
              .then((_) {
            setState(() {});
          });
        });
      }
    }
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
          BuySellBottomNavigationBar(
            buyOrSell: widget.buyOrSell,
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(BuySellCreatePostPage(
            buyOrSell: widget.buyOrSell,
          ));
        },
        shape: CircleBorder(), // set the shape to a circle
        backgroundColor: Colors
            .blue, // make the background transparent so that the border is visible
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Place the FAB to the bottom-right corner
    );
  }

  ListView buildPostListView() {
    return ListView.builder(
      controller: _scrollController,
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
                    //rebuild widget
                  });
                },
                onlineOrOfflineImage: widget.searchModeFlag
                    ? 'online'
                    : 'offline', // onlineOrOffline value here
              )
            : BuyPostContainer(
                post: buySellPostHandler.buyPostList.posts![index],
                onDeletePressedArgument: () {
                  setState(() {
                    buySellPostHandler.buyPostList.posts!.removeAt(index);
                  });
                },
                onlineOrOfflineImage: widget.searchModeFlag
                    ? 'online'
                    : 'offline', onUpdateArgument:(){
                        setState(() {
                          //rebuild widget
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
