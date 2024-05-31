import 'package:flutter/material.dart';
import 'messageUser.dart'; // Assurez-vous d'importer correctement le fichier messageUser.dart

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher des messages',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          MessageUser(), // Utilisez MessageUser() au lieu de MessagePage()
          SizedBox(height: 4), // Espacement vertical entre les MessageUser
          MessageUser(),
          SizedBox(height: 4),
          MessageUser(),
          SizedBox(height: 4),
          // Ajoutez autant de MessageUser que nécessaire ici
        ],
      ),
    );
  }
}
