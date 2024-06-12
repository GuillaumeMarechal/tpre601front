class PlanteNomCommun{
  int idPlante;
  String nomCommun;

  PlanteNomCommun.fromJson(Map<String, dynamic> json):
        this.idPlante = json["idPlante"],
        this.nomCommun = json["nomCommun"]??"";
}