import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/datasourses/remote/api_movie.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<Movies> allMovies = [];

  SearchBloc() : super(SearchInitial()) {
    on<GetMoviesEvent>(_getMovies);
    on<SearchMovieEvent>(_searchMovies);
  }

  Future<void> _getMovies(
      GetMoviesEvent event,
      Emitter<SearchState> emit,
      ) async {
    try {
      emit(SearchLoading());

      final result = await ApiMovie.getMovie();

      allMovies = result.data?.movies ?? [];

      emit(SearchSuccess(allMovies));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void _searchMovies(
      SearchMovieEvent event,
      Emitter<SearchState> emit,
      ) {
    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      emit(SearchSuccess(allMovies));
      return;
    }

    final filteredMovies = allMovies.where((movie) {
      return movie.title
          ?.toLowerCase()
          .contains(query) ??
          false;
    }).toList();

    emit(SearchSuccess(filteredMovies));
  }
}