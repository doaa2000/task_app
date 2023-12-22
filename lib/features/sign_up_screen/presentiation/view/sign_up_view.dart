import 'package:task_app/core/utils/colors.dart';
import 'package:task_app/core/utils/widgets/login_and_register_button.dart';
import 'package:task_app/core/utils/widgets/login_and_register_text_form.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var userNameController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [MyColors.color1, Colors.white])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 40,
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
                                    controller: userNameController,
                                    hintText: 'User Name'),
                              ),
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
                            height: 60,
                          ),
                          LoginAndRegisterButton(
                            text: 'Sign Up',
                            onTap: () {
                              // context.toView(Home());
                            },
                          )
                        ],
                      ),
                    ),
                  ))),
        ]),
      ),
    );
  }
}
