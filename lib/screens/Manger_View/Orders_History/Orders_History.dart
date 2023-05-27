import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/orders_screen/orders_screen.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class OrdersHistory extends StatefulWidget {
  const OrdersHistory({super.key});

  @override
  State<OrdersHistory> createState() => _OrdersHistoryState();
}

late List<Order> orderList;
var timer;

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) async => orderList =
            await Provider.of<OrderViewModel>(context, listen: false)
                .mangerViewOrder());
    initializeState();
  }

  Future<void> initializeState() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      orderList = await Provider.of<OrderViewModel>(context, listen: true)
          .mangerViewOrder();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String completed(int index) {
    if (orderList[index].orderStatus == "Cancelled" ||
        orderList[index].orderStatus == "Completed") {
      return orderList[index].orderStatus;
    } else {
      return "Null";
    }
  }

  int orderID(int index) {
    if (orderList[index].orderStatus == "Cancelled" ||
        orderList[index].orderStatus == "Completed") {
      return orderList[index].orderId;
    } else {
      return 0;
    }
  }

  int tableNum(int index) {
    if (orderList[index].orderStatus == "Cancelled" ||
        orderList[index].orderStatus == "Completed") {
      return orderList[index].tableNum;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
          itemCount: orderList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: Text(
                  "${orderList[index].tableNum}",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.green,
                      fontSize: CustomStyle.fontSizes.tableIDOrderMenue),
                ),
                trailing: customContainer(
                    color: CustomStyle.colorPalette.orange,
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.048,
                    child:
                        Center(child: Text("${orderList[index].orderStatus}"))),
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
                                  fontSize:
                                      CustomStyle.fontSizes.orderDetailsFont,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.77,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
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
                                                      .colorPalette.textColor,
                                                  fontFamily:
                                                      CustomStyle.fontFamily,
                                                  fontSize: CustomStyle
                                                      .fontSizes.itemOrderFont,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: Text(
                                              '${orderList[index].menuItemsNamesAndCounts.values.toList()[x]}',
                                              style: TextStyle(
                                                  color: CustomStyle
                                                      .colorPalette.textColor,
                                                  fontFamily:
                                                      CustomStyle.fontFamily,
                                                  fontSize: CustomStyle
                                                      .fontSizes.itemOrderFont,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      color: CustomStyle.colorPalette.textColor,
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
                                                    .fontSizes.orderDetailsFont,
                                                fontWeight: FontWeight.bold)),
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
                                                    .fontSizes.itemOrderFont,
                                                fontWeight: FontWeight.bold)),
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
                                  height: MediaQuery.of(context).size.height *
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
        ),
      ),
      backgroundColor: CustomStyle.colorPalette.lightBackgorund,
    );
  }
}
