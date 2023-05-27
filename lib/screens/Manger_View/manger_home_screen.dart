import 'package:flutter/material.dart';
import 'package:mat3ami/screens/Manger_View/DeafultViewScreen.dart';
import 'package:mat3ami/screens/Manger_View/Orders_History/Orders_History.dart';
import 'package:mat3ami/screens/employee_view/orders_screen/orders_screen.dart';
import 'package:mat3ami/screens/employee_view/table/table_screen.dart';
import 'package:mat3ami/style/style.dart';

class MangerViewScreen extends StatefulWidget {
  const MangerViewScreen({super.key});

  @override
  State<MangerViewScreen> createState() => _MangerViewScreenState();
}

class _MangerViewScreenState extends State<MangerViewScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DeafultViewScreen(),
    TablesScreen(),
    OrdersScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: CustomStyle.colorPalette.textColor,
        selectedItemColor: CustomStyle.colorPalette.textColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: CustomStyle.colorPalette.lightBackgorund,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_restaurant_outlined),
            label: 'Tables',
            backgroundColor: CustomStyle.colorPalette.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
            backgroundColor: CustomStyle.colorPalette.green,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
