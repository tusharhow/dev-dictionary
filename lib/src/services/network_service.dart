import 'package:http/http.dart' as http;

class NetworkService {
  static Future<http.Response> get(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load word');
    }
  }
}
