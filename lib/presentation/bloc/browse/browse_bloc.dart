import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/datasourses/remote/api_movie.dart';

import 'browse_event.dart';
import 'browse_state.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  List<Movies> allMovies = [];

  BrowseBloc() : super(BrowseInitial()) {
    on<GetBrowseMoviesEvent>(_getMovies);
    on<SelectGenreEvent>(_selectGenre);
  }

  Future<void> _getMovies(
      GetBrowseMoviesEvent event,
      Emitter<BrowseState> emit,
      ) async {
    try {
      emit(BrowseLoading());

      final result = await ApiMovie.getMovie();

      allMovies = result.data?.movies ?? [];

      final Set<String> genreSet = {};

      for (final movie in allMovies) {
        genreSet.addAll(movie.genres ?? []);
      }

      final genres = genreSet.toList();

      emit(
        BrowseSuccess(
          movies: allMovies,
          genres: genres,
          selectedGenre: genres.isNotEmpty ? genres.first : '',
        ),
      );
    } catch (e) {
      emit(BrowseError(e.toString()));
    }
  }

  void _selectGenre(
      SelectGenreEvent event,
      Emitter<BrowseState> emit,
      ) {
    if (state is! BrowseSuccess) return;

    final currentState = state as BrowseSuccess;

    emit(
      BrowseSuccess(
        movies: allMovies,
        genres: currentState.genres,
        selectedGenre: event.genre,
      ),
    );
  }
}