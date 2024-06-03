import 'dart:convert';
import 'package:arosaje/models/BodyDTO.dart';
import 'package:arosaje/models/PlanteResume.dart';
import 'package:http/http.dart' as http;

class PlanteService{
  static final String uri = 'http://localhost:8081/';

  Future<List<PlanteResume>> fetchPlantesResume() async {
    List<PlanteResume> list = [];

    try{
      final response = await http.get(Uri.parse('${uri}plantes/resume?userId=1'));
      if(response.statusCode == 200){
        BodyDTO bodyDTO = BodyDTO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        if(bodyDTO.body is List<dynamic>){
          for(var value in bodyDTO.body){
            list.add(PlanteResume.fromJson(value));
          }
        }
        else{
          throw new Exception(bodyDTO.body);
        }
      }
      else{
        throw new Exception('Impossible de récupérer les donnees');
      }
    }
    catch(e){
      throw e;
    }
    return list;
  }
}