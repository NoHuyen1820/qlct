import 'package:flutter/material.dart';
import 'package:qlct/Screens/Login/login_screen.dart';
import 'package:qlct/Screens/Signup/components/background.dart';
import 'package:qlct/components/already_have_an_account_check.dart';
import 'package:qlct/components/rounded_button.dart';
import 'package:qlct/components/rounded_input.dart';
import 'package:qlct/components/rounded_password_field.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                 Text(
                  AppLocalizations.of(context)!.buttonSignUp,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputEmailField(
                  hintText: "Email",
                  onChange: (value) {},
                  controller: emailController,
                ),
                RoundedInputNameField(
                  hintText: AppLocalizations.of(context)!.buttonFullName,
                  onChange: (value) {},
                  controller: displayNameController,
                ),
                RoundedPasswordField(
                  hintText: AppLocalizations.of(context)!.buttonHinPass,
                  onChange: (value) {},
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.validPassOne;
                    } else {
                      if (value.length < 6) return AppLocalizations.of(context)!.validPassTwo;
                    }
                    return null;
                  },
                ),
                RoundedPasswordField(
                  hintText: AppLocalizations.of(context)!.buttonConfirmPass,
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.validPassThree;
                    } else {
                      if (value != passwordController.text) {
                        return AppLocalizations.of(context)!.validPassFour;
                      }
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                ),
                RoundedButton(
                  text: AppLocalizations.of(context)!.buttonSignUp,
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
        ],
      ),
    );
  }
}
