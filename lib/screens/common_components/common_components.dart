import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';
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
    ,
    Color? color,
    Color? shadowColor}) {
  return SizedBox(
      //default size of button , if you enter a width or height as a parameter it will use it instead
      width: width ?? MediaQuery.of(context).size.width * 0.71,
      height: height ?? MediaQuery.of(context).size.height * 0.1,
      child: ElevatedButton(
        style: ButtonStyle(
            overlayColor: (color == null)
                ? MaterialStatePropertyAll(
                    CustomStyle.colorPalette.orangeSplash)
                : MaterialStatePropertyAll(color),
            elevation: const MaterialStatePropertyAll(4),
            shadowColor: (shadowColor == null)
                ? MaterialStatePropertyAll(
                    CustomStyle.colorPalette.orangeShadow)
                : MaterialStatePropertyAll(shadowColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                // Change your radius here
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            backgroundColor: (color == null)
                ? MaterialStatePropertyAll(CustomStyle.colorPalette.orange)
                : MaterialStatePropertyAll(color)),
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
                fontFamily: CustomStyle.fontFamily,
                fontSize: CustomStyle.fontSizes.dropDownMenu,
                fontWeight: FontWeight.w200),
            icon: icon,
            iconColor: CustomStyle.colorPalette.textColor),
        cursorColor: CustomStyle.colorPalette.darkBackground,
      ),
    ),
  );
}

class CustomDropDownButton extends StatefulWidget {
  CustomDropDownButton(
      {super.key, this.height, this.width, required this.order});
  double? width;
  double? height;
  late String selectedOption;
  Order order;

  String getSelectedOption() {
    return selectedOption.toString().replaceFirst('OrderStates.', '');
  }

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  List<String> options = OrderStates.values
      .map((e) => e.toString().replaceFirst('OrderStates.', ''))
      .toList();
  late Color selectedColor;
  late Color selectedColorShadow;

  @override
  Widget build(BuildContext context) {
    widget.selectedOption = widget.order.orderStatus;
    if (widget.selectedOption ==
        OrderStates.Placed.toString().replaceFirst('OrderStates.', '')) {
      selectedColor = CustomStyle.colorPalette.orange;
      selectedColorShadow = CustomStyle.colorPalette.orangeShadow;
    } else if (widget.selectedOption ==
        OrderStates.Ready.toString().replaceFirst('OrderStates.', '')) {
      selectedColorShadow = CustomStyle.colorPalette.orangeShadow;
      selectedColor = CustomStyle.colorPalette.orange;
    } else if (widget.selectedOption ==
        OrderStates.Preparing.toString().replaceFirst('OrderStates.', '')) {
      selectedColor = CustomStyle.colorPalette.yellow;
      selectedColorShadow = CustomStyle.colorPalette.yellowShadow;
    } else if (widget.selectedOption ==
        OrderStates.Served.toString().replaceFirst('OrderStates.', '')) {
      selectedColor = CustomStyle.colorPalette.green;
      selectedColorShadow = CustomStyle.colorPalette.greenShadow;
    } else if (widget.selectedOption ==
        OrderStates.Completed.toString().replaceFirst('OrderStates.', '')) {
      selectedColor = CustomStyle.colorPalette.blue;
      selectedColorShadow = CustomStyle.colorPalette.blueShadow;
    } else if (widget.selectedOption ==
        OrderStates.Cancelled.toString().replaceFirst('OrderStates.', '')) {
      selectedColor = CustomStyle.colorPalette.red;
      selectedColorShadow = CustomStyle.colorPalette.redShadow;
    } else {
      selectedColor = CustomStyle.colorPalette.textFieldColor;
      selectedColorShadow = CustomStyle.colorPalette.textFieldShadow;
    }

    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.38,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.048,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color:
              selectedColorShadow.withOpacity(0.5), // Specify the shadow color
          spreadRadius: 1, // Control the spread of the shadow
          blurRadius: 3, // Control the blur of the shadow
          offset: const Offset(0, 3), // Specify the offset of the shadow
        ),
      ], borderRadius: BorderRadius.circular(30.0), color: selectedColor),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(30.0),
        isExpanded: true,
        underline: SizedBox(),
        dropdownColor: selectedColor,
        alignment: Alignment.center,
        value: widget.order.orderStatus,

        //TODO:?use this to talk to database
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedOption = newValue!;
            widget.order.orderStatus = widget.selectedOption;
          });
        },
        icon: Icon(
          Icons.arrow_drop_down,
          color: CustomStyle.colorPalette.textColor,
        ),

        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value.toString().split('.').last,
                style: TextStyle(
                  fontSize: CustomStyle.fontSizes.dropDownMenu,
                  fontWeight: FontWeight.bold,
                  color: CustomStyle.colorPalette.textColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
