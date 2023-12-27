import 'package:task_app/core/utils/bloc_observer.dart';
import 'package:task_app/core/utils/service_locator.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo_impl.dart';

import 'package:task_app/features/login_screen/presentiation/manager/auth_cubit/auth_cubit.dart';
import 'package:get/get.dart';

import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/users_screen/data/repos/users_repo_impl.dart';
import 'package:task_app/features/users_screen/presentiation/manager/cubit/users_cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => authCubit(getIt.get<LoginRepoImpl>())),
        BlocProvider(
            create: (context) => UsersCubit(getIt.get<UsersRepoImpl>())),
      ],
      child: const GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
