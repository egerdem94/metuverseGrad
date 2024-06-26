import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/screens/home/screens/HomePage.dart';
import 'package:metuverse/user/User.dart';
import 'package:metuverse/widgets/GeneralBottomNavigation.dart';

import '../../auth_screens/login/view/LoginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static double avatarMaximumRadius = 80.0;
  static double avatarMinimumRadius = 60.0;
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
                  scrollNotification.metrics.axisDirection ==
                      AxisDirection.left);

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
            child: ProfileTabController(expandedHeader: expandedHeader, isExpanded: isExpanded, avatarMaximumRadius: avatarMaximumRadius, avatarRadius: avatarRadius, avatarMinimumRadius: avatarMinimumRadius),
          ),
          bottomNavigationBar: GeneralBottomNavigation(pageIndex: 0,)),
    );
  }
}

class ProfileTabController extends StatelessWidget {
  const ProfileTabController({
    super.key,
    required this.expandedHeader,
    required this.isExpanded,
    required this.avatarMaximumRadius,
    required this.avatarRadius,
    required this.avatarMinimumRadius,
  });

  final double expandedHeader;
  final bool isExpanded;
  final double avatarMaximumRadius;
  final double avatarRadius;
  final double avatarMinimumRadius;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                  icon: Icon(
                    MdiIcons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    User.logout();
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                      return LoginPage();
                    }), (r) {
                      return false;
                    });
                  },
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
                            ),
                      /*Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // handle button press
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 6.0),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "Favorite Posts",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )*/
                    ],
                  ),
                  ProfileHeader(),
                ],
              ),
            ),
          ),
          /*SliverPersistentHeader(
            pinned: true,
            delegate: ProfileTabs(50.0),
          ),*/
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                //return Post();
              },
            ),
          ),
        ],
      ),
    );
  }
}

////////AŞAĞIDA KAYDIRILAN LİSTE ŞEYLERİ
/*class ProfileTabs extends SliverPersistentHeaderDelegate {
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
            text: "Whisper",
          ),
          Tab(
            text: "Buy and Sell",
          ),
          Tab(
            text: "Transportation",
          ),
          Tab(
            text: "Sport",
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
}*/

/////AD FALAN
class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
            User.fullName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
           )
          ),

        ],
      ),
    );
  }
}
////////////PROFİL FOTOSU BURDA
class MyAvatar extends StatefulWidget {
  final double? size;
  const MyAvatar({Key? key, required this.size}) : super(key: key);

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}

class _MyAvatarState extends State<MyAvatar> {
  XFile? pickedImage;
  File? file;
  List<File?> fileList = [];

  final picker = ImagePicker();
  var generalResponseCreatePost;

  Future _user_profilePicture_edit() async {
    var uri = "http://www.birikikoli.com/mv_services/userPictureEdit.php";

    var request = http.MultipartRequest('POST', Uri.parse(uri));

    if (pickedImage != null) {
      var pic = await http.MultipartFile.fromPath("image", pickedImage!.path);

      request.files.add(pic);
    }

    request.fields['token'] = User.privateToken;

    await request.send().then((result) {
      http.Response.fromStream(result).then((response) {
        var message = jsonDecode(response.body);
        //isResponseReceived = true;
        generalResponseCreatePost = message;

        // show snackbar if input data successfully
        final snackBar =
            SnackBar(content: Text(generalResponseCreatePost['message']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        developer.log(
            "JSON: Status: " +
                generalResponseCreatePost['processStatus'].toString() +
                " Message: " +
                generalResponseCreatePost['message'] +
                "ProfilePicture: " +
                generalResponseCreatePost['profilePicture'],
            name: 'my.app.category');

        if (generalResponseCreatePost['processStatus'] == true) {
          //token = loginObject?.currentUserToken;
          User.profilePicture = generalResponseCreatePost['profilePicture'];
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          //isButtonClicked = false;
          //isResponseReceived = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Update failed."),
          ));
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future pickImageFromGallery() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(pickedImage!.path);
      fileList.add(file);
    });
    _user_profilePicture_edit();
  }

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
          child: GestureDetector(
            onTap: () {
              pickImageFromGallery();
            },
            child: CircleAvatar(
              radius: widget.size,
              backgroundImage: NetworkImage(
                User.profilePicture,
              ),
            ),
          ),
        ),
      ),
    );
  }
}