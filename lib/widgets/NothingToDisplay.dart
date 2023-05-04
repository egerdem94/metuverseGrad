import 'package:flutter/material.dart';

class NothingToDisplay extends StatelessWidget {
  const NothingToDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //CircularProgressIndicator(),
          SizedBox(height: 10),
          Text(
            "Nothing to display",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          /* ElevatedButton(
              child: Text("Retry"),
              onPressed: () => buySellPostHandler.handlePostList(
                  widget.buyOrSell, true),
            )*/
        ],
      ),
    );
  }
}