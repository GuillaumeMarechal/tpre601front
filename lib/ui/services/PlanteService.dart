import 'dart:convert';

import 'package:arosaje/models/body_dto.dart';
import 'package:arosaje/models/MapInformationPosition.dart';
import 'package:arosaje/models/plante_information.dart';
import 'package:arosaje/models/plante_resume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../models/map_informations.dart';

class PlanteService{
  static final String uri = 'http://localhost:8081/';

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
      List<Marker> markers = json.map((e) => Marker(
          point: LatLng(e["latitude"], e["longitude"]),
          child: const Icon(Icons.pin_drop)
      )).toList();
      return MapInformations(MapInformationPosition.fromPosition(position), markers);
    }
    else{
      throw Exception('Failed to get markers');
    }
  }
}