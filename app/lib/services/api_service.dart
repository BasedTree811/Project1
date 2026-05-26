import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ApiService {

  // =========================
  // BASE URL
  // =========================

  static const String baseUrl =
      "http://localhost/library_api";

  // =========================
  // LOGIN USER
  // =========================

  static Future<Map<String, dynamic>>
  loginUser({

    required String login,

    required String password,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/login.php",
        ),

        body: {

          "login": login,

          "password": password,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return {

        "success": false,

        "message":
        "Ошибка подключения"
      };
    }
  }

  // =========================
  // REGISTER USER
  // =========================

  static Future<Map<String, dynamic>>
  registerUser({

    required String surname,

    required String name,

    required String email,

    required String login,

    required String password,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/register.php",
        ),

        body: {

          "surname": surname,

          "name": name,

          "email": email,

          "login": login,

          "password": password,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return {

        "success": false,

        "message":
        "Ошибка подключения"
      };
    }
  }

  // =========================
  // GET BOOKS
  // =========================

  static Future<List<dynamic>>
  getBooks() async {

    try {

      var response = await http.get(

        Uri.parse(
          "$baseUrl/get_books.php",
        ),
      );

      return jsonDecode(response.body);

    } catch (e) {

      return [];
    }
  }

  // =========================
  // ADD BOOK
  // =========================

// ======================
// ADD BOOK
// ======================

  static Future<Map<String, dynamic>>
  addBook({

    required String title,
    required String author,
    required String genre,
    required String description,
    required String filePath,

  }) async {

    try {

      var request =
      http.MultipartRequest(

        "POST",

        Uri.parse(
          "$baseUrl/add_book.php",
        ),
      );

      request.fields["title"] =
          title;

      request.fields["author"] =
          author;

      request.fields["genre"] =
          genre;

      request.fields["description"] =
          description;

      request.files.add(

        await http.MultipartFile
            .fromPath(
          "pdf",
          filePath,
        ),
      );

      var response =
      await request.send();

      var responseData =
      await response.stream.bytesToString();

      return jsonDecode(responseData);

    } catch (e) {

      return {

        "success": false,

        "message":
        "Ошибка: $e",
      };
    }
  }

  // =========================
  // UPDATE BOOK
  // =========================

  static Future<Map<String, dynamic>>
  updateBook({

    required String id,

    required String title,

    required String author,

    required String genre,

    required String description,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/update_book.php",
        ),

        body: {

          "id": id,

          "title": title,

          "author": author,

          "genre": genre,

          "description": description,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return {

        "success": false,
      };
    }
  }

  // =========================
  // DELETE BOOK
  // =========================

  static Future<Map<String, dynamic>>
  deleteBook({

    required String id,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/delete_book.php",
        ),

        body: {

          "id": id,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return {

        "success": false,
      };
    }
  }

  // =========================
  // FAVORITES
  // =========================

  static Future<Map<String, dynamic>>
  addFavorite({

    required String userId,

    required String bookId,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/add_favorite.php",
        ),

        body: {

          "user_id": userId,

          "book_id": bookId,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return {

        "success": false,
      };
    }
  }

  static Future<List<dynamic>>
  getFavorites({

    required String userId,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/get_favorites.php",
        ),

        body: {

          "user_id": userId,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return [];
    }
  }

  // =========================
  // CHAT
  // =========================

  static Future<List<dynamic>>
  getMessages() async {

    try {

      var response = await http.get(

        Uri.parse(
          "$baseUrl/get_messages.php",
        ),
      );

      return jsonDecode(response.body);

    } catch (e) {

      return [];
    }
  }

  static Future<Map<String, dynamic>>
  sendMessage({

    required String user,

    required String message,

  }) async {

    try {

      var response = await http.post(

        Uri.parse(
          "$baseUrl/send_message.php",
        ),

        body: {

          "user": user,

          "message": message,
        },
      );

      return jsonDecode(response.body);

    } catch (e) {

      return {

        "success": false,
      };
    }
  }

  // =========================
  // PDF UPLOAD
  // =========================

  static Future<Map<String, dynamic>>
  uploadPdfWeb({

    required Uint8List pdfBytes,

    required String fileName,

  }) async {

    try {

      var uri = Uri.parse(
        "$baseUrl/upload_pdf.php",
      );

      var request =
      http.MultipartRequest(
        'POST',
        uri,
      );

      request.files.add(

        http.MultipartFile.fromBytes(

          'pdf',

          pdfBytes,

          filename: fileName,
        ),
      );

      var response =
      await request.send();

      var responseBody =
      await response.stream
          .bytesToString();

      return jsonDecode(responseBody);

    } catch (e) {

      return {

        "success": false,

        "message":
        "Ошибка загрузки PDF"
      };
    }
  }
}