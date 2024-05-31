import 'package:arosaje/ui/messageUserView.dart';
import 'package:flutter/material.dart';

class MessageUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageUserView()),
        );
        print('MessageUser tapped!');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        padding: EdgeInsets.all(10.0), // Ajouter un padding autour du contenu
        constraints: BoxConstraints(maxHeight: 75.0), // Définir la hauteur maximale
        decoration: BoxDecoration(
          color: Colors.white, // Fond blanc
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5.0),
            right: Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), // Ombre portée noire avec opacité
              offset: Offset(2, 2), // Décalage vers le bas à droite
              blurRadius: 4.0, // Flou
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 50.0,
                height: 50.0,
                color: Colors.grey, // Vous pouvez remplacer par l'image
                child: Center(
                  child: Icon(Icons.person, color: Colors.white, size: 30.0), // Ajuster la taille de l'icône
                ), // Ajouter un peu d'espace à droite de l'image
              ),
            ),
            SizedBox(width: 10.0), // Ajouter un espacement entre l'image et le texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Prénom Nom',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0), // Ajouter un espacement entre les deux textes
                  Text('Dernier message : ...'),
                ],
              ),
            ),
            SizedBox(width: 10.0), // Ajouter un espacement entre le texte et la date
            Text(
              '23/05/2024',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
