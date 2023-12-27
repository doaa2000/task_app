part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class GetUsersLoading extends UsersState {}

final class GetUsersSuccess extends UsersState {
  final UsersModel usersModel;

  GetUsersSuccess({required this.usersModel});
}

final class GetUsersFailure extends UsersState {
  final String errorMessage;

  GetUsersFailure({required this.errorMessage});
}
