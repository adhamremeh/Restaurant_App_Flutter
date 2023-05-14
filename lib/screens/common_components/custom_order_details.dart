import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';

import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/style/style.dart';

class PlayGround extends StatefulWidget {
  PlayGround({super.key});
  List<Order> orderlist = [
    Order(
        orderId: 1,
        comments: "This is Pasta",
        dateTime: DateTime.now(),
        orderStatus:
            OrderStates.Placed.toString().replaceFirst("OrderStates.", ""),
        menuItemsNamesAndCounts: {"Pasta": 1, "Pizza": 2, "koshry": 1}),
    Order(
        orderId: 2,
        comments: "This is Pepsi",
        dateTime: DateTime.now(),
        orderStatus:
            OrderStates.Placed.toString().replaceFirst("OrderStates.", ""),
        menuItemsNamesAndCounts: {"Pepsi": 1, "Pizza": 2, "Rice": 1}),
  ];
  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> allItemsAndCounts = {};
    for (Order currentOrder in widget.orderlist) {
      allItemsAndCounts.addAll(currentOrder.menuItemsNamesAndCounts);
    }

    return Scaffold(
      body: customOrderDetails(allItemsAndCounts: allItemsAndCounts),
    );
  }
}

class customOrderDetails extends StatelessWidget {
  const customOrderDetails({
    super.key,
    required this.allItemsAndCounts,
  });

  final Map<String, int> allItemsAndCounts;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: customContainer(
        width: 600.0,
        height: 600.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Details:",
                    style: TextStyle(
                      fontFamily: CustomStyle.fontFamily,
                      fontSize: CustomStyle.fontSizes.orderDetailsFont,
                      color: CustomStyle.colorPalette.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: allItemsAndCounts.length + 1,
                itemBuilder: (context, index) {
                  if (index < allItemsAndCounts.length - 1) {
                    final itemName = allItemsAndCounts.keys.elementAt(index);
                    final itemCount = allItemsAndCounts.values.elementAt(index);
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 35.0),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 35.0, right: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemName,
                                  style: TextStyle(
                                    color: CustomStyle.colorPalette.textColor,
                                    fontSize:
                                        CustomStyle.fontSizes.itemOrderFont,
                                    fontFamily: CustomStyle.fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$itemCount',
                                  style: TextStyle(
                                    color: CustomStyle.colorPalette.textColor,
                                    fontSize:
                                        CustomStyle.fontSizes.itemOrderFont,
                                    fontFamily: CustomStyle.fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0),
                              child: Divider(
                                color: CustomStyle.colorPalette.textColor,
                                thickness: 2,
                              )),
                        ],
                      ),
                    );
                  } else if (index == allItemsAndCounts.length - 1) {
                    final itemName = allItemsAndCounts.keys.elementAt(index);
                    final itemCount = allItemsAndCounts.values.elementAt(index);
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 35.0),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 35.0, right: 35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemName,
                                  style: TextStyle(
                                    color: CustomStyle.colorPalette.textColor,
                                    fontSize:
                                        CustomStyle.fontSizes.itemOrderFont,
                                    fontFamily: CustomStyle.fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$itemCount',
                                  style: TextStyle(
                                    color: CustomStyle.colorPalette.textColor,
                                    fontSize:
                                        CustomStyle.fontSizes.itemOrderFont,
                                    fontFamily: CustomStyle.fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: CustomStyle.colorPalette.textColor,
                              thickness: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    color: CustomStyle.colorPalette.textColor,
                                    fontSize:
                                        CustomStyle.fontSizes.orderDetailsFont,
                                    fontFamily: CustomStyle.fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                //////////////////////////////////// ADD Total Price Here ////////////////////////////////////////////////////////////
                                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
