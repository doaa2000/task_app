import 'package:flutter/material.dart';
import 'package:task_app/core/utils/colors.dart';
import 'package:task_app/core/utils/reusable_components.dart';
import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();

    authCubit.get(context).isRefreshTokenValid().then((value) {
      if (value == false) {
        Get.to(() => const LoginView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));

          await authCubit.get(context).isRefreshTokenValid().then((value) {
            if (value == false) {
              Get.to(() => const LoginView());
            }
          });
          setState(() {});
        },
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: BlocConsumer<authCubit, LoginState>(
              listener: (context, state) {
                if (state is RefreshTokenExpired) {
                  Get.to(() => const LoginView());
                }
              },
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 60),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                fontSize: 20,
                                color: AppColors.primaryColor,
                                title:
                                    "Name:  ${state.user.firstName} ${state.user.lastName}"),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                fontSize: 20,
                                color: AppColors.primaryColor,
                                title: "Email:  ${state.user.email} "),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                fontSize: 20,
                                color: AppColors.primaryColor,
                                title:
                                    "Phone Number:  ${state.user.phoneNumber} "),
                            const SizedBox(
                              height: 200,
                            ),
                            CustomButton(
                                onTap: () {
                                  authCubit.get(context).userLogout();
                                },
                                textColor: Colors.white,
                                text: 'Logout',
                                buttonColor: AppColors.primaryColor),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
