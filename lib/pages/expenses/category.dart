import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List category = [
    {
      'name': 'Drink',
      'hex': '3277a8',
    },
    {
      'name': 'Bus',
      'hex': 'a83255',
    },
    {
      'name': 'Food',
      'hex': 'a83255',
    },
    {
      'name': 'Food',
      'hex': 'a83225',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Category"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: category.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: HexColor(category[i]['hex']),
              ),
              title: Text(category[i]['name']),
              onTap: () {
                Navigator.pop(context, category[i]);
              },
            );
          },
        ),
      ),
    );
  }
}
