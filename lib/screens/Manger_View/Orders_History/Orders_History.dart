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

List<Order> orderListToShow = [];
List<Order> orderList = [];
var timer;
TextEditingController filter = TextEditingController();

class _OrdersHistoryState extends State<OrdersHistory> {
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) async => orderList =
            (await Provider.of<OrderViewModel>(context, listen: false)
                    .mangerViewOrder())
                .toList());
    initializeState();
  }

  Future<void> initializeState() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      orderList = (await Provider.of<OrderViewModel>(context, listen: false)
          .mangerViewOrder());
      orderListToShow = orderList;

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
          itemCount: orderListToShow.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return ListTile(
                title: customTextField(
                    keyboardType: TextInputType.number,
                    textEditingController: filter,
                    onchanged: ((p0) {
                      setState(() {
                        orderListToShow = orderList.where((element) {
                          if (filter.text != '' &&
                              int.tryParse(filter.text) != null) {
                            return element.orderId
                                .toString()
                                .contains(filter.text);
                          }
                          return true;
                        }).toList();
                      });
                    }),
                    hintText: 'Search',
                    height: MediaQuery.of(context).size.height * 0.01,
                    width: MediaQuery.of(context).size.width * 0.5),
              );
            }
            return ListTile(
                leading: Text(
                  "${orderListToShow[index - 1].dateTime.year} : ${orderListToShow[index - 1].dateTime.month} : ${orderListToShow[index - 1].dateTime.day} : ${orderListToShow[index - 1].dateTime.hour}",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.green, fontSize: 14),
                ),
                trailing: customContainer(
                    color:
                        orderListToShow[index - 1].orderStatus.toLowerCase() ==
                                'completed'
                            ? CustomStyle.colorPalette.blue
                            : CustomStyle.colorPalette.red,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.048,
                    child: Center(
                        child: Text(
                      "${orderListToShow[index - 1].orderStatus}",
                      style: TextStyle(
                          fontFamily: CustomStyle.fontFamily,
                          color: CustomStyle.colorPalette.textColor,
                          fontWeight: FontWeight.bold),
                    ))),
                title: customButton(
                    childText: '#${orderListToShow[index - 1].orderId}',
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.044,
                    color: CustomStyle.colorPalette.orange,
                    shadowColor: CustomStyle.colorPalette.orangeShadow,
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
                                        itemCount: orderListToShow[index - 1]
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
                                              '${orderListToShow[index - 1].menuItemsNamesAndCounts.keys.toList()[x]}',
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
                                              '${orderListToShow[index - 1].menuItemsNamesAndCounts.values.toList()[x]}',
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
                                        Text(
                                            "${orderListToShow[index - 1].comments}",
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
