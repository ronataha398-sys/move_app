import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/datasourses/remote/api_movie.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState {
  MovieModel? movie;
  String? errorMessage;
  HomeStatus status = HomeStatus.initial;
  String? backgroundImage;
  HomeState({
    this.movie,
    this.errorMessage,
    this.status = HomeStatus.initial,
    this.backgroundImage,
  });

  HomeState copyWith({
    MovieModel? movie,
    String? errorMessage,
    HomeStatus? status,
    String? backgroundImage,
  }) {
    return HomeState(
        movie: movie ?? this.movie,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        backgroundImage: backgroundImage ?? this.backgroundImage);
  }
}

class HomeInitial extends HomeState {
  HomeInitial() : super(status: HomeStatus.initial);
}
