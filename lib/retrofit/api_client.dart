import 'package:dio/dio.dart';
import 'package:prayer_location_finder_app/model/data.dart';
import 'package:prayer_location_finder_app/retrofit/apis.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: " http://api.aladhan.com/v1/gToH")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.data)
  Future<ResponseData> getData();
}
