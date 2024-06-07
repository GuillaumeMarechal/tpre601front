import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arosaje/models/date_model.dart';
import 'package:arosaje/models/plante_informations_entretien.dart';

class PlanteInformations{
  String nomPlante;
  String username;
  Image imagePrincipale;
  String adresseApproximative;
  DateModel dateCreation;
  String lieu;
  List<PlanteInformationsEntretien> entretiens;

  PlanteInformations.fromJson(Map<String, dynamic> json):
      this.nomPlante = json["nomPlante"]??"",
      this.username = json["username"]??"",
      this.imagePrincipale = getImageFromJson(json["imagePrincipale"]),
      this.adresseApproximative = json["adresseApproximative"]??"",
      this.dateCreation = DateModel.fromTimestamp(json["dateCreation"]??""),
      this.lieu = json["lieu"]??"",
      this.entretiens = PlanteInformationsEntretien.ListFromJson(json["entretiens"]??[]);

  DateModel getDateDernierEntretien(){
    DateModel dateModel = DateModel.zero();
    entretiens.forEach((element) {
      if(dateModel.earlierThan(element.dateEntretien)){
        dateModel = element.dateEntretien;
      }
    });
    return dateModel;
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