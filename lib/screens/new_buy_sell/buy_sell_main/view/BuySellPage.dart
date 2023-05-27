import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyAndSellAppBar.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyPostContainer.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/CustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/SellPostContainer.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/controller/data/BuySellPostHandler.dart';
import 'package:metuverse/widgets/LoadingIndicator.dart';
import 'package:metuverse/widgets/NothingToDisplay.dart';
import 'package:metuverse/widgets/drawer.dart';

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
        buySellPostHandler.handlePostList(widget.buyOrSell, true).then((_) {
          setState(() {});
        });
      }

      // Set the _isLoading flag to false after 0.5 seconds
      /*Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          _isLoading = false;
        });
      });*/
      // Start the delayed future to periodically check the condition
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
  void _scrollListener() {
    if (!widget.searchModeFlag) {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Load more data
        setState(() {
          buySellPostHandler.handlePostList(widget.buyOrSell, false).then((_) {
            setState(() {});
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(
        buyOrSell: widget.buyOrSell,
      ),
      drawer: MetuverseDrawer(),
      body: DecoratedBox(
        decoration: metuverseBoxDecoration(),
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
      bottomNavigationBar: CustomBuySellBottomNavigationBar(
        buyOrSell: widget.buyOrSell,
      ),
    );
  }

  BoxDecoration metuverseBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ), // set the background color to blue
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
        )
            : BuyPostContainer(
          post: buySellPostHandler.buyPostList.posts![index],
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