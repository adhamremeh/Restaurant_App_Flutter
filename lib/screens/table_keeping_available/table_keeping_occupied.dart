import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';
import 'package:mat3ami/business_logic/view_models/order_view_model.dart';
import 'package:mat3ami/screens/Manger_View/MenuItem/add_item_to_order_screen.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_order_details.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class OccupiedTableKeeping extends StatefulWidget {
  const OccupiedTableKeeping({super.key, required this.tableNumber});
  final int tableNumber;

  @override
  State<OccupiedTableKeeping> createState() => _OccupiedTableKeepingState();
}

class _OccupiedTableKeepingState extends State<OccupiedTableKeeping> {
  List<Order> orderList = [];
  Map<String, int> allItemsAndCounts = {};
  double total = 0;

  Future<void> initializeList() async {
    orderList = await Provider.of<OrderViewModel>(context, listen: false)
        .tableOrder(widget.tableNumber);
    for (final order in orderList) {
      for (final item in order.menuItemsNamesAndCounts.keys) {
        allItemsAndCounts[item] = (allItemsAndCounts[item] ??
            0 + order.menuItemsNamesAndCounts[item]!);
      }
    }
    total = await OrderServices.fetchOrderTotalForTableFromDatabase(
        allItemsAndCounts);
    setState(() {});
  }

  void initState() {
    super.initState();
    initializeList();
  }

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
                /*  Padding(
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
                ), */
                SizedBox(
                  height: 50,
                ),
                customOrderDetails(
                  allItemsAndCounts: allItemsAndCounts,
                  total: total,
                ),
                SizedBox(
                  height: 30.0,
                ),
                customButton(
                    context: context,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddItemToOrderScreen(
                                  tableNum: widget.tableNumber,
                                )),
                      );
                    },
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
