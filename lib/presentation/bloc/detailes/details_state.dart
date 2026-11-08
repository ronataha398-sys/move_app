import 'package:movie_app/data/models/movie_details_model.dart';

enum DetailsStatus { initial, loading, success, error }

class DetailsState {
  MovieDetailsModel? movieDetails;
  String? errorMessage;
  DetailsStatus status = DetailsStatus.initial;
  DetailsState(
      {this.movieDetails,
      this.errorMessage,
      this.status = DetailsStatus.initial});
  DetailsState copyWith({
    MovieDetailsModel? movieDetails,
    String? errorMessage,
    DetailsStatus? status,
  }) {
    return DetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}

class DetailsInitial extends DetailsState {
  DetailsInitial() : super(status: DetailsStatus.initial);
}
