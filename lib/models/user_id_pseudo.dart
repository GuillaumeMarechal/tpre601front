class UserIdPseudo {
  String pseudo;
  String id;

  UserIdPseudo(this.pseudo, this.id);

  UserIdPseudo.fromJson(Map<String, dynamic> json)
      : pseudo = json["pseudo"] ?? "",
        id = json["id"] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "pseudo": pseudo,
      "id": id,
    };
  }
}