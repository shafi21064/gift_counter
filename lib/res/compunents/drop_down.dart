import 'package:flutter/material.dart';
import 'package:gifter/utils/app_color.dart';

class DropDown extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) onValueChanged;
  final String hintText;
  final double width;

  const DropDown({super.key,
    required this.options,
    required this.selectedValue,
    required this.onValueChanged,
    required this.hintText,
    required this.width});


  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 62,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(.7), width: 1),
            borderRadius: BorderRadius.circular(20)
        ),
        child:DropdownButton(
          isExpanded: true,
          hint: Text(
          hintText,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          underline: const SizedBox(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          iconSize: 30,
          dropdownColor: AppColor.blueGrey,
          elevation: 0,
          borderRadius: BorderRadius.circular(20),
          value: selectedValue,
          onChanged: onValueChanged,
          items: options
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
    );
  }
}