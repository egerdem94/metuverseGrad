import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/sport/sport_main/controller/SportPostHandler.dart';
import 'package:metuverse/screens/sport/sport_main/view/widget/SportAppBar.dart';
import 'package:metuverse/screens/sport/sport_main/view/widget/SportPostContainer.dart';
import 'package:metuverse/widgets/LoadingIndicator.dart';
import 'package:metuverse/widgets/NothingToDisplay.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';

import '../../create_edit_post/view/SportCreatePostPage.dart';

class SportPage extends StatefulWidget {
  final searchModeFlag;
  final notificationMode;
  final notificationPostID;
  final selectedSportID;
  final searchKey;

  const SportPage({
    required this.searchModeFlag,
    Key? key,
    this.searchKey,
    required this.notificationMode,
    this.notificationPostID,
    this.selectedSportID,
  }) : super(key: key);

  @override
  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  final _scrollController = ScrollController();
  late SportPostHandler sportPostHandler;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    sportPostHandler = SportPostHandler();
    sportPostHandler.init().then((_) {
      if (mounted) { // Added mounted check
        if (widget.searchModeFlag != null && widget.searchModeFlag) {
          sportPostHandler.handleSearchPosts(widget.searchKey, widget.selectedSportID).then((_) {
            if (mounted) { // Added mounted check
              setState(() {});
            }
          });
        } else {
          sportPostHandler
              .handlePostList(
              true, widget.notificationMode, widget.notificationPostID)
              .then((_) {
            if (mounted) { // Added mounted check
              setState(() {});
            }
          });
        }
        if (widget.searchModeFlag) {
          Future.delayed(Duration(milliseconds: 1000), () {
            if (mounted) { // Added mounted check
              setState(() {
                _isLoading = false;
              });
            }
          });
        } else {
          _startDelayedFuture();
        }
      }
    });
  }

  void _startDelayedFuture() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (!mounted) return; // Check if the widget is still mounted

      if (!sportPostHandler.ready) {
        _startDelayedFuture(); // Call the method again to continue checking
      } else {
        if (mounted) { // Added mounted check
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  void _scrollListener() {
    if (!widget.searchModeFlag) {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // Load more data
        if (mounted) { // Added mounted check
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SportAppBar(),
      body: DecoratedBox(
        decoration: metuverseBoxDecoration(),
        child: _isLoading
            ? LoadingIndicator()
            : RefreshIndicator(
          onRefresh: _handleRefresh,
          child: !sportPostHandler.sportPostList.isEmpty()
              ? buildPostListView()
              : NothingToDisplay(),
        ),
      ),
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(SportCreatePostPage());
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
      itemCount: sportPostHandler.sportPostList.length(),
      itemBuilder: (context, index) {
        return SportPostContainer(
          post: sportPostHandler.sportPostList.posts![index],
          onDeletePressedArgument: () {
            if (mounted) { // Added mounted check
              setState(() {
                sportPostHandler.sportPostList.posts!.removeAt(index);
              });
            }
          },
          dbHelper: sportPostHandler.dbHelper,
          onUpdateArgument:(){
            if (mounted) { // Added mounted check
              setState(() {});
            }
          },
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    Future.delayed(Duration(seconds: 3)).then((_) {
      if(mounted){ // Added mounted check
        setState(() {});
      }
    });
  }
}
