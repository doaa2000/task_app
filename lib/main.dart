import 'package:task_app/core/cache_helper.dart';
import 'package:task_app/core/theme/app_themes.dart';
import 'package:task_app/core/utils/api_services.dart';
import 'package:task_app/core/utils/bloc_observer.dart';
import 'package:task_app/core/utils/service_locator.dart';
import 'package:task_app/features/login_screen/data/models/login_model/login_model/login_model.dart';
import 'package:task_app/features/login_screen/data/repos/login_repo_impl.dart';
import 'package:task_app/features/login_screen/presentiation/manager/login_cubit/login_cubit.dart';

import 'package:task_app/features/login_screen/presentiation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'core/utils/colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  setup();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

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
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.LightTheme,
        //darkTheme: AppThemes.DarkTheme,
        themeMode: ThemeMode.light,
        home: const LoginView(),
      ),
    );
  }
}
