import '../../../data/models/movie_model.dart';


abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final List<Movies> watchList;
  final List<Movies> history;
  final int wishListCount;

  ProfileSuccess({
    required this.watchList,
    required this.history,
    required this.wishListCount,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}