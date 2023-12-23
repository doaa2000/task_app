import 'package:task_app/core/cache_helper.dart';
import 'package:task_app/core/utils/bloc_observer.dart';
import 'package:task_app/core/utils/service_locator.dart';

import 'package:task_app/features/login_screen/presentiation/manager/login_cubit/login_cubit.dart';
import 'package:get/get.dart';

import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
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
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: const GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
