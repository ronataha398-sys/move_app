import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import '../../../../data/datasourses/remote/firebase_utils.dart';
import '../../../../data/models/my_user.dart';
import 'register_event.dart';
import 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_register);
  }

  Future<void> _register(
      RegisterSubmitted event,
      Emitter<RegisterState> emit,
      ) async {
    try {
      emit(RegisterLoading());

      // Create account in Firebase Authentication
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password,
      );

      // Create User Model
      final MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        name: event.name.trim(),
        email: event.email.trim(),
        phone: event.phone.trim(),
      );

      // Save User in Firestore
      await FireBaseUtils.addUserInFireStore(myUser);

      emit(RegisterSuccess(myUser));
    } on FirebaseAuthException catch (e) {
      String message;

      if (e.code == 'weak-password') {
        message = 'The Password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else {
        message = e.message ?? 'Something went wrong';
      }

      emit(RegisterError(message));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}