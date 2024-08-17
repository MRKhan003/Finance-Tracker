import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Firebase/FinancePlan.dart';
import 'package:expense_tracker/Firebase/Trackings.dart';
import 'package:expense_tracker/Firebase/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UserFirebase {
  FirebaseFirestore ffStore = FirebaseFirestore.instance;
  FinancePlan plan1 = FinancePlan();
  UserInfo info = UserInfo();
  Future<bool> SendClientData(FinancePlan plan) async {
    try {
      await ffStore
          .collection('Roshaan')
          .doc(
            DateFormat('EEEE d, y ').format(Timestamp.now().toDate()),
          )
          .set({
        "Total Amount": plan.totalEarnings,
        "Saving Amount": plan.savingPlan,
        "Current Month": plan.month,
        "Plan Starting Time": Timestamp.now(),
        "Status": "Continued",
        "Total Spending": 0,
      });
      Fluttertoast.showToast(
        msg: "Data added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future<bool> SendClientDatatoCollection(
      String? month, TrackingFinance track) async {
    try {
      await ffStore
          .collection('Roshaan')
          .doc(month)
          .collection("Monthly Statement")
          .doc(track.trackDate.toString())
          .set({
        "Date and Time": track.trackDate,
        "Amount Used": track.amountUsed,
        "Purpose of Use": track.purpose,
        "Day of the month": track.dayofMonth,
        "Date of the month": track.dateOfMonth,
      });
      Fluttertoast.showToast(
        msg: "New expense added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
