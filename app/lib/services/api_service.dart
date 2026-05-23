import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Для Android Emulator
  static const String baseUrl =
      "http://10.0.2.2/library_api";

  // =========================
  // REGISTRATION
  // =========================

  static Future registerUser({
    required String surname,
    required String name,
    required String email,
    required String login,
    required String password,
  }) async {

    var url = Uri.parse(
      "$baseUrl/register.php",
    );

    var response = await http.post(
      url,

      body: {
        "surname": surname,
        "name": name,
        "email": email,
        "login": login,
        "password": password,
      },
    );

    return jsonDecode(response.body);
  }

  // =========================
  // LOGIN
  // =========================

  static Future loginUser({
    required String login,
    required String password,
  }) async {

    var url = Uri.parse(
      "$baseUrl/login.php",
    );

    var response = await http.post(
      url,

      body: {
        "login": login,
        "password": password,
      },
    );

    return jsonDecode(response.body);
  }
}