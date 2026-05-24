import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/book.dart';

class ApiService {

  static const String baseUrl =
      "http://localhost/library_api";

  // =========================
  // REGISTER
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

  // =========================
  // GET BOOKS
  // =========================

  static Future<List<Book>> getBooks()
  async {

    var url = Uri.parse(
      "$baseUrl/get_books.php",
    );

    var response = await http.get(url);

    List data = jsonDecode(response.body);

    return data
        .map((book) =>
        Book.fromJson(book))
        .toList();
  }

  // =========================
  // ADD FAVORITE
  // =========================

  static Future addFavorite({

    required String idUser,
    required String idBook,

  }) async {

    var url = Uri.parse(
      "$baseUrl/add_favorite.php",
    );

    var response = await http.post(

      url,

      body: {

        "id_user": idUser,
        "id_book": idBook,
      },
    );

    return jsonDecode(response.body);
  }

  // =========================
  // GET FAVORITES
  // =========================

  static Future<List<Book>>
  getFavorites(
      String idUser,
      ) async {

    var url = Uri.parse(
      "$baseUrl/get_favorites.php?id_user=$idUser",
    );

    var response = await http.get(url);

    List data = jsonDecode(response.body);

    return data
        .map((book) =>
        Book.fromJson(book))
        .toList();
  }

  // =========================
  // ADD BOOK
  // =========================

  static Future addBook({

    required String title,
    required String author,
    required String genre,
    required String description,
    required String filePath,

  }) async {

    var url = Uri.parse(
      "$baseUrl/add_book.php",
    );

    var response = await http.post(

      url,

      body: {

        "title": title,
        "author": author,
        "genre": genre,
        "description": description,
        "file_path": filePath,
      },
    );

    return jsonDecode(response.body);
  }

  // =========================
  // DELETE BOOK
  // =========================

  static Future deleteBook(
      String id,
      ) async {

    var url = Uri.parse(
      "$baseUrl/delete_book.php",
    );

    var response = await http.post(

      url,

      body: {
        "id": id,
      },
    );

    return jsonDecode(response.body);
  }

  // =========================
  // UPDATE BOOK
  // =========================

  static Future updateBook({

    required String id,
    required String title,
    required String author,
    required String genre,
    required String description,

  }) async {

    var url = Uri.parse(
      "$baseUrl/update_book.php",
    );

    var response = await http.post(

      url,

      body: {

        "id": id,
        "title": title,
        "author": author,
        "genre": genre,
        "description": description,
      },
    );

    return jsonDecode(response.body);
  }

  // =========================
  // UPLOAD PDF
  // =========================

  static Future uploadPdf(
      File file,
      ) async {

    var uri = Uri.parse(
      "$baseUrl/upload_pdf.php",
    );

    var request =
    http.MultipartRequest(
      'POST',
      uri,
    );

    request.files.add(

      await http.MultipartFile
          .fromPath(
        'pdf',
        file.path,
      ),
    );

    var response =
    await request.send();

    var responseData =
    await response.stream
        .bytesToString();

    return jsonDecode(responseData);
  }

  // =========================
  // ADD HISTORY
  // =========================

  static Future addHistory({

    required String idUser,
    required String idBook,

  }) async {

    var url = Uri.parse(
      "$baseUrl/add_history.php",
    );

    await http.post(

      url,

      body: {

        "id_user": idUser,
        "id_book": idBook,
      },
    );
  }

  // =========================
  // SEND MESSAGE
  // =========================

  static Future sendMessage({

    required String idUser,
    required String message,
    required String sender,

  }) async {

    var url = Uri.parse(
      "$baseUrl/send_message.php",
    );

    var response = await http.post(

      url,

      body: {

        "id_user": idUser,
        "message": message,
        "sender": sender,
      },
    );

    return jsonDecode(response.body);
  }

  // =========================
  // GET MESSAGES
  // =========================

  static Future<List> getMessages(
      String idUser,
      ) async {

    var url = Uri.parse(
      "$baseUrl/get_messages.php?id_user=$idUser",
    );

    var response = await http.get(url);

    return jsonDecode(response.body);
  }
}