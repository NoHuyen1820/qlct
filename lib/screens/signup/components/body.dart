import 'package:flutter/material.dart';
import 'package:qlct/Screens/Login/login_screen.dart';
import 'package:qlct/Screens/Signup/components/background.dart';
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
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // bool _isHidePassword = true;

  @override
  void initState() {
    super.initState();
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
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputEmailField(
                  hintText: "Email",
                  onChange: (value) {},
                  controller: emailController,
                ),
                RoundedInputNameField(
                  hintText: "Full name",
                  onChange: (value) {},
                  controller: displayNameController,
                ),
                RoundedPasswordField(
                  hintText: "Password",
                  onChange: (value) {},
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the password!";
                    } else {
                      if (value.length < 6) return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                RoundedPasswordField(
                  hintText: "Confirm password",
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please re-enter your password";
                    } else {
                      if (value != passwordController.text) {
                        return "Password and confirm password do not match";
                      }
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                ),
                RoundedButton(
                  text: "Sign Up",
                  press: () async {
                     if (_formKey.currentState!.validate()) {
                       // call check validate
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Processing")));

                        await authService.createUserWithEmailAndPasswordLocal(
                            emailController.text, passwordController.text,displayNameController.text);

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
          // OrDivider(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     // SocalIcon(
          //     //   iconSrc: "assets/icons/facebook.svg",
          //     //   press: () {},
          //     // ),
          //     // SocalIcon(
          //     //   iconSrc: "assets/icons/twitter.svg",
          //     //   press: () {},
          //     // ),
          //     SocalIcon(
          //       iconSrc: "assets/icons/google-plus.svg",
          //       press: () {},
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
