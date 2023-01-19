import 'package:flutter/material.dart';

import '../models/ZDeprecatedProduct.dart';

class ProductList extends StatelessWidget {
  final List<DeprecatedProduct> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(products[index].imageUrl[0]),
          title: Text(products[index].name),
          subtitle: Text(products[index].price.toString()),
        );
      },
    );
  }
}
