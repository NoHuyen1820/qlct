import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                  AppLocalizations.of(context)!.buttonSignIn,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputEmailField(
                  controller: emailController,
                  hintText: "Email",
                  onChange: (value) {},
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.buttonHinPass,
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.validPassOne;
                    }
                    return null;
                  },
                ),
                RoundedButton(
                  text: AppLocalizations.of(context)!.buttonSignIn,
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserNew? user =
                        await authService.signInWithEmailAndPasswordLocal(
                            emailController.text, passwordController.text);
                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const RootApp(currentIndex: 0)));
                        }
                      } on Exception catch (_, e) {
                        logger.e(e);
                        passwordController.text = "";
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email hoặc mật khẩu không đúng")));
                      }
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
