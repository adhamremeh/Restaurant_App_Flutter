import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/view_models/table_view_model.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class AddTable extends StatefulWidget {
  const AddTable({super.key});

  @override
  State<AddTable> createState() => _AddTableState();
}

class _AddTableState extends State<AddTable> {
  late List<TableInRestaurant> tableList;
  Future<void> addNewTable() async {
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

    await Provider.of<TableViewModel>(context, listen: false).addNewTable();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Added Table succsefuly')));
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> deleteTable(int tableNum) async {
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

    await Provider.of<TableViewModel>(context, listen: false)
        .deleteTable(tableNum);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Table Deleted succsefuly')));
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    tableList = Provider.of<TableViewModel>(context, listen: true)
        .tableList
        .cast<TableInRestaurant>();
    return Column(children: [
      Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text("${tableList[index].tableNum}",
                    style: TextStyle(
                        fontSize: CustomStyle.fontSizes.employeeIdFont + 5,
                        fontFamily: CustomStyle.fontFamily,
                        color: CustomStyle.colorPalette.textColor,
                        fontWeight: FontWeight.bold)),
                title: customContainer(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.048,
                    child: Center(
                        child: Text(
                      "${tableList[index].state}",
                      style: TextStyle(
                          fontFamily: CustomStyle.fontFamily,
                          color:
                              tableList[index].state.toLowerCase() == 'occupied'
                                  ? CustomStyle.colorPalette.orange
                                  : CustomStyle.colorPalette.green,
                          fontWeight: FontWeight.bold),
                    ))),
                trailing: customButton(
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
                      await deleteTable(tableList[index].tableNum);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Table Deleted succsefuly')));
                      Navigator.of(context, rootNavigator: true).pop();
                    },

                    //delete command

                    childText: "Delete",
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: CustomStyle.colorPalette.red),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: CustomStyle.colorPalette.textColor,
                thickness: 2.0,
              );
            },
            itemCount: tableList.length),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              customButton(
                  height: MediaQuery.of(context).size.height * 0.0812,
                  width: MediaQuery.of(context).size.width * 0.7044,
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
                    await addNewTable();
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Table Added succsefuly')));
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  childText: "Add New Table"),
              SizedBox(
                height: 15.0,
              )
            ],
          ))
    ]);
  }
}
