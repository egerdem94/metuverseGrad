import 'package:flutter/material.dart';
import 'package:metuverse/buttons/friends/model/FriendList.dart';
import 'package:metuverse/buttons/whatsapp/view/WhatsappButton2.dart';
import 'package:metuverse/buttons/whatsapp/view/WhatsappButton3.dart';
import 'package:metuverse/screens/profile/controller/ProfileController.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';
import 'package:metuverse/widgets/LoadingIndicator.dart';

class OtherUserProfilePage extends StatefulWidget {
  const OtherUserProfilePage({
    Key? key,
    required this.publicToken,
  }) : super(key: key);

  final String publicToken;

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  ProfileController profileController = ProfileController();
  @override
  void initState() {
    super.initState();
    profileController.getProfileInfo(widget.publicToken).then((_) {
      if (mounted) { // Added mounted check
        setState(() {});
      }
    });
  }
  static double avatarMaximumRadius = 80.0;
  static double avatarMinimumRadius = 60.0;
  double avatarRadius = avatarMaximumRadius;
  double expandedHeader = 130.0;
  double translate = -avatarMaximumRadius;
  bool isExpanded = true;
  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return profileController.otherUserProfileModel == null
        ? LoadingIndicator() // Display loading indicator when reports are null
        : SafeArea(
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
                  title: Text(
                    "Metuverse",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
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
                                image:AssetImage("assets-images/background.jpeg")
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
                                profilePicture: profileController.otherUserProfileModel!.profilePicture!,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: IconButton(
                                icon: Icon(
                                  profileController.otherUserProfileModel!.isFriend! ? Icons.person : Icons.person_add,
                                  color: profileController.otherUserProfileModel!.isFriend! ? Colors.green : Colors.white,
                                ),
                                onPressed:  () {
                                  if(!profileController.otherUserProfileModel!.isFriend!) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Send Request'),
                                            content: Text(
                                                'Do you want to send a request to ${profileController.otherUserProfileModel!.fullName}?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  bool isSuccessful = await profileController.addFriend(widget.publicToken);
                                                  if(isSuccessful){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("You sent the friend request successfully."),
                                                    ));
                                                  }
                                                  else{
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("You have already sent a friend request."),
                                                    ));
                                                  }
                                                  Navigator.of(context).pop(); // Close the dialog after the action
                                                },
                                                child: Text('Send Request'),
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  }
                                  else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Remove Friend'),
                                            content: Text(
                                                'Do you want remove ${profileController.otherUserProfileModel!.fullName} from your friend list?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  bool isSuccessful = await profileController.removeFriend(widget.publicToken);
                                                  if(isSuccessful){
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("You removed friend successfully."),
                                                    ));
                                                    profileController.otherUserProfileModel!.isFriend =false;
                                                    setState(() {});
                                                  }
                                                  else{
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("Error occured romoving friend"),
                                                    ));
                                                  }
                                                  Navigator.of(context).pop(); // Close the dialog after the action
                                                },
                                                child: Text('Remove'),
                                              ),
                                            ],
                                          );
                                        }
                                    );
                                  }
                                },
                              ),
                            ),
                            isExpanded
                                ? SizedBox(
                              height: avatarMinimumRadius * 2,
                            )
                                : MyAvatar(
                              size: avatarMinimumRadius,
                              profilePicture: profileController.otherUserProfileModel!.profilePicture!,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: WhatsappButton3(phoneNumber: profileController.otherUserProfileModel!.phoneNumber ?? "", isFriend: profileController.otherUserProfileModel!.isFriend!,),
                            ),
                          ],
                        ),
                        ProfileHeader(userFullName: profileController.otherUserProfileModel!.fullName!,),
                      ],
                    ),
                  ),
                ),
                /*SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileTabs(50.0),
                ),*/
                /*SliverList( TODO
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return PostContainer();
                    },
                  ),
                ),*/
              ],
            ),
          ),
        ),
        bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,),
      ),
    );
  }
}
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
          Center(
            child: Text(
              userFullName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
/*          SizedBox(
            height: 5.0,
          ),
          SizedBox(
            height: 10.0,
          ),*/
        ],
      ),
    );
  }
}

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
