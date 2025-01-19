import 'dart:convert';
import 'package:fitness/Utils/base_url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>?> loginUser(
      String email, String password) async {
    final url =
        Uri.parse(BaseURL + 'Hdl_Signin.ashx?email=$email&password=$password');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      if (responseBody.isNotEmpty) {
        return responseBody[0];
      }
    }
    return null;
  }
}
