
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/data/datasourses/remote/api_movie_details.dart';

import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<GetDetailsEvent>((event, emit) async {
      emit(state.copyWith(status: DetailsStatus.loading));
      try {
        final response = await ApiMovieDetails.getDetails(event.id, true);
        emit(state.copyWith(
            status: DetailsStatus.success, movieDetails: response));
      } catch (e) {
        emit(state.copyWith(
            status: DetailsStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
