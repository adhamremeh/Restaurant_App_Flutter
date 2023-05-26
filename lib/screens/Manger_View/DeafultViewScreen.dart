import 'package:flutter/material.dart';
import 'package:mat3ami/screens/Manger_View/Employees/employee_screen.dart';
import 'package:mat3ami/screens/Manger_View/Orders_History/Orders_History.dart';
import 'package:mat3ami/screens/Manger_View/addTables/add_table.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';

import '../../style/style.dart';

class DeafultViewScreen extends StatefulWidget {
  const DeafultViewScreen({super.key});

  @override
  State<DeafultViewScreen> createState() => _DeafultViewScreenState();
}

class _DeafultViewScreenState extends State<DeafultViewScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Tab> myTabs = [
    Tab(text: 'Employee'),
    Tab(text: 'Menu'),
    Tab(text: 'Orders'),
    Tab(text: "Tables")
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      // Retrieve the selected tab value
      String? selectedTab = myTabs[_tabController.index].text;
      print(selectedTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
            indicatorWeight: 3,
            indicatorColor: CustomStyle.colorPalette.orange,
            controller: _tabController,
            labelColor: CustomStyle.colorPalette.orange,
            unselectedLabelColor: CustomStyle.colorPalette.textColor,
            tabs: myTabs),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Manger View",
          style: TextStyle(
              color: CustomStyle.colorPalette.textColor,
              fontFamily: CustomStyle.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: CustomStyle.fontSizes.titleFont),
        ),
        backgroundColor: CustomStyle.colorPalette.darkBackground,
      ),
      backgroundColor: CustomStyle.colorPalette.lightBackgorund,
      body: TabBarView(controller: _tabController, children: [
        EmployeeScreen(),
        Container(
            child: Text("Menu",
                style: TextStyle(fontSize: 20.0, color: Colors.white))),
        OrdersHistory(),
        AddTable()
      ]),
    );
  }
}
