import 'package:flutter/material.dart';
import 'package:qlct/components/text_field_container.dart';
import 'package:qlct/theme/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChange;
  final TextEditingController controller;
  const RoundedInputField({
    Key? key,
    this.hintText = "",
    this.icon = Icons.person,
    required this.onChange,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (value){
          if( value == null || value.isEmpty){
            return "Vui lòng nhập email";
          } else {
            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
            if(!emailValid){
              return " Email không hợp lệ";
            }
          }
          return null;
        },
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class MinimalInputField extends StatelessWidget {

  final String fieldName;
  final String? hintText;
  final String? initValue;
  final Color colorFieldName;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const MinimalInputField({
    Key? key,
    required this.fieldName,
    this.hintText,
    required this.colorFieldName,
    this.onChange,
    this.controller,
    this.initValue, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: fieldName,
          focusedBorder: const UnderlineInputBorder(),
          focusColor: colorFieldName,
        ),
      ),
    );
  }

}

