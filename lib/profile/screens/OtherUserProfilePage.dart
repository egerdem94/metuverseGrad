import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buyandsell/models/SellPostList.dart';
import '../../buyandsell/widgets/BuyPostContainer.dart';
import '../../util/user.dart';
import '../../widgets/bottom_navigation_bar.dart';
import '../../widgets/search.dart/search.dart';
import 'package:http/http.dart' as http;

class OtherUserProfilePage extends StatefulWidget {

  const OtherUserProfilePage({
    Key? key,
    required this.userFullName,
    required this.profilePicture,
  }) : super(key: key);

  final String? userFullName;
  final String? profilePicture;

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  static double avatarMaximumRadius = 40.0;
  static double avatarMinimumRadius = 15.0;
  double avatarRadius = avatarMaximumRadius;
  double expandedHeader = 130.0;
  double translate = -avatarMaximumRadius;
  bool isExpanded = true;
  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (scrollNotification) {
            final pixels = scrollNotification.metrics.pixels;

            // check if scroll is vertical ( left to right OR right to left)
            final scrollTabs = (scrollNotification.metrics.axisDirection ==
                AxisDirection.right ||
                scrollNotification.metrics.axisDirection == AxisDirection.left);

            if (!scrollTabs) {
              // and here prevents animation of avatar when you scroll tabs
              if (expandedHeader - pixels <= kToolbarHeight) {
                if (isExpanded) {
                  translate = 0.0;
                  setState(() {
                    isExpanded = false;
                  });
                }
              } else {
                translate = -avatarMaximumRadius + pixels;
                if (translate > 0) {
                  translate = 0.0;
                }
                if (!isExpanded) {
                  setState(() {
                    isExpanded = true;
                  });
                }
              }

              offset = pixels * 0.4;

              final newSize = (avatarMaximumRadius - offset);

              setState(() {
                if (newSize < avatarMinimumRadius) {
                  avatarRadius = avatarMinimumRadius;
                } else if (newSize > avatarMaximumRadius) {
                  avatarRadius = avatarMaximumRadius;
                } else {
                  avatarRadius = newSize;
                }
              });
            }
            return false;
          },
          child: DefaultTabController(
            length: 8,
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: expandedHeader,
                  backgroundColor: Colors.grey,
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  ),
                  title: Text(
                    "Metuverse",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search_rounded),
                      onPressed: () {
                        Get.to(SearchPage());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        // handle notification button press
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.mail),
                      onPressed: () {
                        // handle direct message button press
                      },
                    ),
                  ],
                  pinned: true,
                  elevation: 5.0,
                  forceElevated: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        color: isExpanded
                            ? Colors.transparent
                            : Color.fromARGB(255, 0, 0, 0),
                        image: isExpanded
                            ? DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                          image: NetworkImage(
                              'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        )
                            : null),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: isExpanded
                          ? Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, avatarMaximumRadius),
                        child: MyAvatar(
                          size: avatarRadius,
                          profilePicture: widget.profilePicture!,
                        ),
                      )
                          : SizedBox.shrink(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            isExpanded
                                ? SizedBox(
                              height: avatarMinimumRadius * 2,
                            )
                                : MyAvatar(
                              size: avatarMinimumRadius,
                              profilePicture: widget.profilePicture!,
                            ),
                          ],
                        ),
                        ProfileHeader(userFullName: widget.userFullName!),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileTabs(50.0),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return PostContainer();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

////////AŞAĞIDA KAYDIRILAN LİSTE ŞEYLERİ
class ProfileTabs extends SliverPersistentHeaderDelegate {
  final double size;

  ProfileTabs(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0),
      height: size,
      child: TabBar(
        isScrollable: true,
        tabs: <Widget>[
          Tab(
            text: "Social",
          ),
          Tab(
            text: "Buy and Sell",
          ),
          Tab(
            text: "Transportation",
          ),
          Tab(
            text: "Likes",
          ),
          Tab(
            text: "Favorites",
          ),
          Tab(
            text: "Lectures",
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(ProfileTabs oldDelegate) {
    return oldDelegate.size != size;
  }
}

/////AD FALAN
class ProfileHeader extends StatelessWidget {

  const ProfileHeader({
    Key? key,
    required this.userFullName,
  }) : super(key: key);

  final String userFullName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            userFullName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          /*Text(
            "Department maybe ?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          )*/
        ],
      ),
    );
  }
}

////////////////BURALARA HER BİR POST LİSTESİ YAZILCAK
class PostContainer extends StatefulWidget {
  const PostContainer({
    Key? key,
  }) : super(key: key);

  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  //late List<Product> products;
  BuySellPostList? buyandsellPostsListObject;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: buyandsellPostsListObject?.total,
        itemBuilder: (context, index) {
          return BuyPostContainer(
              post: buyandsellPostsListObject!.items![index]);
        },
      ),
    );
  }
}

////////////PROFİL FOTOSU BURDA
class MyAvatar extends StatelessWidget {
  final double? size;
  final String profilePicture;

  const MyAvatar({
    Key? key,

    this.size,
    required this.profilePicture,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[800]!,
              width: 2.0,
            ),
            shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: size,
            backgroundImage: NetworkImage(
              profilePicture,
            ),
          ),
        ),
      ),
    );
  }
}
