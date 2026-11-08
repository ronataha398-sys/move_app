import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/data/datasourses/remote/api_movie_suggestion.dart';
import 'package:movie_app/presentation/bloc/suggection/suggection_event.dart';
import 'package:movie_app/presentation/bloc/suggection/suggection_state.dart';

class SuggectionBlock extends Bloc<SuggectionEvent, SuggectionState> {
  SuggectionBlock() : super(SuggectionInitial()) {
    on<GetSuggectionEvent>((event, emit) async {
      emit(state.copyWith(status: SuggectionStatus.loading));
      try {
        final response = await ApiMovieSuggestion.getApi(event.movieId);
        emit(state.copyWith(
            status: SuggectionStatus.success, movieSuggectionModel: response));
      } catch (e) {
        emit(state.copyWith(
            status: SuggectionStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
