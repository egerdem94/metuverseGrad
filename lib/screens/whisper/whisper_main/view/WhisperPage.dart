import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/screens/whisper/whisper_create_edit_post/view/WhisperCreatePostPage.dart';
import 'package:metuverse/screens/whisper/whisper_main/controller/storage/WhisperPostHandler.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/widget/WhisperAppBar.dart';
import 'package:metuverse/screens/whisper/whisper_main/view/widget/WhisperPostContainer.dart';
import 'package:metuverse/widgets/GenrealUtil.dart';
import 'package:metuverse/widgets/LoadingIndicator.dart';
import 'package:metuverse/widgets/NothingToDisplay.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';
import 'package:metuverse/widgets/drawer.dart';


class WhisperPage extends StatefulWidget {

  final bool searchModeFlag;
  final searchKey;

  const WhisperPage({
    required this.searchModeFlag,
    Key? key,
    this.searchKey,
  }) : super(key: key);

  @override
  _WhisperPageState createState() => _WhisperPageState();
}

class _WhisperPageState extends State<WhisperPage> {
  final _scrollController = ScrollController();
  late WhisperPostHandler whisperPostHandler;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    whisperPostHandler = WhisperPostHandler();
    whisperPostHandler.init().then((_) {
      if (widget.searchModeFlag) {
        whisperPostHandler
            .handleSearchPosts(widget.searchKey)
            .then((_) {
          setState(() {});
        });
      } else {
        whisperPostHandler
            .handlePostList(true,false,0)
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

      if (!whisperPostHandler.ready) {
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
          whisperPostHandler
              .handlePostList(false,false,0)
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
      appBar: WhisperAppBar(),
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
                      child: !whisperPostHandler.whisperPostList.isEmpty()
                          ? buildPostListView()
                          : NothingToDisplay(),
                    ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 1,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(WhisperCreatePostPage()
          );
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

  /*ListView buildPostListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.buyOrSell == 's'
          ? whisperPostHandler.sellPostList.length()
          : whisperPostHandler.whisperPostList.length(),
      itemBuilder: (context, index) {
        return widget.buyOrSell == 's'
            ? SellPostContainer(
                post: whisperPostHandler.sellPostList.posts![index],
                onDeletePressedArgument: () {
                  setState(() {
                    whisperPostHandler.sellPostList.posts!.removeAt(index);
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
                post: whisperPostHandler.whisperPostList.posts![index],
                onDeletePressedArgument: () {
                  setState(() {
                    whisperPostHandler.whisperPostList.posts!.removeAt(index);
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
  }*/
  ListView buildPostListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: whisperPostHandler.whisperPostList.length(),
      itemBuilder: (context, index) {
        return WhisperPostContainer(
          post: whisperPostHandler.whisperPostList.posts![index],
          onDeletePressedArgument: () {
            setState(() {
              whisperPostHandler.whisperPostList.posts!.removeAt(index);
            });
          },
          onlineOrOfflineImage: widget.searchModeFlag ? 'online' : 'offline',
          onUpdateArgument: () {
            setState(() {});
        }, dbHelper: whisperPostHandler.dbHelper,
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
