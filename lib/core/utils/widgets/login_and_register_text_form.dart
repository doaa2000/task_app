import 'package:task_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginAndRegisterTextForm extends StatelessWidget {
  const LoginAndRegisterTextForm(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: MyColors.color1),
      controller: controller,
      cursorColor: MyColors.color1,
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.grey,
          )),
    );
  }
}
