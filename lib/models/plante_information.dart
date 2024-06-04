import 'package:arosaje/models/date_model.dart';
import 'package:arosaje/models/plante_informations_entretien.dart';

class PlanteInformations {
  String nomPlante;
  String username;
  String lienImagePrincipale;
  String adresseApproximative;
  DateModel dateCreation;
  String lieu;
  List<PlanteInformationsEntretien> entretiens;

  PlanteInformations.fromJson(Map<String, dynamic> json):
      this.nomPlante = json["nomPlante"]??"",
      this.username = json["username"]??"",
      this.lienImagePrincipale = json["lienImagePrincipale"]??"",
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
}