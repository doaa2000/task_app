import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/users_screen/presentiation/manager/cubit/users_cubit.dart';

class HelloUser extends StatefulWidget {
  const HelloUser({super.key});

  @override
  State<HelloUser> createState() => _HelloUserState();
}

class _HelloUserState extends State<HelloUser> {
  @override
  void initState() {
    UsersCubit.get(context).fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('hello user')),
      body: BlocConsumer<UsersCubit, UsersState>(
        listenWhen: (previous, current) =>
            current is GetUsersSuccess ||
            current is GetUsersLoading ||
            current is GetUsersFailure,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetUsersSuccess) {
            return Column(
              children: [
                Text(state.usersModel.data?.rows?[0].arName ?? ''),
                Text(state.usersModel.data?.rows?[0].enName ?? ''),
              ],
            );
          } else if (state is GetUsersFailure) {
            return Container(
              child: Text(state.errorMessage),
            );
          } else {
            return const Text('oops');
          }
        },
      ),
    );
  }
}
