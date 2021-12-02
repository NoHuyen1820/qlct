import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlct/l10n/l10n.dart';
import 'package:qlct/provider/notify_provider.dart';
import 'package:qlct/theme/colors.dart';
import 'package:qlct/theme/constants.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Signup/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      null,
  [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: QLCTColors.mainPurpleColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'channelDescription',
    ),
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Scheduled Notifications',
      defaultColor: QLCTColors.mainPurpleColor,
      locked: true,
      importance: NotificationImportance.High,
      channelDescription: 'channelDescription2',
    )
  ]
  );
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
          ChangeNotifierProvider(create: (context) => NotifyProvider()),
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
          locale: Locale("vi"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
        ));
  }
}
