import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qlct/Screens/Login/login_screen.dart';
import 'package:qlct/Screens/Signup/signup_screen.dart';
import 'package:qlct/Screens/Welcome/components/background.dart';
import 'package:qlct/components/rounded_button.dart';
import 'package:qlct/theme/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Money Management",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Rubik-Bold",
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  decorationStyle: TextDecorationStyle.wavy),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text(
              "Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Rubik-Bold",
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  decorationStyle: TextDecorationStyle.wavy),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/piggy_bank_amico.svg",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "SIGN IN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignupScreen();
                    },
                  ),
                );
              },
              color: kPrimaryLightColor,
              textColor: kPrimaryBlackColor,
            )
          ]),
    ));
  }
}
