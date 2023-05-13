import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MenuItem {
  String name;
  int managerSsn;
  double price;
  String category;
  bool availability;
  String description;
  Image image;
  MenuItem(
      {required this.name,
      required this.managerSsn,
      required this.price,
      required this.category,
      required this.availability,
      required this.description,
      required this.image});
  // Results
  MenuItem.fromDatabase(ResultRow result)
      : name = result['name'],
        managerSsn = result['managerSsn'] as int,
        price = result['price'] as double,
        category = result['category'],
        availability = result['availability'] as int == 0 ? false : true,
        description = result['description'],
        image = Image.memory(Uint8List.fromList(result['image'].toBytes()));

  @override
  String toString() {
    // TODO: implement toString
    return '$name , $managerSsn , $price , $category , $availability , $description , $image';
  }
}
