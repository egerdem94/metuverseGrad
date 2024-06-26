import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/BuySellPage.dart';

class BuySellNavigationBar extends StatefulWidget {
  final buyOrSell;

  const BuySellNavigationBar({super.key, required this.buyOrSell});
  @override
  _BuySellNavigationBarState createState() =>
      _BuySellNavigationBarState();
}

class _BuySellNavigationBarState
    extends State<BuySellNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 79, 79, 79),
            width: 0.3,
          ),
        ),
      ),
      child: BottomAppBar(
        child: Row(
          children: [
/*            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(HomePage());
                // go back
              },
            ),*/
            Expanded(
              child: IconButton(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sell,
                      color: widget.buyOrSell == 's' ? Colors.white : Colors.white60,
                    ),
                    SizedBox(
                        width:
                            8), // to give some space between the icon and text
                    Text(
                      'SELL',
                      style: TextStyle(
                        color: widget.buyOrSell == 's' ? Colors.white : Colors.white60,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  //Get.to(NewBuySellPageX(buyOrSell: 's'));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuySellPage(
                                buyOrSell: 's',
                                searchModeFlag: false,
                              )));
                },
              ),
            ),
            /* Expanded(
              child: Container(
                height: 40.0, // set the height of the home icon
                child: Center(
                  child: Container(
                    height: 40.0, // set the size of the home icon
                    width: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(29, 161, 242, 1),
                      border: Border.all(
                        color: Color.fromRGBO(29, 161, 242, 1),
                        width: 2.0,
                      ),
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(BuySellCreatePostPage(
                          buyOrSell: widget.buyOrSell,
                        ));
                      },
                      shape: CircleBorder(), // set the shape to a circle
                      backgroundColor: Colors
                          .transparent, // make the background transparent so that the border is visible
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            Expanded(
              child: IconButton(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: widget.buyOrSell == 'b' ? Colors.white : Colors.white60,
                    ),
                    Text(
                      'BUY',
                      style: TextStyle(
                        color: widget.buyOrSell == 'b' ? Colors.white : Colors.white60,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  //Get.to(NewBuySellPageX(buyOrSell: 'b'));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BuySellPage(
                                buyOrSell: 'b',
                                searchModeFlag: false,
                              )));
                  // go back
                },
              ),
            ),

            /* SizedBox(
              width: 25,
            ),
            IconButton(
              icon: CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(
                  User.profilePicture,
                ),

                //backgroundImage: AssetImage(
                // 'assets-images/book.jpg'
                //),
              ),
              onPressed: () {
                Get.to(ProfilePage());
              },
            ),*/
          ],
        ),
        color: Color.fromARGB(255, 0, 0, 0),
        shape: CircularNotchedRectangle(),
        // add a notch to accommodate the home icon
      ),
    );
  }
}
