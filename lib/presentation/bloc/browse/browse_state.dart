import 'package:movie_app/data/models/movie_model.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseSuccess extends BrowseState {
  final List<Movies> movies;
  final List<String> genres;
  final String selectedGenre;

  BrowseSuccess({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}

class BrowseError extends BrowseState {
  final String message;

  BrowseError(this.message);
}