import 'package:flutter/material.dart';

class PriceInputBox extends StatelessWidget {
  const PriceInputBox({
    super.key,
    required this.priceController,
  });

  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top: 16.0),
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: TextFormField(
        controller: priceController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a price';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Price',
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 8.0),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}