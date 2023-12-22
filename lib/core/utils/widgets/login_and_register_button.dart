import 'package:task_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginAndRegisterButton extends StatelessWidget {
  const LoginAndRegisterButton({super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.color1,
        ),
        child: Center(
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.white, fontSize: 20))),
      ),
    );
  }
}
