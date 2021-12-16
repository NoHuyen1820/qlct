import 'dart:developer';
import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:qlct/components/rounded_input.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../constants.dart';
import '../root_app.dart';


class BudgetListScreen extends StatefulWidget {
  const BudgetListScreen({Key? key}) : super(key: key);

  @override
  _BudgetListScreenState createState() => _BudgetListScreenState();
}

class _BudgetListScreenState extends State<BudgetListScreen> {
  final TextEditingController emailController = TextEditingController();
  var budgetService = BudgetService();
  final _auth = AuthService();
  late List<Widget> _children;
  late String selectedBudgetType;
  List<BudgetCard> bcs = [];

  @override
  void initState() {
    _children = [];
    selectedBudgetType = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final addBudgetButton = Container(
      height: 80,
      width: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        // border: Border.all(color: const Color(0xFF7b68ee)),
        // borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            color: Color(0x807067ef),
            blurRadius: 25,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return const BudgetModalBottomSheet(
                      name: '', amount: '', password: '', isCreate: true);
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  "assets/images/plus_gradient.png",
                  height: 60,
                  width: 60,
                  fit: BoxFit.scaleDown,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * .35,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xff6085fa), Color(0xffb954bd)]),
                // color: Color(0xfff5ceb8),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .08,
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 8.0,
                    children: [
                      RichText(
                          text:  TextSpan(
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                              children: [
                            TextSpan(
                                text: AppLocalizations.of(context)!.helloGuy,
                                style: const TextStyle(
                                    fontFamily: "Rubik-Bold",
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700))
                          ])),
                      RichText(
                          text:  TextSpan(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              children: [
                            TextSpan(
                                text:AppLocalizations.of(context)!.better,
                                style: const TextStyle(
                                    fontFamily: "Rubik-Bold",
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: AppLocalizations.of(context)!.financialM,
                                style: const TextStyle(
                                  fontFamily: "Rubik-Medium",
                                  color: Colors.white,
                                  fontSize: 22,
                                  // fontWeight: FontWeight.bold
                                )),
                          ])),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              children: [
                            TextSpan(
                                text: AppLocalizations.of(context)!.wTh,
                                style: const TextStyle(
                                  fontFamily: "Rubik-Medium",
                                  color: Colors.white,
                                  fontSize: 22,
                                  // fontWeight: FontWeight.bold
                                )),
                            TextSpan(
                                text: AppLocalizations.of(context)!.multiple,
                                style: const TextStyle(
                                    fontFamily: "Rubik-Bold",
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700)),
                          ])),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  FutureBuilder(
                    future: Future.wait([
                      buildBudgetCardList(),
                    ]),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        if (bcs.isEmpty) {
                          return Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(
                                top: size.height * .09, left: 20.0, right: 20.0),
                            child: Center(
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/bank.png",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Image.asset(
                                      "assets/images/bank.png",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Image.asset(
                                      "assets/images/bank.png",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.createBudget + "\n" + AppLocalizations.of(context)!.thatYou,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontFamily: "Rubik-Bold",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                 Text(
                                  AppLocalizations.of(context)!.con,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontFamily: "Rubik-Bold",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.byPlan,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontFamily: "Rubik-Bold",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                addBudgetButton
                              ]),
                            ),
                          ));
                        } else {
                          _children.add(TextButton(
                            onPressed: () {},
                            child: addBudgetButton,
                          ));
                          _children.addAll(bcs);
                          return Expanded(
                              child: GridView.count(
                            padding: const EdgeInsets.only(
                                top: 50, left: 20.0, right: 20.0),
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 28,
                            mainAxisSpacing: 28,
                            children: _children,
                          ));
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future<List<BudgetCard>> buildBudgetCardList() async {
    log("BEGIN - buildBudgetCardList");
    Future<List<Budget>> budgetFu = budgetService.getAllBudget(_auth.getCurrentUID());
    List<Budget> budgets = await budgetFu;
    bcs = [];
    for (Budget b in budgets) {
      BudgetCard bc = BudgetCard(
        press: () async {
          if (b.password != null) {
            final passwordFu = showTextInputDialog(
                context: context,
                textFields: const [
                  DialogTextField(
                    obscureText: true,
                  ),
                ],
                message: "Enter password for this budget");
            List<String>? passwords = await passwordFu;
            final passwordEnter = passwords!.first;
            log("password: " + passwordEnter);
            if (passwordEnter.trim() == b.password) {
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return BudgetModalBottomSheet(
                      name: b.name,
                      amount: b.amount,
                      password:
                          b.password!.isEmpty ? '' : b.password.toString(),
                      isCreate: false,
                    );
                  });
            }
          } else {
            showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return BudgetModalBottomSheet(
                    name: b.name,
                    amount: b.amount,
                    password: '',
                    isCreate: false,
                  );
                });
          }
        },
        isCreate: false,
        title: b.name,
        amount: b.amount,
        password: b.password,
      );
      bcs.add(bc);
    }
    log(bcs.length.toString());
    log("END - buildBudgetCardList");
    return bcs;
  }

  Future<void> _refresh() async {
    return Future.delayed(
      const Duration(seconds: 0),
    );
  }
}

