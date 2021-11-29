import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/screens/login/login_screen.dart';
import 'package:qlct/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  // final TextEditingController _email =
  //     TextEditingController();
  // TextEditingController dateOfBirth = TextEditingController(text: "04-19-1992");
  // TextEditingController password = TextEditingController(text: "123456");
  final _auth = AuthService();

  Widget buttonCustom(String content, Color color) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: QLCTColors.mainRedColor),
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () async {
              await authService.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen()));
            },
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                letterSpacing: 0.0,
                color: QLCTColors.mainRedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            decorationStyle: TextDecorationStyle.wavy),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -2,
                                child: CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: grey.withOpacity(0.3),
                                    radius: 110.0,
                                    lineWidth: 6.0,
                                    percent: 0.53,
                                    progressColor: purple),
                              ),
                              Positioned(
                                top: 16,
                                left: 13,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 85,
                                  height: 85,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _auth.getCurrentUser()!.displayName != null ?
                              _auth.getCurrentUser()!.displayName! : "Default name",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   "Credit score: 73.50",
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //       color: black.withOpacity(0.4)),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SvgPicture.asset(
                    "assets/images/ui_profile.svg",
                    height: size.height * 0.15,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.07,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                Text(
                  _auth.getCurrentUser()!.email != null ?
                  _auth.getCurrentUser()!.email! : "No email",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Text(
                //   "Date of birth",
                //   style: TextStyle(
                //       fontWeight: FontWeight.w500,
                //       fontSize: 13,
                //       color: Color(0xff67727d)),
                // ),
                // TextField(
                //   controller: dateOfBirth,
                //   cursorColor: black,
                //   style: TextStyle(
                //       fontSize: 17, fontWeight: FontWeight.bold, color: black),
                //   decoration: InputDecoration(
                //       hintText: "Date of birth", border: InputBorder.none),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // const Text(
                //   "Date of birth",
                //   style: TextStyle(
                //       fontWeight: FontWeight.w500,
                //       fontSize: 13,
                //       color: Color(0xff67727d)),
                // ),
                // TextField(
                //   obscureText: true,
                //   controller: password,
                //   cursorColor: black,
                //   style: TextStyle(
                //       fontSize: 17, fontWeight: FontWeight.bold, color: black),
                //   decoration: InputDecoration(
                //       hintText: "Password", border: InputBorder.none),
                // ),
                buttonCustom("SIGN OUT", Colors.transparent),
              ],
            ),
          )
        ],
      ),
    );
  }
}
