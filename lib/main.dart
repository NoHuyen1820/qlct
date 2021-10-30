import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlct/theme/constants.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/wrapper.dart';
import 'package:provider/provider.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Signup/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: "/",
          routes: {
            '/': (context) => const Wrapper(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const SignupScreen(),
          },
        ));
  }
}
