import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mat3ami/business_logic/models/employee.dart';
import 'package:mat3ami/business_logic/models/menu_item.dart' as m;
import 'package:mat3ami/business_logic/models/table_in_restaurant.dart';
import 'package:mat3ami/business_logic/services/employee_services.dart';
import 'package:mat3ami/business_logic/view_models/active_user_view_model.dart';
import 'package:mat3ami/business_logic/view_models/menu_view_model.dart';
import 'package:mat3ami/screens/common_components/combo_box.dart';
import 'package:mat3ami/screens/common_components/common_components.dart';
import 'package:mat3ami/screens/common_components/custom_scaffold.dart';
import 'package:mat3ami/style/style.dart';
import 'package:provider/provider.dart';

class AddMenuItemScreen extends StatefulWidget {
  const AddMenuItemScreen({Key? key}) : super(key: key);

  @override
  _AddMenuItemScreenState createState() => _AddMenuItemScreenState();
}

class _AddMenuItemScreenState extends State<AddMenuItemScreen> {
  final TextEditingController _ItemNameInputText = TextEditingController();
  final TextEditingController _ItemDescriptionInputText =
      TextEditingController();
  final TextEditingController _ItemPriceInputText = TextEditingController();
  final TextEditingController _categoryInputText = TextEditingController();

  String dropdownValue = '';
  List<String> categoryList = ['dessert', 'Koshary'];
  String? imageBytes;

  @override
  void initState() {
    // TODO: implement initState
  }

  Future<void> saveMenuItem() async {
    bool valid = validateTextFields();
    if (valid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            color: CustomStyle.colorPalette.lightBackgorund,
            child: Center(
              child: CircularProgressIndicator(
                color: CustomStyle.colorPalette.orange,
              ),
            ),
          );
        },
      );
      await Provider.of<MenuViewModel>(context, listen: false).addNewMenuItem(
          m.MenuItem(
              name: _ItemNameInputText.text,
              price: double.parse(_ItemPriceInputText.text),
              availability: true,
              category: _categoryInputText.text,
              description: _ItemDescriptionInputText.text,
              imageBytes: this.imageBytes));
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Item added succsefuly')));
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      title: "Add Menu Item",
      context: context,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: " Item Name",
                textEditingController: _ItemNameInputText),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: " Item Description",
                textEditingController: _ItemDescriptionInputText),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            customTextField(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.036,
                hintText: "Item Price",
                textEditingController: _ItemPriceInputText),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Select Category:",
                    style: TextStyle(
                        fontFamily: CustomStyle.fontFamily,
                        fontSize: CustomStyle.fontSizes.textFieldFont,
                        color: CustomStyle.colorPalette.textColor),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 45,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomStyle.colorPalette.orangeShadow
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3))
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: CustomStyle.colorPalette.orange),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: CustomStyle.colorPalette.orange
                                  .withOpacity(0.5), // Specify the shadow color
                              spreadRadius:
                                  1, // Control the spread of the shadow
                              blurRadius: 3, // Control the blur of the shadow
                              offset: const Offset(
                                  0, 3), // Specify the offset of the shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30.0),
                          color: CustomStyle.colorPalette.orange),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(30.0),
                        isExpanded: true,
                        underline: SizedBox(),
                        alignment: Alignment.center,
                        dropdownColor: CustomStyle.colorPalette.orange,
                        value: dropdownValue.isNotEmpty ? dropdownValue : null,
                        items: categoryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: CustomStyle.fontFamily,
                                      fontSize:
                                          CustomStyle.fontSizes.dropDownMenu,
                                      color:
                                          CustomStyle.colorPalette.textColor),
                                ),
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            _categoryInputText.text = dropdownValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              //width: MediaQuery.of(context).size.width * 0.87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Upload image:",
                    style: TextStyle(
                        fontFamily: CustomStyle.fontFamily,
                        fontSize: CustomStyle.fontSizes.textFieldFont,
                        color: CustomStyle.colorPalette.textColor),
                  ),
                  customButton(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 45,
                      context: context,
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image.
                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          List<int> bytes = await image.readAsBytes();
                          imageBytes = base64Encode(bytes);
                        }
                      },
                      childText: (imageBytes == null) ? 'upload' : 'Change')
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            customButton(
                context: context,
                onPressed: saveMenuItem,
                childText: "Save",
                width: MediaQuery.of(context).size.width / 2,
                height: 45)
          ],
        ),
      ),
    );
  }

  bool validateTextFields() {
    bool allValid = true;
    if (_ItemNameInputText.text == '') {
      _ItemNameInputText.text = 'Please Enter a valid name';
      allValid = false;
    }
    if (_ItemDescriptionInputText.text.length < 10) {
      _ItemDescriptionInputText.text = 'Please Enter a Item Description';
      allValid = false;
    }
    if (double.tryParse(_ItemPriceInputText.text) == null) {
      _ItemPriceInputText.text = 'Please Enter a valid Price';
      allValid = false;
    }
    if (_categoryInputText.text == '') {
      _categoryInputText.text = 'Please Select a valid Category';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_categoryInputText.text)));
      allValid = false;
    }

    if (imageBytes == null) {
      final temp = 'Please Select a valid Image';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(temp)));
      allValid = false;
    }

    return allValid;
  }
}
