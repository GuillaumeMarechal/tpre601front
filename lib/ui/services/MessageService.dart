import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user_id_pseudo.dart';
import 'package:arosaje/util/globals.dart';

class MessageService {
  static final String uri = 'http://10.0.2.2:8081/';

  Future<List<UserIdPseudo>> getConversation(String search) async {
    final response = await http.get(Uri.parse('${uri}users/$search'),
        headers: Globals.getHeader());
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      List<UserIdPseudo> conversations = data.map((item) => UserIdPseudo.fromJson(item)).toList();
      return conversations;
    } else {
      throw Exception('Impossible de récupérer les données');
    }
  }
}
