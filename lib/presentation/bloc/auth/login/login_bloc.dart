import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    try {
      emit(LoginLoading());

      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password,
      );

      final user = credential.user;

      if (user == null) {
        emit(LoginError('User not found'));
        return;
      }

      emit(LoginSuccess(user));
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (e.code == 'invalid-credential') {
        message = 'Email or password is incorrect.';
      } else {
        message = e.message ?? 'Something went wrong';
      }

      emit(LoginError(message));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}