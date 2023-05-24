import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_order_details.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

late List<Order> ordersList;

class _OrdersScreenState extends State<OrdersScreen> {
  void initState() {
    super.initState();
    var timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => Provider.of<OrderViewModel>(context, listen: false)
            .updateOrderList());
  }

  @override
  Widget build(BuildContext context) {
    ordersList = Provider.of<OrderViewModel>(context, listen: true)
        .ordersList
        .cast<Order>();

    return customScaffold(
        context: context,
        body: Scaffold(
            backgroundColor: CustomStyle.colorPalette.lightBackgorund,
            body: ListView.separated(
              itemCount: ordersList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Text(
                      "${ordersList[index].tableNum}",
                      style: TextStyle(
                          color: CustomStyle.colorPalette.green,
                          fontSize: CustomStyle.fontSizes.tableIDOrderMenue),
                    ),
                    trailing: CustomDropDownButton(order: ordersList[index]),
                    title: customButton(
                        childText: '#${ordersList[index].orderId}',
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.044,
                        color: CustomStyle.colorPalette.lightBackgorund,
                        shadowColor: CustomStyle.colorPalette.lightBackgorund,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    CustomStyle.colorPalette.lightBackgorund,
                                title: Text(
                                  'Order Details',
                                  style: TextStyle(
                                      color: CustomStyle.colorPalette.textColor,
                                      fontFamily: CustomStyle.fontFamily,
                                      fontSize: CustomStyle
                                          .fontSizes.orderDetailsFont,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: CustomOrderDetails(), //error here
                                actions: [
                                  customButton(
                                      width: MediaQuery.of(context).size.width *
                                          0.1898,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.0357,
                                      context: context,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      childText: "OK"),
                                ],
                              );
                            },
                          );

                          print(ordersList.length);
                        }));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: CustomStyle.colorPalette.textColor,
                  thickness: 2.0,
                );
              },
            )),
        title: "Orders");
  }
}
