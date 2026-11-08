import '../../../data/models/my_user.dart';


abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final MyUser user;

  UserSuccess(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserLoggedOut extends UserState {}