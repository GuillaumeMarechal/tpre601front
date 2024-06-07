import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arosaje/models/date_model.dart';

class PlanteInformationsEntretien{
  String nomGardien;
  DateModel dateEntretien;
  bool problemeEntretien;
  bool problemeSante;
  String commentaire;
  List<Image> images;

  PlanteInformationsEntretien.fromJson(Map<String, dynamic> json):
      this.nomGardien = json["nomGardien"]??"",
      this.dateEntretien = DateModel.fromTimestamp(json["dateEntretien"]??""),
      this.problemeEntretien = json["problemeEntretien"]??false,
      this.problemeSante = json["problemeSante"]??false,
      this.commentaire = json["commentaire"]??"",
      this.images = getListImages(json["images"]??[]);

  static List<PlanteInformationsEntretien> ListFromJson(List<dynamic> json){
      return json.map((e) => PlanteInformationsEntretien.fromJson(e)).toList();
  }
  
  static List<Image> getListImages(List<dynamic> listImages){
    return listImages.map((e) => getImageFromJson(e)).toList();
  }

  static Image getImageFromJson(image){
    try{
      return Image.memory(base64Decode(image), fit: BoxFit.cover,);
    }
    catch(e){
      return Image.network("https://upload.wikimedia.org/wikipedia/commons/3/33/White_square_with_question_mark.png", fit: BoxFit.cover,);
    }
  }
}