class BudgetModalBottomSheet extends StatefulWidget {
  final String name;
  final String amount;
  final String? password;
  final bool isCreate;

  const BudgetModalBottomSheet({
    Key? key,
    required this.name,
    required this.amount,
    this.password,
    required this.isCreate,
  }) : super(key: key);

  @override
  _BudgetModalBottomSheetState createState() => _BudgetModalBottomSheetState();
}

class _BudgetModalBottomSheetState extends State<BudgetModalBottomSheet> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameBudgetController = TextEditingController();
  final TextEditingController amountBudgetController = TextEditingController();
  final TextEditingController passwordBudgetController = TextEditingController();
  String selectedBudgetType = "1";

  final BudgetService _budgetService = BudgetService();
  final _auth = AuthService();

  @override
  initState() {
    nameBudgetController.text = widget.name;
    amountBudgetController.text = widget.amount;
    // passwordBudgetController.text = widget.password;
    super.initState();
  }

  Widget radioCustom(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: selectedBudgetType == value ? color : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: selectedBudgetType == value
                ? color.withOpacity(0.5)
                : Colors.transparent,
            spreadRadius: 4,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedBudgetType = value;
            });
          },
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.0,
              color: selectedBudgetType == value ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonCustom(String content, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Center(
        child: TextButton(
          onPressed: () async {
      if(_formKey.currentState!.validate()){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.processing)));

        Budget budget = Budget(
          name: nameBudgetController.text ,
          amount: amountBudgetController.text,
          userCode: _auth.getCurrentUID(),
          amountTarget: '',
        );
        await _budgetService.createBudget(budget);
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const RootApp(currentIndex: 2)));
      }
      },
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              letterSpacing: 0.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
String? _complete ="6";
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .85,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                   Text(
                    AppLocalizations.of(context)!.editBudget,
                    style: const TextStyle(
                        fontFamily: "Rubik-Bold",
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                      children: [
                        MinimalInputField(
                            validator:(value){
                              if(value == null || value.isEmpty){
                                return AppLocalizations.of(context)!.validNameBudget;
                              } if (value.length > 30){
                                return AppLocalizations.of(context)!.validNote;
                              }
                               return null;
                            },
                            fieldName: AppLocalizations.of(context)!.name,
                            controller: nameBudgetController,
                            colorFieldName: QLCTColors.mainPurpleColor),
                        MinimalInputField(
                          keyboardType:TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value){
                            if (value!.isEmpty){
                              return " Vui lòng nhập số tiền ngân sách! ";
                            }
                            },
                            fieldName: AppLocalizations.of(context)!.amount,
                            controller: amountBudgetController,
                            colorFieldName: QLCTColors.mainPurpleColor),
                        MinimalInputField(
                          keyboardType:TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          fieldName: 'SỐ TIỀN MỤC TIÊU',
                          colorFieldName:QLCTColors.mainPurpleColor,),
                        SizedBox(height: 20,),
                        Text("THỜI GIAN HOÀN THÀNH",
                        style: TextStyle(

                        ),),
                        SizedBox(
                          child: Row(
                            children: [
                              DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  buttonColor: Colors.black,
                                  alignedDropdown:true,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration:BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:BorderRadius.circular(10.0)
                                      ),
                                      child: DropdownButton<String>(
                                          value: _complete,
                                          items: completeOption.map((description, value){
                                            return MapEntry(description,
                                                DropdownMenuItem(
                                                  value: value,
                                                  child: Text(description),
                                                ));
                                          }).values.toList(),
                                          iconSize: 30,
                                          icon: null,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                          ),
                                          // hint: const Text("Category"),
                                          onChanged: (valueNew)  {
                                            setState(() {
                                              _complete = valueNew;
                                              //_getRecurringList();
                                            });
                                          }
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buttonCustom(AppLocalizations.of(context)!.save, QLCTColors.mainPurpleColor),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
