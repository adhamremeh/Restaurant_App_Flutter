import 'package:flutter/material.dart';
import 'package:mat3ami/style/style.dart';

Scaffold customScaffold(
    {required BuildContext context,
    required Widget body,
    required String title,
    bool back = true,
    List<Widget>? actions}) {
  return Scaffold(
    appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        leading: (back)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          title,
          style: TextStyle(
              color: CustomStyle.colorPalette.textColor,
              fontFamily: CustomStyle.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: CustomStyle.fontSizes.titleFont),
        ),
        backgroundColor: CustomStyle.colorPalette.darkBackground,
        actions: actions),
    backgroundColor: CustomStyle.colorPalette.lightBackgorund,
    body: body,
  );
}
