import 'package:movie_app/data/models/movie_suggestion_model.dart';

enum SuggectionStatus { initial, loading, success, error }

class SuggectionState {
  MovieSuggestions? movieSuggection;
  String? errorMessage;
  SuggectionStatus status = SuggectionStatus.initial;
  SuggectionState({
    this.movieSuggection,
    this.errorMessage,
    this.status = SuggectionStatus.initial,
  });

  SuggectionState copyWith({
    MovieSuggestions? movieSuggectionModel,
    String? errorMessage,
    SuggectionStatus? status,
  }) {
    return SuggectionState(
      movieSuggection: movieSuggectionModel ?? this.movieSuggection,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}

class SuggectionInitial extends SuggectionState {
  SuggectionInitial() : super(status: SuggectionStatus.initial);
}
