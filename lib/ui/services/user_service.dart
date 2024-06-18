import 'dart:convert';

import 'package:arosaje/models/user_data.dart';
import 'package:arosaje/util/globals.dart';
import 'package:http/http.dart' as http;

import '../../models/body_dto.dart';

class UserService{
  static final String uri = 'http://10.0.2.2:8081/';

  Future<void> register(String id, String pseudo) async {
    final response = await http.post(Uri.parse('${uri}users/public/register'),
        headers: {"content-type" : "application/json"},
        body: json.encode( {
          "pseudo" : pseudo,
          "id" : id,
        }));
    if(response.statusCode != 200){
      print("aaaa ${response.body}");
    }
  }

  Future<UserData> getUserData() async {
    final response = await http.get(Uri.parse('${uri}users/informations'),
        headers: Globals.getHeader());
    if(response.statusCode == 200){
      return UserData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    else{
      throw Exception('Impossible de récupérer les donnees');
    }
  }

  Future<void> patchUserData(UserData userData) async {
    print(Globals.token);
    final response = await http.patch(Uri.parse('${uri}users/informations'),
        headers: Globals.getHeaderContentType(),
        body: json.encode(userData.toJson()));
    print(response.statusCode);
  }

  Future<bool> pseudoUsed(String pseudo) async{
    final response = await http.get(Uri.parse('${uri}users/public/pseudo/$pseudo'));
    if(response.statusCode == 200){
      BodyDTO bodyDTO = BodyDTO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return bodyDTO.body;
    }
    throw Exception();
  }
}