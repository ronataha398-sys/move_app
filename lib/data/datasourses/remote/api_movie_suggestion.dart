import 'package:dio/dio.dart';
import 'package:movie_app/data/models/movie_suggestion_model.dart';
import 'package:movie_app/core/utils/app_constants.dart';

class ApiMovieSuggestion {
  static Dio dio = Dio(BaseOptions(baseUrl: AppConstants.BASE_URL));

  static Future<MovieSuggestions> getApi(
    int movieId,
  ) async {
    try {
      Response response =
          await dio.get('api/v2/movie_suggestions.json', queryParameters: {
        'movie_id': movieId,
      });

      MovieSuggestions movie = MovieSuggestions.fromJson(response.data);

      return movie;
    } catch (e) {
      throw Exception();
    }
  }
}
