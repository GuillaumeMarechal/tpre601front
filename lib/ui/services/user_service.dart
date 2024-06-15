import 'dart:convert';

import 'package:arosaje/models/user_data.dart';
import 'package:arosaje/util/globals.dart';
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

  Future<UserData> getUserData() async {
    final response = await http.get(Uri.parse('${uri}users'),
        headers: Globals.getHeader());
    if(response.statusCode == 200){
      return UserData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    else{
      throw Exception('Impossible de récupérer les donnees');
    }
  }

  Future<void> patchUserData(UserData userData) async {
    final response = await http.post(Uri.parse('${uri}users'),
        headers: Globals.getHeaderContentType(),
        body: json.encode(userData.toJson()));
  }
}