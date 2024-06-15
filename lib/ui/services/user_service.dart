import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/body_dto.dart';

class UserService{
  static final String uri = 'http://10.0.2.2:8081/';

  Future<void> register(String pseudo) async {
    final response = await http.post(Uri.parse('${uri}users'),
        headers: {"content-type" : "application/json"},
        body: json.encode( {
          "pseudo" : pseudo,
        }));
  }
}