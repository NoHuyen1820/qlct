


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qlct/firebase/auth_service.dart';
import 'package:qlct/model/budget.dart';
import 'package:qlct/model/transaction.dart';
import 'package:qlct/services/budget_service/budget_service.dart';
import 'package:qlct/services/transaction_service/transaction_service.dart';
import 'package:qlct/theme/colors.dart';

import '../../constants.dart';
import '../root_app.dart';

class AddTransactionScreen extends StatefulWidget{
  const AddTransactionScreen ({Key? key}) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();


 }

class _AddTransactionScreenState  extends State <AddTransactionScreen>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountTransController = TextEditingController();
  final TextEditingController typeTransController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController reccuringController = TextEditingController();
  String selectedTransType = "1";
  final String _date = DateFormat.yMMMMd('en-US').format(DateTime.now());
  late DateTime _dateParam;


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
          onPressed: () {
            if(_formKey.currentState!.validate()){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Processing"))
              );
              Transaction transaction = Transaction(
                amount: amountTransController.text,
                type: int.parse(selectedTransType) ,
                category: int.parse(_mycategory!),
                budgetCode: _budget,
                note: noteController.text,
              );

              transService.createTransaction(transaction);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const RootApp(currentIndex: 4)));
            }
            return;
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
  Widget radioCustom(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: selectedTransType == value ? color : Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: selectedTransType == value
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
              selectedTransType = value;
            });
          },
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 0.0,
              color: selectedTransType == value ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  var budgetService = BudgetService();
  var authService = AuthService();
  var transService =TransactionService();
  late String _userCode;
 @override
  void initState() {
   _dateParam = DateTime.now();
    _userCode = authService.getCurrentUID();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .85,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                      height: 20
                  ),
                  const Text(
                    "NEW TRANSACTION",
                    style: TextStyle(
                        fontFamily: "Rubik-Bold",
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  TextFormField(
                    keyboardType:TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator:(value){
                      if( value ==null || value.isEmpty){
                        return "Please enter amount!";
                      }
                      return null;
                    },
                    controller: amountTransController,
                    decoration:const InputDecoration.collapsed(hintText: "0đ") ,
                    textAlign:TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Rubik-Bold",
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        radioCustom("INCOME", "1", QLCTColors.mainGreenColor),
                        radioCustom("EXPENSE", "2", QLCTColors.mainPinkColor),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: RallyColors.gray60,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // const SizedBox(height:12),
                          // Row(
                          //     children: <Widget>[
                          //       SizedBox(
                          //         width: size.width /5,
                          //         child: const Text("Note",
                          //             style:TextStyle(
                          //               fontSize:18,
                          //               fontFamily: "Rubik-Bold",
                          //               color: Colors.black87,
                          //             )),
                          //       ),
                          //       Expanded(
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: SizedBox(
                          //             child: Container(
                          //               decoration:const BoxDecoration(
                          //                 color: Colors.white,
                          //               ),
                          //               child: TextFormField(
                          //                 validator: (value){
                          //                   if(value!.length > 30)
                          //                   {
                          //                     return "Note is less than or equal to 30 characters";
                          //                   }
                          //                   return null;
                          //                 },
                          //                 controller: noteController,
                          //                 style: const TextStyle(
                          //                   fontSize: 18,
                          //                   color: Colors.black87,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ]
                          // ),
                          const SizedBox(height:12),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: size.width /5,
                                child: const Text("Category",
                                style:TextStyle(
                                  fontFamily: "Rubik-Bold",
                                  fontSize:18,
                                  color: Colors.black87,
                                )),
                              ),
                              Expanded(
                                child: DropdownButtonHideUnderline(
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
                                            value: _mycategory,
                                              items:categoryOptions.map((description, value) {
                                                return MapEntry(
                                                    description,
                                                    DropdownMenuItem(
                                                      value: value,
                                                      child: Text(description),
                                                    ));
                                              }).values
                                                  .toList(),
                                            iconSize: 30,
                                            icon: null,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                            ),
                                            // hint: const Text("Category"),
                                            onChanged: (valueNew)  {
                                            setState(() {
                                               _mycategory = valueNew;
                                              // _getCategoryList();
                                            });
                                            }
                                          ),
                                        ),
                                      ),
                                    ),
                                )
                                ,)
                            ]
                          ),
                          const SizedBox(height:12),
                          Row(
                              children: <Widget>[
                                SizedBox(
                                  width: size.width /5,
                                  child: const Text("Budget",
                                      style:TextStyle(
                                        fontSize:18,
                                        fontFamily: "Rubik-Bold",
                                        color: Colors.black87,
                                      )),
                                ),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
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
                                              value: _budget,
                                          items: budgetOptions
                                              .map((description, value) {
                                                return MapEntry(
                                                    description,
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
                                                  _budget = valueNew!;
                                                  // _getBudgetList();
                                                });
                                              }
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  ,)
                              ]
                          ),
                          const SizedBox(height:12),
                          //Note
                          Row(
                              children: <Widget>[
                                SizedBox(
                                  width: size.width /5,
                                  child: const Text("Note",
                                      style:TextStyle(
                                        fontSize:18,
                                        fontFamily: "Rubik-Bold",
                                        color: Colors.black87,
                                      )),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Container(
                                        decoration:const BoxDecoration(
                                            color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.length > 30)
                                              {
                                                return "Note is less than or equal to 30 characters";
                                              }
                                            return null;
                                          },
                                          controller: noteController,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black87,
                                            ),
                                          ),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                          const SizedBox(height:12),
                          //Date
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       width: size.width /5,
                          //       child: const Text("Date",
                          //           style:TextStyle(
                          //             fontSize:18,
                          //             fontFamily: "Rubik-Bold",
                          //             color: Colors.black87,
                          //           )),
                          //     ),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(10.0)),
                          //           child: TextButton(
                          //             onPressed: () {
                          //               DatePicker.showDatePicker(context,
                          //                   showTitleActions: true,
                          //                   minTime: DateTime(1900, 3, 5),
                          //                   maxTime: DateTime(2025, 1, 1),
                          //                   onChanged: (date) {},
                          //                   onConfirm: (date) {
                          //                     String formatDate = DateFormat.yMMMMd('en-US').format(date);
                          //                     _date = formatDate;
                          //                     _dateParam = QLCTUtils.dateTimeToString(date, "000000") as DateTime;
                          //                     setState(() {});
                          //                   },
                          //                   currentTime: DateTime.now(),
                          //                   locale: LocaleType.en);
                          //               setState(() {});
                          //             },
                          //             child: Text(
                          //               " $_date",
                          //               style: const TextStyle(
                          //                 color:Colors.black87,
                          //                 fontSize: 17,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height:12),
                          //Make recurring
                          Row(
                              children: <Widget>[
                                SizedBox(
                                  width: size.width /5,
                                  child: const Text("Make recurring",
                                      style:TextStyle(
                                        fontSize:18,
                                        fontFamily: "Rubik-Bold",
                                        color: Colors.black87,
                                      )),
                                ),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
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
                                              value: _recurring,
                                              items: recurringOptions.map((description, value){
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
                                                  _recurring = valueNew;
                                                  //_getRecurringList();
                                                });
                                              }
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  ,)
                              ]
                          ),
                          const SizedBox(height:18),
                          buttonCustom("SAVE", QLCTColors.mainPurpleColor),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   String? _budget = "BG000006"; //_budgetList.first.toString() ;
  Future<List<String>> _getBudgetList() async{
    Future<List<Budget>> budgetFu = budgetService.getAllBudget(_userCode);
    List<Budget> budgets = await budgetFu;
    List<String> budgetList =[];
    for (Budget b in budgets) {
        var budgetName = b.name;
      budgetList.add(budgetName);
    }
    return budgetList;
    }

  String? _recurring = "01";
  void _getRecurringList() {
  }

  String? _mycategory ="1";
  void _getCategoryList() {
  }
}





