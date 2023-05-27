import 'package:flutter/material.dart';
import 'package:mat3ami/screens/Manger_View/Orders_History/Orders_History.dart';
import 'package:mat3ami/screens/employee_view/orders_screen/orders_screen.dart';
import 'package:mat3ami/screens/employee_view/table/table_screen.dart';
import 'package:mat3ami/style/style.dart';

class WaiterMainScreen extends StatefulWidget {
  const WaiterMainScreen({super.key});

  @override
  State<WaiterMainScreen> createState() => _WaiterMainScreenState();
}

class _WaiterMainScreenState extends State<WaiterMainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[TablesScreen(), OrdersScreen()];

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
        unselectedItemColor: CustomStyle.colorPalette.darkBackground,
        selectedItemColor: CustomStyle.colorPalette.textColor,
        items: <BottomNavigationBarItem>[
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
