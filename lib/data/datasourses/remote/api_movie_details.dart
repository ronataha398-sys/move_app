import 'package:dio/dio.dart';
import 'package:movie_app/data/models/movie_details_model.dart';
import 'package:movie_app/core/utils/app_constants.dart';

class ApiMovieDetails {
  static Dio dio = Dio(BaseOptions(baseUrl: AppConstants.BASE_URL));

  static Future<MovieDetailsModel> getDetails(
      int movieId, bool with_cast) async {
    try {
      Response response =
          await dio.get('api/v2/movie_details.json', queryParameters: {
        'movie_id': movieId,
        'with_cast': with_cast,
      });
      print(response.data);
      MovieDetailsModel details = MovieDetailsModel.fromJson(response.data);
      print("CAST: ${response.data['data']['movie']['cast']}");
      return details;
    } catch (e, stackTrace) {
      print("API ERROR: $e");
      print("STACK TRACE: $stackTrace");
      throw Exception(e);
    }
  }
}
