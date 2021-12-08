import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qlct/Screens/Login/login_screen.dart';
import 'package:qlct/Screens/Signup/signup_screen.dart';
import 'package:qlct/Screens/Welcome/components/background.dart';
import 'package:qlct/components/rounded_button.dart';
import 'package:qlct/theme/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.05,
            ),
             Text(
             AppLocalizations.of(context)!.welcomeTitle ,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
              text: AppLocalizations.of(context)!.buttonSignIn,
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
              text: AppLocalizations.of(context)!.buttonSignUp,
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
