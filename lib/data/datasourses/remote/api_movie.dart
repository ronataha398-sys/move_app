import 'package:dio/dio.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/core/utils/app_constants.dart';

class ApiMovie {
  static Dio dio = Dio(BaseOptions(baseUrl: AppConstants.BASE_URL));

  static Future<MovieModel> getMovie() async {
    try {
      Response response = await dio.get(
        '/api/v2/list_movies.json',
      );

      MovieModel movies = MovieModel.fromJson(response.data);

      print(movies.data?.movies?.first.mediumCoverImage);

      return movies;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}