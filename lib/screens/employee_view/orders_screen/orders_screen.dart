import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/screens/Manger_View/Orders_History/Orders_History.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

late List<Order> orderList;

class _OrdersScreenState extends State<OrdersScreen> {
  var timer;
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 5),
        (Timer t) => Provider.of<OrderViewModel>(context, listen: false)
            .updateOrderList());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderList = Provider.of<OrderViewModel>(context, listen: true)
        .ordersList
        .cast<Order>()
        .where((element) =>
            element.orderStatus.toLowerCase() != 'completed' &&
            element.orderStatus.toLowerCase() != 'cancelled')
        .toList();

    return customScaffold(
        back: false,
        context: context,
        body: Scaffold(
            backgroundColor: CustomStyle.colorPalette.lightBackgorund,
            body: ListView.separated(
              itemCount: orderList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Text(
                      "${orderList[index].tableNum}",
                      style: TextStyle(
                          color: CustomStyle.colorPalette.green,
                          fontSize: CustomStyle.fontSizes.tableIDOrderMenue),
                    ),
                    trailing: CustomDropDownButton(order: orderList[index]),
                    title: customButton(
                        childText: '#${orderList[index].orderId}',
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.044,
                        color: CustomStyle.colorPalette.lightBackgorund,
                        shadowColor: CustomStyle.colorPalette.lightBackgorund,
                        onPressed: () {
                          //when pressed on the order id pop up screen shows
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
                                content: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.77,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: SingleChildScrollView(
                                    physics: ScrollPhysics(),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: orderList[index]
                                                .menuItemsNamesAndCounts
                                                .length,
                                            separatorBuilder:
                                                (BuildContext context, int x) =>
                                                    Divider(
                                              thickness: 2,
                                              color: CustomStyle
                                                  .colorPalette.textColor,
                                            ),
                                            itemBuilder:
                                                (BuildContext context, int x) {
                                              return ListTile(
                                                leading: Text(
                                                  '${orderList[index].menuItemsNamesAndCounts.keys.toList()[x]}',
                                                  style: TextStyle(
                                                      color: CustomStyle
                                                          .colorPalette
                                                          .textColor,
                                                      fontFamily: CustomStyle
                                                          .fontFamily,
                                                      fontSize: CustomStyle
                                                          .fontSizes
                                                          .itemOrderFont,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  '${orderList[index].menuItemsNamesAndCounts.values.toList()[x]}',
                                                  style: TextStyle(
                                                      color: CustomStyle
                                                          .colorPalette
                                                          .textColor,
                                                      fontFamily: CustomStyle
                                                          .fontFamily,
                                                      fontSize: CustomStyle
                                                          .fontSizes
                                                          .itemOrderFont,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Divider(
                                          thickness: 2,
                                          color: CustomStyle
                                              .colorPalette.textColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Comments ",
                                                style: TextStyle(
                                                    color: CustomStyle
                                                        .colorPalette.textColor,
                                                    fontFamily:
                                                        CustomStyle.fontFamily,
                                                    fontSize: CustomStyle
                                                        .fontSizes
                                                        .orderDetailsFont,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("${orderList[index].comments}",
                                                style: TextStyle(
                                                    color: CustomStyle
                                                        .colorPalette.textColor,
                                                    fontFamily:
                                                        CustomStyle.fontFamily,
                                                    fontSize: CustomStyle
                                                        .fontSizes
                                                        .itemOrderFont,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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
