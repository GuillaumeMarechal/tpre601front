import 'package:arosaje/models/date_model.dart';

class PlanteInformationsEntretien{
  String nomGardien;
  DateModel dateEntretien;
  bool problemeEntretien;
  bool problemeSante;
  String commentaire;
  List<String> lienImages;

  PlanteInformationsEntretien.fromJson(Map<String, dynamic> json):
      this.nomGardien = json["nomGardien"]??"",
      this.dateEntretien = DateModel.fromTimestamp(json["dateEntretien"]??""),
      this.problemeEntretien = json["problemeEntretien"]??false,
      this.problemeSante = json["problemeSante"]??false,
      this.commentaire = json["commentaire"]??"",
      this.lienImages = List<String>.from(json["lienImages"]??[]);

  static List<PlanteInformationsEntretien> ListFromJson(List<dynamic> json){
      return json.map((e) => PlanteInformationsEntretien.fromJson(e)).toList();
  }
}