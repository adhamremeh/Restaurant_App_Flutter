import 'package:flutter/material.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';

class AvailableTableKeeping extends StatelessWidget {
  const AvailableTableKeeping({super.key, required this.tableNumber});
  final int tableNumber;
  @override
  Widget build(BuildContext context) {
    return customScaffold(
        context: context,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: customContainer(
                  height: 286,
                  width: 285,
                  child: Center(
                    child: Text(
                      "$tableNumber",
                      style: TextStyle(
                          fontSize: 60,
                          fontFamily: CustomStyle.fontFamily,
                          color: CustomStyle.colorPalette.green),
                    ),
                  )),
            ),
            SizedBox(
              height: 100,
            ),
            customButton(
                context: context,
                onPressed: () {},
                childText: "Seat Customers",
                color: CustomStyle.colorPalette.green,
                shadowColor: CustomStyle.colorPalette.greenShadow)
          ],
        ),
        title: "Table Mangment");
  }
}
