import 'package:flutter/material.dart';

class DrawerFields extends StatelessWidget {
  String fieldText;
  TextEditingController textController;
  String? fieldHintText, fieldPrefixText;
  DrawerFields({
    required this.fieldText,
    required this.textController,
    this.fieldHintText,
    this.fieldPrefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      enableSuggestions: true,
      autocorrect: true,
      autofocus: fieldHintText == null ? false : true,
      readOnly: fieldHintText == null ? false : true,
      //restorationId: "Name",
      decoration: InputDecoration(
        label: Text(fieldText),
        hintText: fieldHintText,
        prefixText: fieldPrefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
