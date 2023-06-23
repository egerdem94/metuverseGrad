import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metuverse/buttons/friends/view/FriendListTab.dart';
import 'package:metuverse/buttons/friends/view/IncomingMessageRequestsTab.dart';
import 'package:metuverse/buttons/friends/view/OutgoingMessageRequestsTab.dart';
import 'package:metuverse/buttons/notification/view/NotificationButton.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';
import 'package:metuverse/widgets/search.dart/search.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: NotificationButton(),
        title: Text(
          "Friends",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        centerTitle: true,
        actions: [
          IconButton( // New Search Button
            icon: Icon(Icons.search),
            onPressed: () {
              Get.to(SearchPersonPage());
            },
          ),
          NotificationButton(),
        ],

        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Friends"),
            Tab(text: "Incoming"),
            Tab(text: "Outgoing"),
          ],
        ),
      ),
      //drawer: MetuverseDrawer(),
      body: Container(
        color: Colors.black,
        child: TabBarView(
          controller: _tabController,
          children: [
            FriendListTab(),
            IncomingMessageRequestsTab(),
            OutgoingMessageRequestsTab(),
          ],
        ),
      ),

      bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,),
    );
  }
}
