import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasourses/remote/firebase_utils.dart';
import '../../../data/models/movie_model.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc
    extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_loadProfile);
    on<RefreshProfileEvent>(_loadProfile);
  }

  Future<void> _loadProfile(
      ProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    final String userId;

    if (event is LoadProfileEvent) {
      userId = event.userId;
    } else if (event is RefreshProfileEvent) {
      userId = event.userId;
    } else {
      return;
    }

    try {
      emit(ProfileLoading());

      final results = await Future.wait([
        FireBaseUtils.getWatchList(userId),
        FireBaseUtils.getHistory(userId),
        FireBaseUtils.getSaveCount(userId),
      ]);

      final watchList = results[0] as List<Movies>;
      final history = results[1] as List<Movies>;
      final wishListCount = results[2] as int;

      emit(
        ProfileSuccess(
          watchList: watchList,
          history: history,
          wishListCount: wishListCount,
        ),
      );
    } catch (e) {
      emit(
        ProfileError(e.toString()),
      );
    }
  }
}