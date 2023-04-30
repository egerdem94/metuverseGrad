  import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/profile/screens/OtherUserProfilePage.dart';
import 'package:metuverse/new_buy_sell/models/BuySellPost.dart';
import 'package:metuverse/widgets/buttons/whatsapp/view/WhatsappButton.dart';
import 'package:metuverse/widgets/photo_grids/FullScreenImageViewOffline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOffline.dart';

class BuyPostContainer extends StatelessWidget {
  final BuySellPost post;

  BuyPostContainer({required this.post});

  String currencySymbol = '';

  String? currencyConverter(String? currencyText) {
    if (currencyText == 'TL')
      currencySymbol = '₺';
    else if (currencyText == 'DOLLAR')
      currencySymbol = '\$';
    else if (currencyText == 'EURO')
      currencySymbol = '€';
    else if (currencyText == 'POUND') currencySymbol = '£';

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
                  backgroundImage: NetworkImage(
                      //"https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp"),
                      post.getProfilePicture()),
                  radius: 24.0,
                ),
              ),
              SizedBox(width: 8.0),
              Text(post.fullName ?? "", style: kUsersText),
              Spacer(),
              /*IconButton(
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigate to the sellers message box
                },
              )*/
              WhatsappButton(post: post),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description!, style: kwhiteText),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 260.0,
            child: PhotoGridOffline(
              photoList: post.photoList,
              onImageClicked: (index) {
                // Show fullscreen image view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullScreenImageViewOffline(
                      photo: post.photoList.photos[index],
                    ),
                  ),
                );
              },
            ),
/*            child: PhotoGridOffline(
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
            /*child: PhotoGrid(
              //imageUrls: imagesUrls, // pass the imageUrls here
              imageUrls: newPost.mediaList(),
              onImageClicked: (index) {
                // Show fullscreen image view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullscreenImageView(
                      imageUrl: newPost.mediaList()[index],
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
                    // Leave a comment
                  },
                  icon: Icon(Icons.comment_rounded),
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
                  post.productStatus! == 1 ? 'Looking' : 'Found',
                  style: TextStyle(
                    color:
                        post.productStatus! == 1 ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor:
                    post.productStatus! == 1 ? Colors.green : Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
