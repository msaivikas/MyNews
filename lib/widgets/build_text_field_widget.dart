import 'package:flutter/material.dart';
import 'package:tapfirst/utils/app_colors.dart';

Widget buildTextFieldWidget(TextEditingController controller, String label,
    {bool isPassword = false}) {
  return Container(
    decoration: const BoxDecoration(
      color: AppColors.whiteColor,
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        // fillColor: Colors.green,
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
      obscureText: isPassword,
    ),
  );
}
