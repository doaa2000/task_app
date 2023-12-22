import 'package:task_app/core/utils/colors.dart';
import 'package:task_app/core/utils/extensions.dart';
import 'package:task_app/core/utils/widgets/custom_text_widget.dart';
import 'package:task_app/core/utils/widgets/login_and_register_button.dart';
import 'package:task_app/core/utils/widgets/login_and_register_text_form.dart';
import 'package:task_app/features/login_screen/presentiation/manager/login_cubit/login_cubit.dart';
import 'package:task_app/features/sign_up_screen/presentiation/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [MyColors.color1, Colors.white])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to bookly app',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: MyColors.color1,
                                  blurRadius: 20,
                                  offset: const Offset(0, 10))
                            ],
                          ),
                          child: Column(children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200] ??
                                              Colors.grey))),
                              child: LoginAndRegisterTextForm(
                                  controller: emailController,
                                  hintText: 'Email Address'),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: LoginAndRegisterTextForm(
                                  controller: passwordController,
                                  hintText: 'Password'),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        LoginAndRegisterButton(
                          text: 'Login',
                          onTap: () {
                            LoginCubit.get(context).userLogin(
                                email: 'alsaedifahad58@gmail.com',
                                password: 'Fa123456');
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomTextWidget(
                              text: "don't have an account?",
                              color: Colors.black,
                            ),
                            TextButton(
                              onPressed: () {
                                context.toView(const SignUpView());
                              },
                              child: CustomTextWidget(
                                text: "Sign up",
                                color: MyColors.color1,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))),
      ]),
    ));
  }
}
