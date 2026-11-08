import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/data/datasourses/remote/api_movie.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(state.copyWith(status: HomeStatus.loading));
      try {
        final response = await ApiMovie.getMovie();
        emit(state.copyWith(status: HomeStatus.success, movie: response));
      } catch (e) {
        emit(state.copyWith(
            status: HomeStatus.error, errorMessage: e.toString()));
      }
    });
    on<ChangeBackgroundImageEvent>((event, emit) {
      emit(state.copyWith(backgroundImage: event.image));
    });
  }
}
