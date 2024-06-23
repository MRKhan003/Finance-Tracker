import 'package:expense_tracker/Home%20Page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardWidget extends StatelessWidget {
  String cardName;
  IconData cardIcon;
  Color cardColor, iconColor;
  Widget newPage;

  CardWidget({
    required this.cardName,
    required this.cardIcon,
    required this.cardColor,
    required this.iconColor,
    required this.newPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return newPage;
          },
        ));
      },
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                cardIcon,
                color: iconColor,
              ),
              Text(
                cardName,
              )
            ],
          ),
        ),
      ),
    );
  }
}
