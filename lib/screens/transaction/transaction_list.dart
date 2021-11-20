import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:qlct/constants.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/screens/finance/finance.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';
import 'package:qlct/theme/colors.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  var transactionService = TransactionService();
  String valueChooseMonth = listMonth.first;
  String valueChooseYear = listYear.first;
  String _fromDate = DateFormat.yMMMMd('en-US').format(DateTime.now());
  String _toDate = DateFormat.yMMMMd('en-US').format(DateTime.now());
  Widget buttonCustom(String content, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
        child: GestureDetector(
          onTap: () {
            logger.i("Month:" + valueChooseMonth.toString());
            logger.i("Year" + valueChooseYear.toString());
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: const Color(0xfffcfcfc),
          child: Column(
            children: [
              const Text(
                "List Transaction",
                style: TextStyle(
                    fontFamily: "Rubik-Bold",
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Form(child: Column(
                children: [
                  //
                  Container(
                    color: RallyColors.gray60,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10.0)),
                          //   child: DropdownButton(
                          //     onChanged: (String? value) {
                          //       setState(() {
                          //         valueChooseMonth = value!;
                          //       });
                          //     },
                          //     value: valueChooseMonth,
                          //     items: listMonth.map((items) {
                          //       return DropdownMenuItem(
                          //           value: items,
                          //           child: Text(
                          //             items,
                          //             style: const TextStyle(
                          //               fontSize: 17,
                          //             ),
                          //           ));
                          //     }).toList(),
                          //   ),
                          // ),
                          SizedBox(
                            width: size.width / 3,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "From Date",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              margin: const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2025, 1, 1),
                                      onChanged: (date) {
                                      logger.i("Onchange date: " + date.toString());
                                  }, onConfirm: (date) {
                                        String formatDate = DateFormat.yMMMMd('en-US').format(date);
                                        _fromDate = formatDate;
                                    setState(() {});
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                  setState(() {});
                                },
                                child: Text(
                                  " $_fromDate",
                                  style: const TextStyle(
                                    color:Colors.black87,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // buttonCustom("Search", QLCTColors.mainPurpleColor),
                        ],
                      ),
                    ),
                  ),
                  // To Date button
                  Container(
                    color: RallyColors.gray60,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(10.0)),
                          //   child: DropdownButton(
                          //     onChanged: (String? value) {
                          //       setState(() {
                          //         valueChooseMonth = value!;
                          //       });
                          //     },
                          //     value: valueChooseMonth,
                          //     items: listMonth.map((items) {
                          //       return DropdownMenuItem(
                          //           value: items,
                          //           child: Text(
                          //             items,
                          //             style: const TextStyle(
                          //               fontSize: 17,
                          //             ),
                          //           ));
                          //     }).toList(),
                          //   ),
                          // ),
                          SizedBox(
                            width: size.width / 3,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                "To Date",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              margin: const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2025, 1, 1),
                                      onChanged: (date) {
                                    logger.i("Onchange date: " + date.toString());
                                  }, onConfirm: (date) {
                                    String formatDate = DateFormat.yMMMMd('en-US').format(date);
                                    _toDate = formatDate;
                                    setState(() {});
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                  setState(() {});
                                },
                                child: Text(
                                  " $_toDate",
                                  style: const TextStyle(
                                    color:Colors.black87,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // buttonCustom("Search", QLCTColors.mainPurpleColor),
                        ],
                      ),
                    ),
                  ),
                  // button search
                  Container(
                      color: RallyColors.gray60,
                      child: buttonCustom("Search", QLCTColors.mainPurpleColor)),
                ],
              )),
              // Overview report
              const SizedBox(
                height: 10.0,
              ),
              Wrap(
                spacing: 20.0,
                children: [
                  Container(
                    width: (size.width - 60) / 2,
                    height: 170,
                    decoration: BoxDecoration(
                        color:QLCTColors.mainGreenColor,
                        borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: QLCTColors.mainGreenColor.withOpacity(0.8),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ],),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Center(
                                child: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: QLCTColors.mainGreenColor,
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Total Income",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "6586.0",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: (size.width - 60) / 2,
                    height: 170,
                    decoration: BoxDecoration(
                        color: QLCTColors.mainRedColor,
                        borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: QLCTColors.mainRedColor.withOpacity(0.8),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ],),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Center(
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  color: QLCTColors.mainRedColor,
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Total Expense",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "6586.0",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                future: Future.wait([
                  buildTransactionItem(),
                ]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TransactionFragment(
                        transactionItems: transactionItems,
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<TransactionItem> transactionItems = [];

  Future<List<TransactionItem>> buildTransactionItem() async {
    logger.i("BEGIN- buildTransactionItem");
    Future<List<Transaction>> transactionFu =
        transactionService.getAllTransaction();
    List<Transaction> transactions = await transactionFu;
    for (Transaction trans in transactions) {
      TransactionItem transactionItem = TransactionItem(
        title: trans.transactionName,
        subtitle: trans.createdAt.toString().substring(0, 10),
        amount: trans.amount.toString(),
        type: trans.type,
      );
      transactionItems.add(transactionItem);
    }
    logger.i(transactionItems.length.toString());
    logger.i("END - buildTransactionItem");
    return transactionItems;
  }
}
