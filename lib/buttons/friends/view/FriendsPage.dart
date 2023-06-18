import 'package:flutter/material.dart';
import 'package:metuverse/buttons/friends/view/FriendListTab.dart';
import 'package:metuverse/buttons/friends/view/IncomingMessageRequestsTab.dart';
import 'package:metuverse/buttons/friends/view/OutgoingMessageRequestsTab.dart';
import 'package:metuverse/widgets/drawer.dart';

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
        title: Text("Friends"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text:"Friends"),
            Tab(text: "Incoming"),
            Tab(text: "Outgoing"),
          ],
        ),
      ),
      //drawer: MetuverseDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          FriendListTab(),
          IncomingMessageRequestsTab(),
          OutgoingMessageRequestsTab(),
        ],
      ),
    );
  }
}

