import 'package:flutter/material.dart';
import 'package:qlct/components/text_field_container.dart';
import 'package:qlct/theme/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChange;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;

  const RoundedPasswordField({
    Key? key,
    required this.onChange,
    this.hintText = "",
    required this.controller,
    required this.validator,
    this.obscureText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHidePassword = true;
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        onChanged: onChange,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
              // onTap: _togglePasswordView,
              onPressed: () {},
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                //color: kPrimaryColor,
              )),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
