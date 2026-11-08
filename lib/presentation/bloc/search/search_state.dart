import 'package:movie_app/data/models/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Movies> movies;

  SearchSuccess(this.movies);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}