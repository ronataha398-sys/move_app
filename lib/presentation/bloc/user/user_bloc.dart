import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasourses/remote/firebase_utils.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>(_loadUser);
    on<ClearUserEvent>(_clearUser);
  }

  Future<void> _loadUser(
      LoadUserEvent event,
      Emitter<UserState> emit,
      ) async {
    try {
      emit(UserLoading());

      final user = await FireBaseUtils.readUserFromFireStore(
        event.userId,
      );

      if (user == null) {
        emit(UserError('User data not found'));
        return;
      }

      emit(UserSuccess(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _clearUser(
      ClearUserEvent event,
      Emitter<UserState> emit,
      ) {
    emit(UserLoggedOut());
  }
}