import 'package:flutter/material.dart';
import 'package:metuverse/new_buy_sell/views/widgets/BuyAndSellAppBar.dart';
import 'package:metuverse/new_transportation/controller/storage/TransportationPostHandler.dart';
import 'package:metuverse/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/new_transportation/widget/CustomTransportationBottomNavigationBar.dart';
import 'package:metuverse/new_transportation/widget/TransportationDriverContainer.dart';
import 'package:metuverse/new_transportation/widget/TransportationCustomerContainer.dart';
import 'package:metuverse/widgets/drawer.dart';



class NewTransportationPage extends StatefulWidget {
  final customerOrDriver;
  final searchModeFlag;
  final searchKey;/*
  final filteredProductPrice;
  final filteredCurrency;*/

  const NewTransportationPage({
    required this.customerOrDriver,
    required this.searchModeFlag,
    Key? key, this.searchKey/* this.filteredProductPrice, this.filteredCurrency,*/
  }) : super(key: key);

  @override
  _NewTransportationPageState createState() => _NewTransportationPageState();
}

class _NewTransportationPageState extends State<NewTransportationPage> {
  final _scrollController = ScrollController();
  //BuySellPostList? newBuySellPostListX;
  NewTransportationPostList? newTransportationPostListX;
  //late BuySellPostHandler buySellPostHandler;
  late TransportationPostHandler transportationPostHandler;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    transportationPostHandler = TransportationPostHandler();
    transportationPostHandler.init().then((_) {
      setState(() {
          newTransportationPostListX = transportationPostHandler.getTransportationPostList(widget.customerOrDriver);
      });
    });
    /*buySellPostHandler = BuySellPostHandler();
    buySellPostHandler.init().then((_) {
      *//*if(widget.searchModeFlag){
        buySellPostHandler.handleSearchPosts(widget.searchKey,*//**//* widget.filteredProductPrice, widget.filteredCurrency*//**//*widget.customerOrDriver).then((_) {
          setState(() {
            newBuySellPostListX = buySellPostHandler.getBuySellPostList(widget.customerOrDriver);
          });
        });
      }
      else{
        buySellPostHandler.handlePostList(widget.customerOrDriver,true).then((_) {
          setState(() {
            newBuySellPostListX = buySellPostHandler.getBuySellPostList(widget.customerOrDriver);
          });
        });
      }*//*
    });*/
  }
  void _scrollListener() {
    if(!widget.searchModeFlag){
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        // Load more data
        setState(() {
          transportationPostHandler.handlePostList(widget.customerOrDriver,false).then((_) {
            setState(() {
              newTransportationPostListX = transportationPostHandler.getTransportationPostList(widget.customerOrDriver);
            });
          });
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(buyOrSell: widget.customerOrDriver,),
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
        child: newTransportationPostListX != null ?
        widget.customerOrDriver == 's' ? ListView.builder(
          controller: _scrollController,
          itemCount: newTransportationPostListX!.length(),
          itemBuilder: (context, index) {
            return TransportationCustomerContainer(
                //post: newTransportationPostListX!.posts![index]);
              singlePostItem: newTransportationPostListX!.posts![index]);
          },
        ):ListView.builder(
          controller: _scrollController,
          itemCount: newTransportationPostListX!.length(),
          itemBuilder: (context, index) {
            return TransportationDriverContainer(
              singlePostItem: newTransportationPostListX!.posts![index]);
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
                onPressed: () => transportationPostHandler.handlePostList(widget.customerOrDriver,true),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomTransportationBottomNavigationBar(customerOrDriver: widget.customerOrDriver,),
    );
  }

}
