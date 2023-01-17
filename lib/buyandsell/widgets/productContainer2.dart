import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import '../../widgets/full_screen_imagePage.dart';
import '../../widgets/photoGrid.dart';
import '../models/product.dart';

class ProductContainer extends StatelessWidget {
  final Product product;
  final bool isSeller;

  ProductContainer({required this.product, required this.isSeller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(product.imageUrl[0]),
                radius: 24.0,
              ),
              SizedBox(width: 8.0),
              Text(product.sellerName, style: kUsersText),
              Spacer(),
              Text('\₺${product.price}', style: kwhiteText),
              SizedBox(width: 8.0),
              Chip(
                label: Text(
                  product.isAvailable ? 'Available' : 'Sold',
                  style: TextStyle(
                    color: product.isAvailable ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor:
                product.isAvailable ? Colors.green : Colors.red,
              ),
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
          Text(product.description, style: kwhiteText),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 260.0,
            child: PhotoGrid(
              imageUrls: product.imageUrl, // pass the imageUrls here
              onImageClicked: (index) {
                // Show fullscreen image view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullscreenImageView(
                      imageUrl: product.imageUrl[index],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              if (isSeller)
                TextButton(
                  onPressed: () {
                    // Change description
                  },
                  child: Text(
                    'Change Description',
                    style: kwhiteText,
                  ),
                ),
              if (isSeller)
                TextButton(
                  onPressed: () {
                    // Change price
                  },
                  child: Text(
                    'Change Price',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (isSeller)
                TextButton(
                  onPressed: () {
                    // Update availability
                  },
                  child: Text(
                    'Update Availability',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (isSeller)
                TextButton(
                  onPressed: () {
                    // Delete post
                  },
                  child: Text(
                    'Delete Post',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (isSeller)
                TextButton(
                  onPressed: () {
// Leave a comment
                  },
                  child: Text(
                    'Comment',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              if (!isSeller)
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
            ],
          )
        ],
      ),
    );
  }
}
