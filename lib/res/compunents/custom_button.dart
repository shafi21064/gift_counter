import 'package:flutter/material.dart';
import 'package:gifter/utils/app_color.dart';
import 'package:gifter/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const CustomButton({super.key,
    required this.buttonName,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: Utils(context).width * .8,
        decoration: BoxDecoration(
          color: AppColor.purple.withOpacity(.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22
          ),
        ),
      ),
    );
  }
}
