/*import 'package:flutter/material.dart';

class BuySellPostWidget extends StatelessWidget {
  final String profilePictureUrl;
  final String profileName;
  final String description;
  final String photoUrl;
  final double productPrice;
  final bool isSold;

  const BuySellPostWidget({
    required Key key,
    required this.profilePictureUrl,
    required this.profileName,
    required this.description,
    required this.photoUrl,
    required this.productPrice,
    required this.isSold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print('Constraints: $constraints');
        return Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(profilePictureUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (photoUrl != null)
                GestureDetector(
                  onTap: () {
                    // Show the full-screen photo viewer
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenPhotoViewer(photoUrl: photoUrl),
                      ),
                    );
                  },
                  child: Container(
                    width: constraints.maxWidth,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Price: \$$productPrice',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  if (isSold)
                    Text(
                      'SOLD',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      // Show the comments
                    },
                    child: Text('Comments'),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      // Add to favorites
                    },
                    child: Text('Add to Favorites'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class FullScreenPhotoViewer extends StatelessWidget {
  final String photoUrl;

  const FullScreenPhotoViewer({required this.photoUrl}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(photoUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
*/