import 'package:flutter/material.dart';

class MultidimensionalArrayPage extends StatefulWidget {
  @override
  _MultidimensionalArrayPageState createState() =>
      _MultidimensionalArrayPageState();
}

class _MultidimensionalArrayPageState extends State<MultidimensionalArrayPage> {
  late List<List<int>> multidimensionalArray;

  @override
  void initState() {
    super.initState();
    multidimensionalArray = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multidimensional Array'),
      ),
      body: ListView.builder(
        itemCount: multidimensionalArray.length,
        itemBuilder: (context, index) {
          Color? rowColor = index % 2 == 0 ? Colors.grey[300] : Colors.white;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: rowColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Subarray ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              for (int value in multidimensionalArray[index])
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: rowColor,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            value.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            multidimensionalArray.add([10, 11, 12]);
          });
        },
      ),
    );
  }
}
