import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/view_models/table_view_model.dart';
import 'package:mat3ami/screens/playGround.dart';
import 'package:mat3ami/screens/table/table_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TableViewModel(),
        )
      ],
      child: MaterialApp(
        home: TablesScreen(),
      ),
    );
  }
}
