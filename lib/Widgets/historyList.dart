import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final String purpose, days, dates;
  String? month;
  final int amount;
  HistoryList({
    required this.amount,
    required this.purpose,
    required this.dates,
    required this.days,
    this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Amount Used:"),
                  SizedBox(
                    width: 2,
                  ),
                  Text('${amount}'),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Rs'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Purpose of Use:"),
                  SizedBox(
                    width: 2,
                  ),
                  Text(purpose),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Day of Use:"),
                  SizedBox(
                    width: 2,
                  ),
                  Text(days),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Date of Use:"),
                  SizedBox(
                    width: 2,
                  ),
                  Text(dates),
                  SizedBox(
                    width: 3,
                  ),
                  Text(month!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
