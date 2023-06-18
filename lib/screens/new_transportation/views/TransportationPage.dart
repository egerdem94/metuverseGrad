import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/controller/storage/TransportationPostHandler.dart';
import 'package:metuverse/screens/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/screens/new_transportation/views/widgets/TransportationBottomNavigationBar.dart';
import 'package:metuverse/screens/new_transportation/views/widgets/TransportationAppBar.dart';
import 'package:metuverse/screens/new_transportation/views/widgets/TransportationDriverContainer.dart';
import 'package:metuverse/screens/new_transportation/views/widgets/TransportationCustomerContainer.dart';
import 'package:metuverse/widgets/drawer.dart';



class TransportationPage extends StatefulWidget {
  final customerOrDriver;
  final departureLocation;
  final destinationLocation;
  final searchModeFlag;
  final searchKey;

  const TransportationPage({
    required this.customerOrDriver,
    required this.searchModeFlag,
    this.departureLocation,
    this.destinationLocation,
    this.searchKey,
    Key? key,
  }) : super(key: key);

  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  final _scrollController = ScrollController();
  TransportationPostList? transportationPostList;
  late TransportationPostHandler transportationPostHandler;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    transportationPostHandler = TransportationPostHandler();
    transportationPostHandler.init().then((_) {
      if(widget.searchModeFlag){
        transportationPostHandler.handleSearchPosts(widget.searchKey, widget.departureLocation, widget.destinationLocation, widget.customerOrDriver).then((_) {
          setState(() {
            transportationPostList = transportationPostHandler.getTransportationPostList(widget.customerOrDriver);
          });
        });

      }
      else{
        transportationPostHandler.handlePostList(widget.customerOrDriver,true).then((_) {
          setState(() {
            transportationPostList = transportationPostHandler.getTransportationPostList(widget.customerOrDriver);
          });
        });

      }
    });
  }
  void _scrollListener() {
    if(!widget.searchModeFlag){
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        // Load more data
        setState(() {
          transportationPostHandler.handlePostList(widget.customerOrDriver,false).then((_) {
            setState(() {
              transportationPostList = transportationPostHandler.getTransportationPostList(widget.customerOrDriver);
            });
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransportationAppBar(customerOrDriver: widget.customerOrDriver,),
      //drawer: MetuverseDrawer(),
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
        child: transportationPostList != null ?
        widget.customerOrDriver == 'c' ? ListView.builder(
          controller: _scrollController,
          itemCount: transportationPostList!.length(),
          itemBuilder: (context, index) {
            return TransportationCustomerContainer(
                //post: newTransportationPostListX!.posts![index]);
              post: transportationPostList!.posts![index],
              onDeletePressedArgument: () {
                setState(() {
                  transportationPostList!.posts!.removeAt(index);
                });
              },
            );
          },
        ):ListView.builder(
          controller: _scrollController,
          itemCount: transportationPostList!.length(),
          itemBuilder: (context, index) {
            return TransportationDriverContainer(
              post: transportationPostList!.posts![index],
              onDeletePressedArgument: () {
                setState(() {
                  transportationPostList!.posts!.removeAt(index);
                });
              },
            );
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
      bottomNavigationBar: TransportationBottomNavigationBar(customerOrDriver: widget.customerOrDriver,),
    );
  }
}
