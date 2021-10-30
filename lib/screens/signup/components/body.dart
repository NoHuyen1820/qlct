import 'package:flutter/material.dart';
import 'package:qlct/Screens/Login/login_screen.dart';
import 'package:qlct/Screens/Signup/components/background.dart';
import 'package:qlct/Screens/Signup/components/or_divider.dart';
import 'package:qlct/Screens/Signup/components/social_icon.dart';
import 'package:qlct/components/already_have_an_account_check.dart';
import 'package:qlct/components/rounded_button.dart';
import 'package:qlct/components/rounded_input.dart';
import 'package:qlct/components/rounded_password_field.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // bool _isHidePassword = true;

  @override
  void initState() {
    // _isHidePassword = true;

  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Column(children: <Widget>[
                const Text(
                  "Đăng kí",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Email",
                  onChange: (value) {},
                  controller: emailController,
                ),
                RoundedPasswordField(
                  hintText: "Mật khẩu",
                  onChange: (value) {},
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập mật khẩu";
                    } else {
                      if (value.length < 6) return "Mật khẩu phải ít nhất 6 kí tự";
                    }
                    return null;
                  },
                ),
                RoundedPasswordField(
                  hintText: "Nhập lại mật khẩu",
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập lại mật khẩu";
                    } else {
                      if (value != passwordController.text) {
                        return "Mật khẩu xác thực không trùng khớp";
                      }
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                ),
                RoundedButton(
                  text: "Đăng kí",
                  press: () async {
                     if (_formKey.currentState!.validate()) {
                       // call check validate
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Đang xử lý")));

                        await authService.createUserWithEmailAndPasswordLocal(
                            emailController.text, passwordController.text);

                        Navigator.pop(context);
                    }
                  },
                )
              ])),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .pushReplacement(
                  MaterialPageRoute(builder: (
                      context) => const LoginScreen())
              );
            },
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SocalIcon(
              //   iconSrc: "assets/icons/facebook.svg",
              //   press: () {},
              // ),
              // SocalIcon(
              //   iconSrc: "assets/icons/twitter.svg",
              //   press: () {},
              // ),
              SocalIcon(
                iconSrc: "assets/icons/google-plus.svg",
                press: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
