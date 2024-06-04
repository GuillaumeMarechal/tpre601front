
import 'date_model.dart';

class PlanteResume{
  int idPlantePerso;
  int nombre;
  String adresseApproximative;
  DateModel dateCreation;
  String username;
  String nomPlante;

  PlanteResume(this.idPlantePerso, this.nombre, this.adresseApproximative, this.dateCreation, this.username, this.nomPlante);

  PlanteResume.fromJson(Map<String, dynamic> json):
        this.idPlantePerso = json["idPlantePerso"]??0,
        this.nombre = json["nombre"]??0,
        this.adresseApproximative = json["adresseApproximative"]??"",
        this.dateCreation = DateModel.fromTimestamp(json["dateCreation"]??""),
        this.username = json["username"]??"",
        this.nomPlante = json["nomPlante"]??"";
}