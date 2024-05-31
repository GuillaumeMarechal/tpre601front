import 'package:flutter/material.dart';

class MessageUserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('[User Name]'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Espace à droite de l'image
            child: Image.asset(
              'lib/assets/arosaje.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ici vous pouvez ajouter le contenu principal de votre page
                  // C'est la zone où vous affichez les messages de l'utilisateur
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[200], // Couleur de fond de la barre fixe
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: () {
                      // Logique pour prendre une photo
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      // Logique pour sélectionner une image
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logique pour envoyer le message
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color(0xFFA2C48B), // Texte blanc
                    ),
                    child: Text('Envoyer'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
