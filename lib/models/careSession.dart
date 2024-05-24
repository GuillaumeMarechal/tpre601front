import 'package:flutter/material.dart';

class CareSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10), // Marge de 5px sur les côtés gauche, droit et bas
        padding: EdgeInsets.all(10), // Rembourrage de 10px de chaque côté
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5), // Contour de 0.5 en noir
          borderRadius: BorderRadius.circular(5), // Bordure arrondie de 5px
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom du gardien :', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('Date séance :', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Checkbox(value: true, onChanged: null), // Case cochée pour Problème entretien
                Text('Problème entretien'),
                SizedBox(width: 20),
                Checkbox(value: false, onChanged: null), // Case non cochée pour Problème de santé
                Text('Problème de santé'),
              ],
            ),
            SizedBox(height: 5),
            Text('Commentaire :', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(),
            ),
            SizedBox(height: 10),
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
      color: Colors.blueGrey, // Couleur d'exemple pour l'image
    );
  }
}
