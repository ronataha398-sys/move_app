

import '../../../../data/models/my_user.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final MyUser myUser;

  RegisterSuccess(this.myUser);
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}