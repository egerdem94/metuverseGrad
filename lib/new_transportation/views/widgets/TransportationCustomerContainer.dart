import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:metuverse/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/new_transportation/model/TransportationLocations.dart';
import 'package:metuverse/palette.dart';

class TransportationCustomerContainer extends StatelessWidget {
  final NewTransportationPost singlePostItem;

  final List<String> imagesUrls = [
    "https://boxesonline.co.za/images/jch-optimize/ng/images_stories_virtuemart_product__new_stock5-close.webp",
    'https://upload.wikimedia.org/wikipedia/commons/4/45/GuitareClassique5.png'
  ];
  TransportationCustomerContainer({required this.singlePostItem});

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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  singlePostItem.getProfilePicture()
                ),
                radius: 24.0,
              ),
              SizedBox(width: 8.0),
              Text(singlePostItem.fullName ?? "", style: kUsersText),
              Spacer(),
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
          Text(singlePostItem.description ?? "", style: kwhiteText),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            height: 130.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10.0),
                        Text(TransportationLocations.getLocation(singlePostItem.departureID!)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10.0),
                        Text(TransportationLocations.getLocation(singlePostItem.destinationID!)),
                      ],
                    ),
                  ),
                ),
              ],
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
                  icon: Icon(MdiIcons.carConnected),
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
                  singlePostItem.transportationStatus! == 1 ? 'Looking' : 'Found',
                  style: TextStyle(
                    color: singlePostItem.transportationStatus! == 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                backgroundColor: singlePostItem.transportationStatus! == 1
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
