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
        managerSsn = result['managerSsn'],
        price = result['price'],
        category = result['category'],
        availability = result['availability'],
        description = result['description'],
        image = result['image'];
}
