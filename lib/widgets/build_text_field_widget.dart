import 'package:flutter/material.dart';
import 'package:tapfirst/utils/app_colors.dart';

Widget buildTextFieldWidget(TextEditingController controller, String label,
    {bool isPassword = false}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        obscureText: isPassword,
      ),
    ),
  );
}
