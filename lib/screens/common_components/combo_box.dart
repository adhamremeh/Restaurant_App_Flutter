import 'package:flutter/material.dart';
import 'package:mat3ami/business_logic/models/order.dart';

import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/style/style.dart';

class ComboBox extends StatefulWidget {
  ComboBox({super.key});

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  OrderStates? selectedOption;
  List<OrderStates> options = OrderStates.values;

  _ComboBoxState();
  @override
  Widget build(BuildContext context) {
    Color selectedColor;
    Color selectedColorShadow;
    if (selectedOption.toString() == 'OrderStates.Placed') {
      selectedColor = CustomStyle.colorPalette.orange;
      selectedColorShadow = CustomStyle.colorPalette.orangeShadow;
      print('3azma');
    } else if (selectedOption.toString() == 'OrderStates.Preparing') {
      selectedColorShadow = CustomStyle.colorPalette.yellowShadow;
      selectedColor = CustomStyle.colorPalette.yellow;
    } else if (selectedOption.toString() == 'OrderStates.Ready') {
      selectedColor = CustomStyle.colorPalette.blue;
      selectedColorShadow = CustomStyle.colorPalette.blueShadow;
    } else if (selectedOption.toString() == 'OrderStates.Served') {
      selectedColor = CustomStyle.colorPalette.cyan;
      selectedColorShadow = CustomStyle.colorPalette.cyanShadow;
    } else if (selectedOption.toString() == 'OrderStates.Completed') {
      selectedColor = CustomStyle.colorPalette.green;
      selectedColorShadow = CustomStyle.colorPalette.greenShadow;
    } else if (selectedOption.toString() == 'OrderStates.Cancelled') {
      selectedColor = CustomStyle.colorPalette.red;
      selectedColorShadow = CustomStyle.colorPalette.redShadow;
    } else {
      selectedColor = CustomStyle.colorPalette.textFieldColor;
      selectedColorShadow = CustomStyle.colorPalette.textFieldShadow;
      print(selectedOption.toString().runtimeType); //testing
      print(selectedOption.toString());
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 0.38,
        height: MediaQuery.of(context).size.height * 0.0355,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: selectedColorShadow
                .withOpacity(0.5), // Specify the shadow color
            spreadRadius: 2, // Control the spread of the shadow
            blurRadius: 5, // Control the blur of the shadow
            offset: Offset(0, 3), // Specify the offset of the shadow
          ),
        ], borderRadius: BorderRadius.circular(40.0), color: selectedColor),
        child: DropdownButton<OrderStates>(
          dropdownColor: selectedColor,
          value: selectedOption,
          hint: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Select an option',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: CustomStyle.colorPalette.textColor),
            ),
          ),
          onChanged: (OrderStates? newValue) {
            setState(() {
              selectedOption = newValue!;
            });
          },
          icon: Icon(
            Icons.arrow_drop_down,
            color: CustomStyle.colorPalette.textColor,
          ),
          items:
              options.map<DropdownMenuItem<OrderStates>>((OrderStates value) {
            return DropdownMenuItem<OrderStates>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                child: Text(
                  value.toString().split('.').last,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: CustomStyle.colorPalette.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Container comboBox(
//   BuildContext context,
// ) {
//   return Container(        width: MediaQuery.of(context).size.width * 0.38,
//         height: MediaQuery.of(context).size.height * 0.0355,
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//             color: selectedColorShadow
//                 .withOpacity(0.5), // Specify the shadow color
//             spreadRadius: 2, // Control the spread of the shadow
//             blurRadius: 5, // Control the blur of the shadow
//             offset: Offset(0, 3), // Specify the offset of the shadow
//           ),
//         ], borderRadius: BorderRadius.circular(40.0), color: selectedColor),
//         child: DropdownButton<OrderStates>(
//           dropdownColor: selectedColor,
//           value: selectedOption,
//           hint: Padding(
//             padding: const EdgeInsets.only(left: 25.0),
//             child: Text(
//               'Select an option',
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: CustomStyle.colorPalette.textColor),
//             ),
//           ),
//           onChanged: (OrderStates? newValue) {
//             setState(() {
//               selectedOption = newValue!;
//             });
//           },
//           icon: Icon(
//             Icons.arrow_drop_down,
//             color: CustomStyle.colorPalette.textColor,
//           ),
//           items:
//               options.map<DropdownMenuItem<OrderStates>>((OrderStates value) {
//             return DropdownMenuItem<OrderStates>(
//               value: value,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 50.0, right: 20.0),
//                 child: Text(
//                   value.toString().split('.').last,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: CustomStyle.colorPalette.textColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),);
// }
