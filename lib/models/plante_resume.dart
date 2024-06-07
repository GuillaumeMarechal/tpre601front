import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'date_model.dart';

class PlanteResume{
  int idPlantePerso;
  int nombre;
  String adresseApproximative;
  DateModel dateCreation;
  String username;
  String nomPlante;
  Image image;

  PlanteResume(this.idPlantePerso, this.nombre, this.adresseApproximative, this.dateCreation, this.username, this.nomPlante, this.image);

  PlanteResume.fromJson(Map<String, dynamic> json):
        this.idPlantePerso = json["idPlantePerso"]??0,
        this.nombre = json["nombre"]??0,
        this.adresseApproximative = json["adresseApproximative"]??"",
        this.dateCreation = DateModel.fromTimestamp(json["dateCreation"]??""),
        this.username = json["username"]??"",
        this.nomPlante = json["nomPlante"]??"",
        this.image = getImageFromJson(json["image"]);

  static Image getImageFromJson(image){
    try{
      return Image.memory(base64Decode(image), fit: BoxFit.cover,);
    }
    catch(e){
      return Image.network("https://upload.wikimedia.org/wikipedia/commons/3/33/White_square_with_question_mark.png", fit: BoxFit.cover,);
    }
  }
}