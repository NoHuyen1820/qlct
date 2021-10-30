import 'package:flutter/material.dart';
import 'package:qlct/Screens/Login/components/background.dart';
import 'package:qlct/Screens/Signup/signup_screen.dart';
import 'package:qlct/Screens/root_app.dart';
import 'package:qlct/components/already_have_an_account_check.dart';
import 'package:qlct/components/rounded_button.dart';
import 'package:qlct/components/rounded_input.dart';
import 'package:qlct/components/rounded_password_field.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/user.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController =
        TextEditingController();

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
                  "Đăng nhập",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: emailController,
                  hintText: "Email",
                  onChange: (value) {},
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  hintText: "Mật Khẩu",
                  onChange: (value) {
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập mật khẩu";
                    }
                    return null;
                  },
                ),
                RoundedButton(
                  text: "Đăng nhập",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context)
                          .pushReplacement(
                          MaterialPageRoute(builder: (
                              context) => const RootApp())
                      );
                      // UserNew? user = await authService
                      //     .signInWithEmailAndPasswordLocal(
                      //     emailController.text, passwordController.text);
                      // if (user != null) {
                      //   Navigator.of(context)
                      //       .pushReplacement(
                      //       MaterialPageRoute(builder: (
                      //           context) => const RootApp())
                      //   );
                      // }
                    }
                  },
                )
              ])),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignupScreen();
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
