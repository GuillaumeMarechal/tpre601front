import 'dart:convert';

import 'package:arosaje/models/add_plante_personnelle.dart';
import 'package:arosaje/models/body_dto.dart';
import 'package:arosaje/models/MapInformationPosition.dart';
import 'package:arosaje/models/patch_plante_personnelle_conseils.dart';
import 'package:arosaje/models/plante_information.dart';
import 'package:arosaje/models/plante_nom_commun.dart';
import 'package:arosaje/models/plante_resume.dart';
import 'package:arosaje/models/valider_entretien.dart';
import 'package:arosaje/ui/value_widget.dart';
import 'package:arosaje/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../models/correct_position.dart';
import '../../models/map_informations.dart';

class PlanteService{
  static final String uri = 'http://10.0.2.2:8081/';

  Future<List<PlanteResume>> fetchPlantesResume(int userId) async {
    List<PlanteResume> list = [];

    try{
      final response = await http.get(Uri.parse('${uri}plantes/resume?userId=${userId}'));
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

  Future<List<PlanteResume>> fetchPlantesResumeWithSearch(int userId, String search) async {
    List<PlanteResume> list = [];
    try{
      final response = await http.get(Uri.parse('${uri}plantes/resume?userId=${userId}&search=${search}'));
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

  Future<List<PlanteResume>> fetchPlantesVisitesResume(int gardienId) async {
    List<PlanteResume> list = [];

    try{
      final response = await http.get(Uri.parse('${uri}plantes/resume?gardienId=${gardienId}'));
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

  Future<List<PlanteResume>> fetchPlantesVisitesResumeWithSearch(int gardienId, String search) async {
    List<PlanteResume> list = [];
    try{
      final response = await http.get(Uri.parse('${uri}plantes/resume?gardienId=${gardienId}&search=${search}'));
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

  Future<PlanteInformations> fetchPlanteInformatios(int id) async {
    final response = await http.get(Uri.parse('${uri}plantes/$id'));
    if(response.statusCode == 200){
      BodyDTO bodyDTO = BodyDTO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      if(bodyDTO.body is Map<String, dynamic>){
        return PlanteInformations.fromJson(bodyDTO.body);
      }
      else{
        throw new Exception(bodyDTO.body);
      }
    }
    else{
      throw new Exception('Impossible de récupérer les donnees');
    }
  }

  Future<MapInformations> fetchMapInformation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final response = await http.post(
        Uri.parse("${uri}plantes/position"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "latitude" : position.latitude,
          "longitude" : position.longitude,
          "portee" : 4,
        })
    );
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
      List<Marker> markers = json.map((e) {
        Color color = Colors.black;
        if(e['visiteLibre']){
          color = Colors.red;
        }
        if(e['idUser'] == Globals.userId){
          color = Colors.blue;
        }
        return Marker(
            point: LatLng(e["latitude"], e["longitude"]),
            child: ValueWidget(
              value: e['idPlantePerso'],
              child: Icon(
                Icons.pin_drop,
                color: color,
              ),
            )
        );
      }).toList();
      return MapInformations(MapInformationPosition.fromPosition(position), markers);
    }
    else{
      throw Exception('Failed to get markers');
    }
  }

  Future<CorrectPosition> isCorrectPosition(String position) async {
    final response = await http.get(
        Uri.parse("https://geocode.maps.co/search"
            "?q=$position"
            "&api_key=666781196db94489601763igb1158ca")
    );
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
      if(json.length != 1){
        return CorrectPosition(false);
      }
      return CorrectPosition(true, latitude: json[0]["lat"], longitude: json[0]["lon"], displayName: json[0]["display_name"]);
    }
    else{
      return CorrectPosition(false);
    }
  }

  Future<List<PlanteNomCommun>> fetchPlantesNomCommun() async{
    List<PlanteNomCommun> list = [];

    try{
      final response = await http.get(Uri.parse('${uri}plantes/nom_communs'));
      if(response.statusCode == 200){
        BodyDTO bodyDTO = BodyDTO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        if(bodyDTO.body is List<dynamic>){
          for(var value in bodyDTO.body){
            list.add(PlanteNomCommun.fromJson(value));
          }
        }
        else{
          throw Exception(bodyDTO.body);
        }
      }
      else{
        throw Exception('Impossible de récupérer les donnees');
      }
    }
    catch(e){
      throw e;
    }
    return list;
  }

  Future<bool> addPlantePersonnelle(AddPlantePersonnelle addPlantePersonnelle) async {
    final response = await http.post(Uri.parse('${uri}plantes'), headers: {"content-type" : "application/json"}, body: json.encode( await addPlantePersonnelle.toJson()));
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<bool> patchPlantePersonnelleConseils(PatchPlantePersonnelleConseils dto) async{
    final response = await http.patch(Uri.parse('${uri}plantes/conseils'), headers: {"content-type" : "application/json"}, body: json.encode( await dto.toJson()));
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<bool> deletePlantePersonnelle(int id) async{
    final response = await http.delete(Uri.parse('${uri}plantes/$id'));
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<void> sePositionner(int id, int gardienId) async{
    await http.post(Uri.parse('${uri}visites/positionner'),
        headers: {"content-type" : "application/json"},
        body: json.encode({
          "idVisite": id,
          "gardienIdUser": gardienId
        }));
  }

  Future<void> validerEntretien(ValiderEntretien dto) async{
    await http.post(Uri.parse('${uri}visites/valider'),
        headers: {"content-type" : "application/json"},
        body: json.encode(dto.toJson()));
  }

  Future<bool> ajouterEntretien(String date, int idPlante) async{
    final response = await http.post(Uri.parse('${uri}visites/ajouter'),
        headers: {"content-type" : "application/json"},
        body: json.encode({
          "dateVisite" : date,
          "plantePersonnelleIdPlantePerso" : idPlante
        }));
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<void> seRetirer(int id) async{
    await http.delete(Uri.parse('${uri}visites/positionner/${id}'));
  }
}