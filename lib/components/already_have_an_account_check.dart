import 'package:flutter/material.dart';
 import 'package:qlct/theme/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function()? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? AppLocalizations.of(context)!.signUpQuestion : AppLocalizations.of(context)!.signInQuestion,
          style: const TextStyle(color: kPrimaryColor,
          fontSize: 17),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? AppLocalizations.of(context)!.buttonSignUp :AppLocalizations.of(context)!.buttonSignIn ,
            style: const TextStyle(
              fontSize: 17,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
