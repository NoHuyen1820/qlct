import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlct/Screens/Welcome/welcome_screen.dart';
import 'package:qlct/Screens/root_app.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserNew?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<UserNew?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserNew? user = snapshot.data;
          if(user != null) log(user.uid);
          return user == null ? const WelcomeScreen() : RootApp(currentIndex: 0);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
