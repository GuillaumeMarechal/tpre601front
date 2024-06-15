import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arosaje/models/date_model.dart';
import 'package:arosaje/models/plante_informations_entretien.dart';

class PlanteInformations{
  int idPlantePerso;
  String nomPlante;
  String idUser;
  String username;
  List<Image> images;
  String adresseApproximative;
  DateModel dateCreation;
  String lieu;
  List<PlanteInformationsEntretien> entretiens;
  int quantite;
  String conseils;

  PlanteInformations.fromJson(Map<String, dynamic> json):
    this.idPlantePerso = json["idPlantePerso"]??0,
    this.nomPlante = json["nomPlante"]??"",
    this.idUser = json["idUser"]??0,
    this.username = json["username"]??"",
    this.images = getImages(json["images"]),
    this.adresseApproximative = json["adresseApproximative"]??"",
    this.dateCreation = DateModel.fromTimestamp(json["dateCreation"]??""),
    this.lieu = json["lieu"]??"",
    this.entretiens = PlanteInformationsEntretien.ListFromJson(json["entretiens"]??[]),
    this.quantite = json["quantite"]??0,
    this.conseils = json["conseils"]??"";

  DateModel getDateDernierEntretien(){
    DateModel dateModel = DateModel.zero();
    entretiens.forEach((element) {
      if(dateModel.earlierThan(element.dateEntretien)){
        dateModel = element.dateEntretien;
      }
    });
    return dateModel;
  }



  static List<Image> getImages(var imagesBytes){
    if(imagesBytes == null){
      return [];
    }
    List<Image> images = [];
    for(var element in imagesBytes){
      images.add(Image.memory(base64Decode(element)));
    };
    return images;
  }

  static Image getImageFromJson(image){
    try{
      return Image.memory(base64Decode(image), fit: BoxFit.contain,);
    }
    catch(e){
      return Image.network("https://upload.wikimedia.org/wikipedia/commons/3/33/White_square_with_question_mark.png", fit: BoxFit.cover,);
    }
  }
}