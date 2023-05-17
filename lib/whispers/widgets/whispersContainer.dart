import 'package:flutter/material.dart';
import 'package:metuverse/palette.dart';
import 'package:metuverse/whispers/models/whispersPostList.dart';
import 'package:metuverse/widgets/photo_grids/FullScreenImageViewOnline.dart';
import 'package:metuverse/widgets/photo_grids/PhotoGridOnline.dart';


class WhispersContainer extends StatelessWidget {
  final Post post;

  WhispersContainer({required this.post});

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
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s"),
                radius: 24.0,
              ),
              SizedBox(width: 8.0),
              Text(post.fullName ?? "", style: kUsersText),
              Spacer(),
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
            child: PhotoGridOnline(
              //imageUrls: imagesUrls, // pass the imageUrls here
              imageUrls: post.mediaList(),
              onImageClicked: (index) {
                // Show fullscreen image view
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullScreenImageViewOnline(
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
            ],
          )
        ],
      ),
    );
  }
}
