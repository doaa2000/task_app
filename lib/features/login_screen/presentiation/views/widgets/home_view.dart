import 'package:flutter/material.dart';
import 'package:task_app/core/utils/colors.dart';
import 'package:task_app/features/login_screen/presentiation/manager/login_cubit/login_cubit.dart';
import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    LoginCubit.get(context).isRefreshTokenValid().then((value) {
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
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));

          await LoginCubit.get(context).isRefreshTokenValid().then((value) {
            if (value == false) {
              Get.to(() => const LoginView());
            }
          });
          setState(() {});
        },
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is RefreshTokenExpired) {
                  Get.to(() => const LoginView());
                }
              },
              builder: (context, state) {
                return const Column(
                  children: [],
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
