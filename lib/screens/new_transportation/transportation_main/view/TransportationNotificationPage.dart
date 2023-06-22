import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/controller/storage/TransportationPostHandler.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationPost.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/TransportationBottomNavigationBar.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/TransportationAppBar.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/TransportationDriverContainer.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/view/widget/TransportationCustomerContainer.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';

import '../../create_edit_post/view/TransportationCreatePostPage.dart';

class TransportationNotificationPage extends StatefulWidget {
  final customerOrDriver;
  final int postID;

  const TransportationNotificationPage({
    required this.customerOrDriver,
    required this.postID,
    Key? key,
  }) : super(key: key);

  @override
  _TransportationNotificationPageState createState() =>
      _TransportationNotificationPageState();
}

class _TransportationNotificationPageState
    extends State<TransportationNotificationPage> {
  final _scrollController = ScrollController();
  TransportationPostList? transportationPostList;
  late TransportationPostHandler transportationPostHandler;

  @override
  void initState() {
    super.initState();
    transportationPostHandler = TransportationPostHandler();
    transportationPostHandler.init().then((_) {
      if (mounted) {
        // Added mounted check
        transportationPostHandler
            .handlePostList(widget.customerOrDriver, true, true, widget.postID)
            .then((_) {
          if (mounted) {
            // Added mounted check
            setState(() {
              transportationPostList = transportationPostHandler
                  .getTransportationPostList(widget.customerOrDriver);
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransportationAppBar(
        customerOrDriver: widget.customerOrDriver,
      ),
      //drawer: MetuverseDrawer(),
      body: Column(
        children: [
          TransportationSubpageNavigation(
              customerOrDriver: widget.customerOrDriver),
          Expanded(
            child: DecoratedBox(
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
              child: transportationPostList != null
                  ? widget.customerOrDriver == 'c'
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: transportationPostList!.length(),
                          itemBuilder: (context, index) {
                            return TransportationCustomerContainer(
                              //post: newTransportationPostListX!.posts![index]);
                              post: transportationPostList!.posts![index],
                              onDeletePressedArgument: () {
                                if (mounted) {
                                  // Added mounted check
                                  setState(() {
                                    transportationPostList!.posts!
                                        .removeAt(index);
                                  });
                                }
                              },
                              onUpdateArgument: () {
                                if (mounted) {
                                  // Added mounted check
                                  setState(() {
                                    //rebuild widget
                                  });
                                }
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: transportationPostList!.length(),
                          itemBuilder: (context, index) {
                            return TransportationDriverContainer(
                              post: transportationPostList!.posts![index],
                              onDeletePressedArgument: () {
                                if (mounted) {
                                  // Added mounted check
                                  setState(() {
                                    transportationPostList!.posts!
                                        .removeAt(index);
                                  });
                                }
                              },
                              onUpdateArgument: () {
                                if (mounted) {
                                  // Added mounted check
                                  setState(() {
                                    //rebuild widget
                                  });
                                }
                              },
                            );
                          },
                        )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text("Loading..."),
                          /*SizedBox(height: 10),
                          ElevatedButton(
                            child: Text("Retry"),
                            onPressed: () => transportationPostHandler
                                .handlePostList(widget.customerOrDriver, true),
                          )*/
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GeneralBottomNavigation(
        pageIndex: 3,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(TransportationCreatePostPage());
        },
        shape: CircleBorder(),
        // set the shape to a circle
        backgroundColor: Colors.blue,
        // make the background transparent so that the border is visible
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 24.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
