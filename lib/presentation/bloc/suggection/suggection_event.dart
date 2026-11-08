class SuggectionEvent {}

class GetSuggectionEvent extends SuggectionEvent {
  final int movieId;

  GetSuggectionEvent({required this.movieId});
}
