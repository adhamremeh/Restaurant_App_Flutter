import 'package:flutter/material.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_order_details.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';

class OccupiedTableKeeping extends StatefulWidget {
  const OccupiedTableKeeping({super.key, required this.tableNumber});
  final int tableNumber;

  @override
  State<OccupiedTableKeeping> createState() => _OccupiedTableKeepingState();
}

class _OccupiedTableKeepingState extends State<OccupiedTableKeeping> {
  @override
  Widget build(BuildContext context) {
    return customScaffold(
        context: context,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: customContainer(
                      height: 286,
                      width: 285,
                      child: Center(
                        child: Text(
                          "${widget.tableNumber}",
                          style: TextStyle(
                              fontSize: 60,
                              fontFamily: CustomStyle.fontFamily,
                              color: CustomStyle.colorPalette.orange),
                        ),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        "Order Status",
                        style: TextStyle(
                            color: CustomStyle.colorPalette.textColor,
                            fontSize: CustomStyle.fontSizes.orderDetailsFont,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "data", ////////////////////////////////////////////edit state here
                        style: TextStyle(
                            color: CustomStyle.colorPalette.textColor,
                            fontFamily: CustomStyle.fontFamily,
                            fontSize: CustomStyle.fontSizes.itemOrderFont),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                customOrderDetails(
                  allItemsAndCounts: {"pizza": 2},
                ),
                SizedBox(
                  height: 30.0,
                ),
                customButton(
                    context: context,
                    onPressed: () {},
                    height: MediaQuery.of(context).size.height * 0.0816,
                    childText: "Add to order",
                    color: CustomStyle.colorPalette.orange,
                    shadowColor: CustomStyle.colorPalette.orangeShadow),
                SizedBox(
                  height: 10.0,
                ),
                customButton(
                    height: MediaQuery.of(context).size.height * 0.0816,
                    context: context,
                    onPressed: () {},
                    childText: "Check out",
                    color: CustomStyle.colorPalette.orange,
                    shadowColor: CustomStyle.colorPalette.orangeShadow),
              ],
            ),
          ),
        ),
        title: "Table Mangment");
  }
}
