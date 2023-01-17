import 'package:flutter/material.dart';

import '../models/product.dart';

class MyFavorites extends StatelessWidget {
  final List<Product> favorites;

  MyFavorites({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(favorites[index].imageUrl[0]),
          title: Text(favorites[index].name),
          subtitle: Text(favorites[index].price.toString()),
        );
      },
    );
  }
}
