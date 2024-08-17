import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/Controllers/DrawerFieldController.dart';
import 'package:expense_tracker/Firebase/Trackings.dart';
import 'package:expense_tracker/Firebase/UserFirebase.dart';
import 'package:expense_tracker/Widgets/DrawerFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TrackingFinance track = TrackingFinance();
  String? monthName;
  List<int> spendingAmount = [];
  int? totalSpending;
  GetDataForExpense() async {
    CollectionReference getMonth =
        FirebaseFirestore.instance.collection('Roshaan');
    QuerySnapshot snapshot = await getMonth.get();
    print("Execution....");
    snapshot.docs.forEach((doc) {
      setState(() {
        if (doc['Status'] == 'Continued') {
          monthName = doc['Current Month'];
          print(monthName);
        } else {}
      });
    });
  }

  Future<void> setSpending() async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection("Roshaan")
        .doc(monthName)
        .collection("Monthly Statement");
    QuerySnapshot snapshot = await reference.get();
    snapshot.docs.forEach((doc) {
      spendingAmount.add(doc['Amount Used']);
      totalSpending = spendingAmount.reduce((a, b) => a + b);
    });
    FirebaseFirestore.instance.collection("Roshaan").doc(monthName).update(
      {
        'Total Spending': totalSpending,
      },
    ).catchError((error) {
      print(error);
    });
  }

  String? selectedValue;
  String? selectedValue1;
  List<String> items = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> dates = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.7, 0.9],
          colors: [
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 50,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: DrawerFields(
                    fieldText: "Amount Used",
                    textController: DrawerFieldControler.usageController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: DrawerFields(
                    fieldText: "Purpose of Usage",
                    textController: DrawerFieldControler.purposeController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Day',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        elevation: 2,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      items: dates
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue1,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue1 = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        elevation: 2,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: DrawerFields(
                    fieldText: "Date/Time",
                    textController: DrawerFieldControler.dateController,
                    fieldHintText: DateFormat('EEEE d, y ').format(
                      Timestamp.now().toDate(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    GetDataForExpense();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirm Info'),
                          content: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Amount Used:'),
                                  Text('${track.amountUsed}')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Purpose of Usage:'),
                                  Text('${track.purpose}')
                                ],
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Confirm'),
                              onPressed: () {
                                if (monthName != null &&
                                    track.amountUsed != null &&
                                    track.dateOfMonth != null &&
                                    track.dayofMonth != null &&
                                    track.purpose != null) {
                                  setSpending();
                                  UserFirebase().SendClientDatatoCollection(
                                    monthName,
                                    track,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Fill all fields.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 10,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                    print(monthName);
                    //plan.month = widget.monthName;
                    track.amountUsed =
                        int.tryParse(DrawerFieldControler.usageController.text);
                    track.purpose = DrawerFieldControler.purposeController.text;
                    track.trackDate = DateTime.now();
                    track.dayofMonth = selectedValue;
                    track.dateOfMonth = selectedValue1;
                  },
                  child: Text(
                    "Save",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
