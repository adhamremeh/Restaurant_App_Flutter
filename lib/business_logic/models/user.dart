import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class User {
  String ssn;
  String managerSsn;
  String fName;
  String lName;
  String phoneNumber1;
  String phoneNumber2;
  double salary;
  String employeeRole;
  String password;

  User(
      {required this.ssn,
      required this.managerSsn,
      required this.fName,
      required this.lName,
      required this.employeeRole,
      required this.password,
      required this.phoneNumber1,
      required this.phoneNumber2,
      required this.salary});
  User.fromDatabase(ResultRow result)
      : ssn = result['ssn'],
        managerSsn = result['managerSsn'],
        fName = result['fName'],
        lName = result['lName'],
        employeeRole = result['employeeRole'],
        password = result['password'],
        phoneNumber1 = result['phoneNumber1'],
        phoneNumber2 = result['phoneNumber2'],
        salary = result['salary'];
}

class MenueItem {
  String name;
  int managerSsn;
  double price;
  String category;
  bool availability;
  String description;
  Image image;
  MenueItem(
      {required this.name,
      required this.managerSsn,
      required this.price,
      required this.category,
      required this.availability,
      required this.description,
      required this.image});
  MenueItem.fromDatabase(ResultRow result)
      : name = result['name'],
        managerSsn = result['managerSsn'],
        price = result['price'],
        category = result['category'],
        availability = result['availability'],
        description = result['description'],
        image = result['image'];
}

class Order {
  int orderId;
  String orderStatus;
  String dateTime;
  int ammount;
  String comment;
  Order(
      {required this.orderId,
      required this.ammount,
      required this.comment,
      required this.dateTime,
      required this.orderStatus});
  Order.fromDatabase(ResultRow result)
      : orderId = result['orderId'],
        ammount = result['ammount'],
        comment = result['comment'],
        dateTime = result['dateTime'],
        orderStatus = result['orderStatus'];
}
