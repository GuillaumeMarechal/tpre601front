import 'package:arosaje/models/valider_entretien.dart';
import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:arosaje/util/globals.dart';
import 'package:flutter/material.dart';

import '../models/plante_informations_entretien.dart';
import '../util/button.dart';

class CareSession extends StatefulWidget {
  PlanteInformationsEntretien planteInformationsEntretien;

  Function() refresh;

  CareSession(this.planteInformationsEntretien, this.refresh, {super.key});

  @override
  State<CareSession> createState() => _CareSessionState();
}

class _CareSessionState extends State<CareSession> {
  PlanteService planteService = PlanteService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10), // Marge de 5px sur les côtés gauche, droit et bas
        padding: const EdgeInsets.all(10), // Rembourrage de 10px de chaque côté
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom du gardien : ${widget.planteInformationsEntretien.nomGardien == "" ? "En attente" : widget.planteInformationsEntretien.nomGardien}', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('Date séance : ${widget.planteInformationsEntretien.dateEntretien}', style: TextStyle(fontWeight: FontWeight.bold)),
            if(widget.planteInformationsEntretien.nomGardien == "")
              getSansGardien(),
            if(widget.planteInformationsEntretien.nomGardien != "" && !widget.planteInformationsEntretien.visiteEffectue)
              getVisiteNonEffectue(),
            if(widget.planteInformationsEntretien.nomGardien != "" && widget.planteInformationsEntretien.visiteEffectue)
              for(Widget widget in getVisiteEffectue())
                widget,
          ],
        ),
      ),
    );
  }

  getSansGardien(){
    if(Globals.botanist){
      return Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                await planteService.sePositionner(widget.planteInformationsEntretien.idVisite, Globals.userId);
                widget.refresh();
              },
              style: commonButtonStyle,
              child: const Text("Se positionner")
          )
        ],
      );
    }
    return Container();
  }

  getVisiteNonEffectue(){
    if(Globals.botanist && widget.planteInformationsEntretien.idGardien == Globals.userId){
      return Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                await planteService.seRetirer(widget.planteInformationsEntretien.idVisite);
                widget.refresh();
              },
              child: const Text("Se retirer")
          ),
          ElevatedButton(
              onPressed: () async {
                bool result = await showDialog(
                  context: context,
                  builder: (context) {
                    bool? problemeEntretien = false;
                    bool? problemeSante = false;
                    TextEditingController controller = TextEditingController();
                    return StatefulBuilder(
                        builder: (context, setState){
                          return AlertDialog(
                            title: Text("Valider une séance"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: problemeEntretien,
                                        onChanged: (value) {
                                          setState(() {
                                            problemeEntretien = value;
                                          });
                                        },
                                      ),
                                      const Text("Probleme entretien")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: problemeSante,
                                        onChanged: (value) {
                                          setState(() {
                                            problemeSante = value;
                                          });
                                        },
                                      ),
                                      const Text("Probleme de sante")
                                    ],
                                  ),
                                  TextFormField(
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    controller: controller,
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Annuler")
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await planteService.validerEntretien(ValiderEntretien(widget.planteInformationsEntretien.idVisite, problemeEntretien!, problemeSante!, controller.text));
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Valider")
                              ),
                            ],
                          );
                        }
                    );
                  },
                );
                widget.refresh();
              },
              child: const Text("Valider")
          )
        ],
      );
    }
    return Container();
  }

  getVisiteEffectue(){
    return [
      Row(
        children: [
          Checkbox(value: widget.planteInformationsEntretien.problemeEntretien, onChanged: null), // Case cochée pour Problème entretien
          const Text('Problème entretien'),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.planteInformationsEntretien.problemeSante, onChanged: null), // Case non cochée pour Problème de santé
          const Text('Problème de santé'),
        ],
      ),
      const SizedBox(height: 5),
      const Text('Commentaire :', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      Text(
        widget.planteInformationsEntretien.commentaire,
        style: const TextStyle(),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10, // Espacement entre les images
        runSpacing: 10, // Espacement entre les lignes d'images
        children: [
          for(Image image in widget.planteInformationsEntretien.images)
            Container(
              height: 100,
              child: image,
            ),
        ],
      ),
    ];
  }
}
