import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/views/widgets/BuyAndSellAppBar.dart';
import 'package:metuverse/new_buy_sell/views/widgets/BuyPostContainer.dart';
import 'package:metuverse/new_buy_sell/views/widgets/CustomBuySellBottomNavigationBar.dart';
import 'package:metuverse/new_buy_sell/views/widgets/SellPostContainer.dart';
import 'package:metuverse/new_buy_sell/controllers/storage/BuySellPostHandler.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
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
  BuySellPostList? newBuySellPostListX;
  late BuySellPostHandler buySellPostHandler;

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
          setState(() {
            newBuySellPostListX =
                buySellPostHandler.getBuySellPostList(widget.buyOrSell);
          });
        });
        reAsk();
        reAsk();
        reAsk();
        reAsk();
        reAsk();
      } else {
        buySellPostHandler.handlePostList(widget.buyOrSell, true).then((_) {
          setState(() {
            newBuySellPostListX =
                buySellPostHandler.getBuySellPostList(widget.buyOrSell);
          });
        });
        reAsk();
        reAsk();
        reAsk();
        reAsk();
        reAsk();
      }
    });
  }

  void reAsk() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        newBuySellPostListX =
            buySellPostHandler.getBuySellPostList(widget.buyOrSell);
      });
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
            setState(() {
              newBuySellPostListX =
                  buySellPostHandler.getBuySellPostList(widget.buyOrSell);
            });
          });
        });
        reAsk();
        reAsk();
        reAsk();
        reAsk();
        reAsk();
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
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: newBuySellPostListX != null
              ? widget.buyOrSell == 's'
              ? buildSellPostListView()
              : buildBuyPostListView()
              : NothingToDisplay(),
        ),
      ),
      bottomNavigationBar: CustomBuySellBottomNavigationBar(
        buyOrSell: widget.buyOrSell,
      ),
    );
  }
  ListView buildSellPostListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: newBuySellPostListX!.length(),
      itemBuilder: (context, index) {
        return SellPostContainer(
            post: newBuySellPostListX!.posts![index]);
      },
    );
  }
  ListView buildBuyPostListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: newBuySellPostListX!.length(),
      itemBuilder: (context, index) {
        return BuyPostContainer(
            post: newBuySellPostListX!.posts![index]);
      },
    );
  }
  Future<void> _handleRefresh() async {
    Future.delayed(Duration(seconds: 3)).then((_) {
      setState(() {
        newBuySellPostListX =
            buySellPostHandler.getBuySellPostList(widget.buyOrSell);
      });
    });
  }
}

class NothingToDisplay extends StatelessWidget {
  const NothingToDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Nothing to display",style: TextStyle(color: Colors.white),),
            SizedBox(height: 10),
           /* ElevatedButton(
              child: Text("Retry"),
              onPressed: () => buySellPostHandler.handlePostList(
                  widget.buyOrSell, true),
            )*/
          ],
        ),
      );
  }

}
