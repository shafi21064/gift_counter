import 'package:flutter/material.dart';

class InfoInputForm extends StatelessWidget {
  final String labelText;
  final bool enabledField;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  const InfoInputForm({super.key,
    required this.labelText,
    this.enabledField = true,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        label: Text(labelText),
        enabled: enabledField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
    );
  }
}
