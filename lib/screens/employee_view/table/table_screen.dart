import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/view_models/table_view_model.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/screens/table_keeping_available/table_keeping_available.dart';
import 'package:mat3ami/screens/table_keeping_available/table_keeping_occupied.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({Key? key}) : super(key: key);

  @override
  _TablesScreenState createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  int _selectedBoxIndex = -1;
  late List<TableInRestaurant> tableList;
  TextEditingController filter = TextEditingController();
  var timer;

  void _onBoxPressed(int index) {
    setState(() {
      _selectedBoxIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => Provider.of<TableViewModel>(context, listen: false)
            .updateTableList());
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    tableList = Provider.of<TableViewModel>(context, listen: true)
        .tableList
        .where((element) {
      if (filter.text != '' && int.tryParse(filter.text) != null) {
        return element.tableNum == int.parse(filter.text);
      }
      return true;
    }).toList();
    return customScaffold(
      back: false,
      context: context,
      title: 'Tables',
      actions: [
        Center(
          child: customTextField(
              keyboardType: TextInputType.number,
              textEditingController: filter,
              onchanged: ((p0) {
                setState(() {});
              }),
              hintText: 'Search',
              height: MediaQuery.of(context).size.height * 0.01,
              width: MediaQuery.of(context).size.width * 0.2),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.7 / 2,
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 10),
          itemCount: tableList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 30,
                  child: InkWell(
                    onTap: () {
                      //Navigate
                      if (tableList[index].state.toLowerCase() == "available") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvailableTableKeeping(
                                    tableNumber: tableList[index].tableNum,
                                  )),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OccupiedTableKeeping(
                                  tableNumber: tableList[index].tableNum)),
                        );
                      }
                    },
                    child: customContainer(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Center(
                        child: Text('${tableList[index].tableNum}',
                            style: TextStyle(
                              fontFamily: CustomStyle.fontFamily,
                              fontSize: 50,
                              color: (tableList[index].state.toLowerCase() ==
                                      'available')
                                  ? CustomStyle.colorPalette.green
                                  : CustomStyle.colorPalette.orange,
                            )),
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 6,
                    child: Text(
                      '${tableList[index].state}',
                      style: TextStyle(
                        fontFamily: CustomStyle.fontFamily,
                        fontSize: CustomStyle.fontSizes.orderDetailsFont,
                        color: (tableList[index].state.toLowerCase() ==
                                'available')
                            ? CustomStyle.colorPalette.green
                            : CustomStyle.colorPalette.orange,
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
