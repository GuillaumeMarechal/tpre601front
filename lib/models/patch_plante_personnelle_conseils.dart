class PatchPlantePersonnelleConseils {
  int idPlantePerso;
  String conseils;

  PatchPlantePersonnelleConseils(this.idPlantePerso, this.conseils);

  Future<Map<String, dynamic>> toJson() async {
    List<String> imagesByte = [];
    return {
      "idPlantePerso" : this.idPlantePerso,
      "conseils" : this.conseils
    };
  }
}
