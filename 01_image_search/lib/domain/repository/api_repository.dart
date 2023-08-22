import 'package:http/http.dart' as http;

abstract interface class ApiRepository {
  Future<http.Response> getImages(String query);
}
