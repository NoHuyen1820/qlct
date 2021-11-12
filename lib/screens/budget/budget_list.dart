import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qlct/components/rounded_input.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/budget_service/budget_service.dart';

class BudgetListScreen extends StatefulWidget {
  const BudgetListScreen({Key? key}) : super(key: key);

  @override
  _BudgetListScreenState createState() => _BudgetListScreenState();
}

class _BudgetListScreenState extends State<BudgetListScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  var budgetService = BudgetService();
  late List<Widget> _children;

  @override
  void initState() {
    _children = [];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isEmptyList = false;

    final addBudgetButton = Container(
      height: 100,
      width: 100,
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
                builder: (context) {
                  return Container(
                    height: 700,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text(
                                "Budget information",
                                style: TextStyle(
                                    fontFamily:
                                    "Rubik-Bold",
                                    color: Colors.black87,
                                    fontSize: 25,
                                    fontWeight:
                                    FontWeight.w700),
                              ),
                              RoundedInputField(
                                hintText: "Budget name",
                                onChange: (value) {},
                                controller: emailController,
                              ),
                              RoundedInputField(
                                hintText: "Amount",
                                onChange: (value) {},
                                controller: emailController,
                              ),
                              RoundedInputField(
                                hintText: "Type",
                                onChange: (value) {},
                                controller: emailController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
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
                const SizedBox(
                  height: 70.0,
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 8.0,
                  children: [
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            children: [
                          TextSpan(
                              text: "Hello guy!",
                              style: TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700))
                        ])),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            children: [
                          TextSpan(
                              text: "Better ",
                              style: TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text: "financial management",
                              style: TextStyle(
                                fontFamily: "Rubik-Medium",
                                color: Colors.white,
                                fontSize: 24,
                                // fontWeight: FontWeight.bold
                              )),
                        ])),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            children: [
                          TextSpan(
                              text: "with",
                              style: TextStyle(
                                fontFamily: "Rubik-Medium",
                                color: Colors.white,
                                fontSize: 24,
                                // fontWeight: FontWeight.bold
                              )),
                          TextSpan(
                              text: " multiple budgets",
                              style: TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  color: Colors.white,
                                  fontSize: 25,
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
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      if (bcs.isEmpty) {
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 180, left: 20.0, right: 20.0),
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
                              const Text(
                                "Create a budget\nthat fits you",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 35,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                "Continue customizing your budget",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 17,
                                ),
                              ),
                              const Text(
                                "by planning your income and expense.",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                maxLines: 2,
                                softWrap: false,
                                style: TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 10.0,),
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
    );
  }

  List<BudgetCard> bcs = [];

  Future<List<BudgetCard>> buildBudgetCardList() async {
    log("BEGIN - buildBudgetCardList");
    Future<List<Budget>> budgetFu = budgetService.getAllBudget();
    List<Budget> budgets = await budgetFu;
    for (Budget b in budgets) {
      BudgetCard bc = BudgetCard(
        press: () {},
        isCreate: false,
        title: b.name,
        amount: b.amount,
      );
      bcs.add(bc);
    }
    log(bcs.length.toString());
    log("END - buildBudgetCardList");
    return bcs;
  }
}
