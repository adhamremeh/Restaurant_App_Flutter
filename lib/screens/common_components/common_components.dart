import 'package:flutter/material.dart';
import 'package:mat3ami/style/style.dart';

Container customContainer(
    {required Widget child, double? width, double? height}) {
  return Container(
    width: width,
    height: height,
    decoration: (BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: CustomStyle.colorPalette.darkBackground,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          )
        ],
        color: CustomStyle.colorPalette.darkBackground)),
    child: child,
  );
}

Widget customButton(
    {required BuildContext context,
    required onPressed, //pass function that will execute when button is pressed here inside (){}
    required String childText, //text written inside the button
    double? width,
    double? height,
    double borderRadius = 40, //default curvature of edges
    TextStyle?
        textStyle //if you want a different text size , color , etc pass the style you want here
    }) {
  return SizedBox(
      //default size of button , if you enter a width or height as a parameter it will use it instead
      width: width ?? MediaQuery.of(context).size.width * 0.71,
      height: height ?? MediaQuery.of(context).size.height * 0.1,
      child: ElevatedButton(
        style: ButtonStyle(
            overlayColor:
                MaterialStatePropertyAll(CustomStyle.colorPalette.orangeSplash),
            elevation: const MaterialStatePropertyAll(4),
            shadowColor:
                MaterialStatePropertyAll(CustomStyle.colorPalette.orangeShadow),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                // Change your radius here
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            backgroundColor:
                MaterialStatePropertyAll(CustomStyle.colorPalette.orange)),
        onPressed: onPressed,
        child: Text(
          childText,
          style: (textStyle == null)
              ? TextStyle(
                  fontFamily: CustomStyle.fontFamily,
                  fontSize: CustomStyle.fontSizes.buttonTextFont,
                  color: CustomStyle.colorPalette.textColor,
                  fontWeight: FontWeight.bold)
              : textStyle,
        ),
      ));
}

Widget customTextField(
    {required TextEditingController textEditingController,
    required String hintText,
    required double width,
    required double height,
    Icon? icon}) {
  return SizedBox(
    width: width,
    height: height,
    child: Container(
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: CustomStyle.colorPalette.textFieldColor,
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                width: 2.0,
                color: CustomStyle
                    .colorPalette.orange, // Sets the border color when focused
              ),
            ),
            fillColor: CustomStyle.colorPalette.textFieldColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
                color: CustomStyle.colorPalette.textColor,
                fontSize: 12,
                fontWeight: FontWeight.w200),
            icon: icon,
            iconColor: Colors.white),
        cursorColor: CustomStyle.colorPalette.darkBackground,
      ),
    ),
  );
}