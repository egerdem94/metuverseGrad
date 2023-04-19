import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/profile/screens/OtherUserProfilePage.dart';
import 'package:metuverse/widgets/buttons/whatsapp/view/WhatsappButton.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridGeneral.dart';
import 'package:metuverse/widgets/full_screen_imagePage.dart';
import 'package:metuverse/widgets/commentPage.dart';


class SellPostContainer extends StatelessWidget {
  final BuySellPost post;
  SellPostContainer({required this.post});

  String currencySymbol = '';

  String? currencyConverter(String? currencyText) {
    if (currencyText == 'TRY')
      currencySymbol = '₺';
    else if (currencyText == 'USD')
      currencySymbol = '\$';
    else if (currencyText == 'EUR')
      currencySymbol = '€';
    else if (currencyText == 'GBP') currencySymbol = '£';

    return currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 57, 57, 57), width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(OtherUserProfilePage(
                    userFullName: post.fullName,
                    profilePicture: post.getProfilePicture(),
                  ));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(post.getProfilePicture()),
                  radius: 24.0,
                ),
              ),
              SizedBox(width: 8.0),
              Text(post.fullName ?? "", style: kUsersText),
              Spacer(),
              Text(
                  '${post.productPrice ?? 0} ${currencyConverter(post.currency ?? "")}',
                  style: kwhiteText),
              SizedBox(width: 8.0),
              WhatsappButton(post: post),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 260.0,
            child: PhotoGridGeneral(
              photoList: post.photoList,
              imageUrls: post.getMediaList(),
              onImageClicked: (index) {
                // Show fullscreen image view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullscreenImageView(
                      imageUrl: post.getMediaList()[index],
                      //imageUrl: index % 2 == 0 ? imagesUrls[0] : imagesUrls[1],
                    ),
                  ),
                );
              },
            ),
            /*child: PhotoGridOffline(
              //imageUrls: imagesUrls, // pass the imageUrls here
              photoList: post.photoList,
              onImageClicked: (index) {
                // Show fullscreen image view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullscreenImageView(
                      imageUrl: post.mediaList()[index],
                      //imageUrl: index % 2 == 0 ? imagesUrls[0] : imagesUrls[1],
                    ),
                  ),
                );
              },
            ),*/
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              if (false)
                TextButton(
                  onPressed: () {
                    // Change description
                  },
                  child: Text(
                    'Change Description',
                    style: kwhiteText,
                  ),
                ),
              if (false)
                TextButton(
                  onPressed: () {
                    // Change price
                  },
                  child: Text(
                    'Change Price',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (false)
                TextButton(
                  onPressed: () {
                    // Update availability
                  },
                  child: Text(
                    'Update Availability',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (false)
                TextButton(
                  onPressed: () {
                    // Delete post
                  },
                  child: Text(
                    'Delete Post',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (false)
                TextButton(
                  onPressed: () {
// Leave a comment
                  },
                  child: Text(
                    'Comment',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (!false)
                IconButton(
                  onPressed: () {
// Add product to favorites
                  },
                  icon: Icon(Icons.add_circle_outline),
                  color: Colors.blue,
                ),
              IconButton(
                onPressed: () {
                  Get.to(CommentScreen());
                },
                icon: Icon(MdiIcons.comment),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  // Leave a comment
                },
                icon: Icon(Icons.send_rounded),
                color: Colors.blue,
              ),
              Spacer(),
              Chip(
                label: Text(
                  post.productStatus! == 1 ? 'Available' : 'Sold',
                  style: TextStyle(
                    color:
                        post.productStatus! == 1 ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor:
                    post.productStatus! == 1 ? Colors.green : Colors.red,
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Get.to(CommentScreen());
                },
                child: Text(
                  'Show all comments',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromARGB(255, 174, 174, 174)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
