import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/Controllers/DrawerFieldController.dart';
import 'package:expense_tracker/Firebase/FinancePlan.dart';
import 'package:expense_tracker/Firebase/UserFirebase.dart';
import 'package:expense_tracker/Firebase/UserInfo.dart';
import 'package:expense_tracker/Home%20Page/home.dart';
import 'package:expense_tracker/Widgets/DrawerFields.dart';
import 'package:flutter/material.dart';

class NewTracking extends StatefulWidget {
  @override
  State<NewTracking> createState() => _NewTrackingState();
}

class _NewTrackingState extends State<NewTracking> {
  final List<String> items = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  FinancePlan plan = FinancePlan();
  UserInfo user = UserInfo();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: const BoxDecoration(
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
        body: Padding(
          padding: EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Text(
                      'Select Month',
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
                child: DrawerFields(
                  fieldText: "Total Income This Month",
                  textController: DrawerFieldControler.incomeController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: DrawerFields(
                  fieldText: "Saving Plan For this Month",
                  textController: DrawerFieldControler.savingController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  plan.month = selectedValue;
                  plan.totalEarnings = int.tryParse(
                    DrawerFieldControler.incomeController.text,
                  );
                  plan.savingPlan = int.parse(
                    DrawerFieldControler.savingController.text,
                  );
                  UserFirebase().SendClientData(plan);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ));
                },
                child: const Text(
                  "Save",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
