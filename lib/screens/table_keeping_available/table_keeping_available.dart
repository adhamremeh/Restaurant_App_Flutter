import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/services/table_services.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/screens/table_keeping_available/table_keeping_occupied.dart';
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
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Container(
                        color: CustomStyle.colorPalette.lightBackgorund,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: CustomStyle.colorPalette.orange,
                          ),
                        ),
                      );
                    },
                  );
                  await TableServices.changeTableState(tableNumber, true);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Customers Seated succsefully')));
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OccupiedTableKeeping(
                              tableNumber: tableNumber,
                            )),
                  );
                },
                childText: "Seat Customers",
                color: CustomStyle.colorPalette.green,
                shadowColor: CustomStyle.colorPalette.greenShadow)
          ],
        ),
        title: "Table Mangment");
  }
}
