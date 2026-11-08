abstract class SearchEvent {}

class GetMoviesEvent extends SearchEvent {}

class SearchMovieEvent extends SearchEvent {
  final String query;

  SearchMovieEvent(this.query);
}