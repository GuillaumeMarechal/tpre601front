import 'package:flutter/material.dart';

import '../models/plante_informations_entretien.dart';

class CareSession extends StatefulWidget {
  PlanteInformationsEntretien planteInformationsEntretien;

  CareSession(this.planteInformationsEntretien, {super.key});

  @override
  State<CareSession> createState() => _CareSessionState();
}

class _CareSessionState extends State<CareSession> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10), // Marge de 5px sur les côtés gauche, droit et bas
        padding: const EdgeInsets.all(10), // Rembourrage de 10px de chaque côté
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5), // Contour de 0.5 en noir
          borderRadius: BorderRadius.circular(5), // Bordure arrondie de 5px
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom du gardien : ${widget.planteInformationsEntretien.nomGardien}', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('Date séance : ${widget.planteInformationsEntretien.dateEntretien}', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Checkbox(value: widget.planteInformationsEntretien.problemeEntretien, onChanged: null), // Case cochée pour Problème entretien
                const Text('Problème entretien'),
                const SizedBox(width: 20),
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
                _buildSquareImage(),
                _buildSquareImage(),
                _buildSquareImage(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareImage() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blueGrey,
    );
  }
}
