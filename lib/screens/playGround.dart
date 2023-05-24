import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';

import 'package:mat3ami/style/style.dart';

class PlayGround extends StatefulWidget {
  PlayGround({super.key});

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyle.colorPalette.darkBackground,
      appBar: AppBar(
        title: Text('Combo Box Example'),
      ),
      body: Center(
        child: CustomDropDownButton(
          order: Order(
              orderStatus: 'Placed',
              comments: '',
              dateTime: DateTime.now(),
              menuItemsNamesAndCounts: {},
              orderId: 1,
              tableNum: 2),
        ),
      ),
    );
  }
}
