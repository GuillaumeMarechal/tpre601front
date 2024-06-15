class UserData{
  String pseudo;
  String nom;
  String prenom;

  UserData(this.pseudo, this.nom, this.prenom);

  UserData.fromJson(Map<String, dynamic> json):
        this.pseudo = json["pseudo"]??"",
        this.nom = json["nom"]??"",
        this.prenom = json["prenom"]??"";

  Map<String, dynamic> toJson() {
    return {
      "pseudo" : this.pseudo,
      "nom" : this.nom,
      "prenom" : this.prenom
    };
  }
}