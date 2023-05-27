import 'package:flutter/material.dart';
import 'package:metuverse/screens/home/widgets/MainPageNavigationBar.dart';
import 'package:metuverse/screens/new_buy_sell/buy_sell_main/view/widget/BuyAndSellAppBar.dart';
import 'package:metuverse/whispers/widgets/whispersContainer.dart';
import 'package:metuverse/widgets/drawer.dart';
import '../models/whispersPostList.dart';

class WhispersPage extends StatefulWidget {
  const WhispersPage({
    Key? key,
  }) : super(key: key);

  @override
  _WhispersPageState createState() => _WhispersPageState();
}

class _WhispersPageState extends State<WhispersPage> {
  List<Post> dummyPosts = [
    Post(
      belongToUser: true,
      fullName: "Yavuz Erbaş",
      profilePicture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s",
      postID: 1,
      media:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s",
      description: "........",
    ),
    Post(
      belongToUser: false,
      fullName: "Ege Erdem",
      profilePicture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s",
      postID: 2,
      media:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s',
      description: "........",
    ),
    Post(
      belongToUser: false,
      fullName: "Burak Eken ",
      profilePicture:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s",
      postID: 3,
      media: null,
      description:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1FLBNvZKJ24svAiFaG7xGi3S1TaTog0QMj8L4WmkJog&s",
    )
  ];

  @override
  void initState() {
    super.initState();
    _loadDummyProducts();
  }

  void _loadDummyProducts() {
    setState(() {
      whispersPostListObject =
          WhispersPostList(items: dummyPosts, total: dummyPosts.length);
    });
  }

  //late List<Product> products;
  WhispersPostList? whispersPostListObject;

  /*Future _buyandsell_posts_searchandfilter() async {
    String serviceAddress =
        //'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter.php';
        'http://www.birikikoli.com/mv_services/buyandsell_posts_searchandfilter_deneme.php';
    Uri serviceUri = Uri.parse(serviceAddress);
    //print("yavuz_token: " + User.token);
    final response = await http.post(serviceUri, body: {
      //"token": "hL3JEZxp85hR0JDTP4B85Msy8e4v5X5nJ87n8FNh",
      "token": User.token,
      "buyerOrSeller": "s", //seller
      "searchKey": widget.searchKey,
      "filteredProductPrice": widget.filteredProductPrice,
      "filteredCurrency": widget.filteredCurrency,
    });

    String stringData = response.body;
    Map<String, dynamic> jsonObject = jsonDecode(stringData);

    setState(() {
      whispersPostsListObject = whispersPostList.fromJson(jsonObject);
    });
  }

  @override
  void initState() {
    super.initState();
    //_loadProducts();
    //products = dummyProducts;
    _buyandsell_posts_searchandfilter();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewBuyAndSellAppBar(buyOrSell: 's',), //dummy
      drawer: MetuverseDrawer(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ), // set the background color to blue
        ),
        child: ListView.builder(
          itemCount: whispersPostListObject?.total,
          itemBuilder: (context, index) {
            return WhispersContainer(
                post: whispersPostListObject!.items![index]);
          },
        ),
      ),
      bottomNavigationBar: MainPageNavigationBar(),
    );
  }
}
