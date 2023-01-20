import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:metuverse/palette.dart';
import '../../auth/screens/login-page.dart';
import '../../profile/screens/OtherUserProfilePage.dart';
import '../../widgets/full_screen_imagePage.dart';
import '../../widgets/photoGrid.dart';
import '../models/SellPostList.dart';
import '../models/ZDeprecatedProduct.dart';

class ProductContainer extends StatelessWidget {
  final Post post;

  /*final List<String> imagesUrls = [
    "https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp",
    'https://upload.wikimedia.org/wikipedia/commons/4/45/GuitareClassique5.png'
  ];*/

  ProductContainer({required this.post});

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
              Get.to(OtherUserProfilePage(userFullName: post.fullName, profilePicture: post.getProfilePicture(),));
            },
            child:
              CircleAvatar(

                backgroundImage: NetworkImage(
                    post.getProfilePicture()),
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
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigate to the sellers message box
                },
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(post.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 260.0,
            child: PhotoGrid(
              //imageUrls: imagesUrls, // pass the imageUrls here
              imageUrls: post.mediaList(),
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
            ),
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
                  post.productStatus! == 1 ? 'Available' : 'Sold',
                  style: TextStyle(
                    color: post.productStatus! == 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                backgroundColor: post.productStatus! == 1
                    ? Colors.green
                    : Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
