abstract class BrowseEvent {}

class GetBrowseMoviesEvent extends BrowseEvent {}

class SelectGenreEvent extends BrowseEvent {
  final String genre;

  SelectGenreEvent(this.genre);
}