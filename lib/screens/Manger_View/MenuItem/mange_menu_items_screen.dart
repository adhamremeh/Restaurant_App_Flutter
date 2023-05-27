import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/menu_item.dart' as m;
import 'package:mat3ami/business_logic/services/menu_item_services.dart';
import 'package:mat3ami/business_logic/services/order_services.dart';
import 'package:mat3ami/business_logic/view_models/menu_view_model.dart';
import 'package:mat3ami/screens/Manger_View/MenuItem/add_menu_item_screen.dart';
import 'package:mat3ami/screens/Manger_View/MenuItem/edit_menu_item_screen.dart';

import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/table_keeping_available/table_keeping_occupied.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class ManageMenuItemsScreen extends StatefulWidget {
  ManageMenuItemsScreen({
    super.key,
  });
  @override
  State<ManageMenuItemsScreen> createState() => _ManageMenuItemsScreenState();
}

class _ManageMenuItemsScreenState extends State<ManageMenuItemsScreen>
    with SingleTickerProviderStateMixin {
  List<m.MenuItem> menuItemList = [];
  List<m.MenuItem> menuItemListToShow = [];
  TextEditingController filter = TextEditingController();
  var timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      menuItemList = await MenuItemServices.fetchAllMenuItemsFromDatabase();
      menuItemListToShow = menuItemList;
      if (mounted) setState(() {});
    });
    initalizeMenu();
  }

  @override
  void dispose() {
    if (mounted) {
      timer.cancel();
    }
    super.dispose();
  }

  Future<void> initalizeMenu() async {
    menuItemList = await MenuItemServices.fetchAllMenuItemsFromDatabase();
    menuItemListToShow = menuItemList;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyle.colorPalette.lightBackgorund,
      body: Column(
        children: [
          customTextField(
              keyboardType: TextInputType.text,
              textEditingController: filter,
              onchanged: ((p0) {
                setState(() {
                  menuItemListToShow = menuItemList.where((element) {
                    if (filter.text != '') {
                      return element.name
                          .toLowerCase()
                          .contains(filter.text.toLowerCase());
                    }
                    return true;
                  }).toList();
                });
              }),
              hintText: 'Search',
              height: MediaQuery.of(context).size.height * 0.0125,
              width: MediaQuery.of(context).size.width * 0.89),
          Divider(
            color: CustomStyle.colorPalette.textColor,
            thickness: 2.0,
          ),
          Flexible(
              flex: 13,
              child: GridView.count(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                mainAxisSpacing: MediaQuery.of(context).size.height * 0.1,
                crossAxisSpacing: 20,
                childAspectRatio: ((MediaQuery.of(context).size.width * 0.45) /
                    (MediaQuery.of(context).size.height * 0.29)),
                crossAxisCount: 2,
                children: menuItemListToShow.map((key) {
                  return menuItemWidget(key);
                }).toList(),
              )),
          Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(
                      context: context,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMenuItemScreen()),
                        );
                      },
                      childText: 'Add Menu Item')
                ],
              ))
        ],
      ),
    );
  }

  Widget menuItemWidget(m.MenuItem item) {
    return customContainer(
        child: Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: [
        customContainer(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.27,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${item.name}",
                  style: TextStyle(
                      fontFamily: CustomStyle.fontFamily,
                      fontSize: CustomStyle.fontSizes.itemOrderFont,
                      color: CustomStyle.colorPalette.textColor),
                ),
                Text(''),
                Text(
                  '${item.price}',
                  style: TextStyle(
                      fontFamily: CustomStyle.fontFamily,
                      fontSize: CustomStyle.fontSizes.orderDetailsFont,
                      color: CustomStyle.colorPalette.textColor),
                ),
                Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customButton(
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.04,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditMenuItemScreen(
                                      item: item,
                                    )),
                          );
                        },
                        childText: 'Edit'),
                    CircleAvatar(
                      backgroundColor: CustomStyle.colorPalette.lightBackgorund,
                      child: IconButton(
                          onPressed: (() async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Container(
                                  color:
                                      CustomStyle.colorPalette.lightBackgorund,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: CustomStyle.colorPalette.orange,
                                    ),
                                  ),
                                );
                              },
                            );
                            item.availability = !item.availability;
                            await MenuItemServices.editMenuItemInDatabase(item);

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Availability updated succesfully')));
                            Navigator.of(context, rootNavigator: true).pop();
                            setState(() {});
                          }),
                          icon: Icon(Icons.check_circle),
                          color: item.availability
                              ? CustomStyle.colorPalette.green
                              : CustomStyle.colorPalette.red),
                    ),
                  ],
                )
              ],
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * -0.3 * 0.25,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.092,
              backgroundColor: Colors.transparent,
              backgroundImage: m.MenuItem.decodeImage(item.imageBytes!).image,
            ))
      ],
    ));
  }
}
