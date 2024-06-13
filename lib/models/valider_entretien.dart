class ValiderEntretien{
  int idVisite;
  bool problemeVisite;
  bool problemeSante;
  String commentaire;

  ValiderEntretien(this.idVisite, this.problemeVisite, this.problemeSante, this.commentaire);

  toJson(){
    return {
      "idVisite" : idVisite,
      "problemeVisite" : problemeVisite,
      "problemeSante" : problemeSante,
      "commentaire" : commentaire,
    };
  }
}