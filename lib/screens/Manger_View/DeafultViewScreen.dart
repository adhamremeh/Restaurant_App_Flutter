import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Employee",
            ),
            Tab(
              text: "Menu",
            ),
            Tab(
              text: "Orders",
            ),
          ],
        ),
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
        Container(
            child: Text(
          "Employee",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        )),
        Container(
            child: Text("Menu",
                style: TextStyle(fontSize: 20.0, color: Colors.white))),
        Container(
            child: Text("Orders",
                style: TextStyle(fontSize: 20.0, color: Colors.white)))
      ]),
    );
  }
}
