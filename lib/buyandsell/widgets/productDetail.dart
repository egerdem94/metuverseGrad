import 'package:flutter/material.dart';

import '../models/ZDeprecatedProduct.dart';

class ProductDetail extends StatelessWidget {
  final DeprecatedProduct product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(product.imageUrl[0]),

            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text(product.price.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(product.sellerName),
                  ),
                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text(product.description),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
