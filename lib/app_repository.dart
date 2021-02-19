import 'package:dio/dio.dart';
import 'package:prayer_location_finder_app/retrofit/api_client.dart';

class AppRepository {
  ApiClient _apiRequest;
  Dio dio;

  AppRepository() {
    dio = Dio();
    _apiRequest = ApiClient(dio);
  }
}
