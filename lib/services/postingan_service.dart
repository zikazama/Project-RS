import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aplikasi_rs/models/model_postingan.dart';
import 'dart:io';
import 'dart:developer' as developer;

class PostinganService {
  static Future<List<Postingan>> fetchPostingan() async {
    final apiUrl = 'https://api.rsbmgeriatri.com/api/posting';
    String usernameAuth = "admin";
    String passwordAuth = "1234";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$usernameAuth:$passwordAuth'));
    final response = await http.get(Uri.parse(apiUrl),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((postingan) => new Postingan.fromJson(postingan))
          .toList();
    } else {
      throw Exception('Failed to load postingan from API');
    }
  }
}
