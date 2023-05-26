import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class MenuItem {
  String name;
  double price;
  String category;
  bool availability;
  String description;
  String? imageBytes;
  MenuItem(
      {required this.name,
      required this.price,
      required this.category,
      required this.availability,
      required this.description,
      required this.imageBytes});
  // Results
  MenuItem.fromDatabase(ResultRow result)
      : name = result['name'],
        price = result['price'] as double,
        category = result['category'],
        availability = result['availability'] as int == 0 ? false : true,
        description = result['description'],
        imageBytes = result['image'].toString();

  static Image decodeImage(String imageBytes) {
    imageBytes = imageBytes.replaceAll(" ", "+");

    int mod4 = imageBytes.length % 4;
    while (mod4 != 0) {
      imageBytes += '_';
      mod4 = imageBytes.length % 4;
    }
    return Image.memory((Base64Decoder().convert(imageBytes)));
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$name , $price , $category , $availability , $description ';
  }
}
