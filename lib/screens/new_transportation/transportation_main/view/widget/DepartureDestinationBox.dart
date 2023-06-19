import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/NewTransportationPost.dart';
import 'package:metuverse/screens/new_transportation/transportation_main/model/TransportationLocations.dart';

class DepartureDestinationBox extends StatelessWidget {
  const DepartureDestinationBox({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(location),
          ],
        ),
      ),
    );
  }
}
class DepartureDestinationBoxes extends StatelessWidget {
  const DepartureDestinationBoxes({
    super.key,
    required this.post,
  });

  final TransportationPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130.0,
      child: Column(
        children: <Widget>[
          DepartureDestinationBox(location: TransportationLocations.getLocation(post.departureID!)),
          SizedBox(height: 10.0),
          DepartureDestinationBox(location: TransportationLocations.getLocation(post.destinationID!)),
        ],
      ),
    );
  }
}