import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Widgets/historyList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? totalAmount, savingAmount, totalSpending;
  String? month;
  List<int> spendingAmount = [];
  List<String> purpose = [];
  List<String> days = [];
  List<String> dates = [];

  Future<void> GetData() async {
    CollectionReference data = FirebaseFirestore.instance.collection('Roshaan');
    QuerySnapshot snapshot = await data.get();
    print("Execution....");
    snapshot.docs.forEach((doc) {
      setState(() {
        totalAmount = doc['Total Amount'];
        savingAmount = doc['Saving Amount'];
        month = doc['Current Month'];
      });
    });
  }

  Future<void> GetDataFromSubDirectory() async {
    CollectionReference reference = FirebaseFirestore.instance
        .collection("Roshaan")
        .doc(month)
        .collection("Monthly Statement");
    QuerySnapshot snapshot = await reference.get();
    snapshot.docs.forEach((doc) {
      spendingAmount.add(doc['Amount Used']);
      days.add(doc['Day of the month']);
      dates.add(doc['Date of the month']);
      purpose.add(doc['Purpose of Use']);
      totalSpending = spendingAmount.reduce((a, b) => a + b);
    });
    print(totalSpending);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          "Welcome Roshaan!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 900,
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.end,
                          "Current Financial Month:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          textAlign: TextAlign.end,
                          "${month}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.end,
                          "Total Income This Month",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            GetData();
                          },
                          child: Icon(
                            Icons.replay_circle_filled,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.end,
                      "${totalAmount}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 1, 1, 1),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Saving Plan",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 1, 1, 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${savingAmount}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 20, 1),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  "Total Spending",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(1, 1, 20, 10),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${totalSpending}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  30,
                  20,
                  0,
                  0,
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'History:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ),
              FutureBuilder(
                future: GetDataFromSubDirectory(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: purpose.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            HistoryList(
                              amount: spendingAmount[index],
                              purpose: purpose[index],
                              dates: dates[index],
                              days: days[index],
                              month: month,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
