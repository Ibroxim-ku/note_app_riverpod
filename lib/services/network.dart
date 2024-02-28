import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  // baseUrl
  // static const BASEURL = 'dummyjson.com';
  static const BASEURL = '65dc5756e7edadead7ebaaae.mockapi.io';

  // APIS
  // static String apiGetAllProducts = '/products';
  // static String apiDeleteProduct = '/products/';
  static String apiGetAllProducts = '/notes';
  static String apiDeleteProduct = '/notes/';
  static String apiUpdateProduct = '/notes/';

  // headers
  static Map<String, String>? headers = {
    'Content-Type': 'application/json',
  };

  //methods
  static Future<String> GET(String api) async {
    final url = Uri.https(BASEURL, api);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return '\nError occurred on Status Code ${response.statusCode}\n';
    }
  }

  static Future<String?> POST(String api, Map<String, dynamic> body) async {
    Uri url = Uri.https(BASEURL, api);
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return response.reasonPhrase;
  }

  static Future<String?> PUT(
      String api, Map<String, dynamic> body, int id) async {
    final url = Uri.https(BASEURL, "$api$id");
    final response =
        await http.put(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, int id) async {
    final url = Uri.https(BASEURL, "$api${id.toString()}");
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  /// params
  static Map<String, String> emptyParams() => <String, String>{};

  /// body
  static Map<String, dynamic> bodyEmpty() => <String, dynamic>{};
}
