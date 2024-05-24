import 'package:flutter/material.dart';
import 'forumPost.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher des forums',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action pour commencer une discussion
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFA2C48B),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Commencer une discussion'),
                  ),
                ),
                SizedBox(width: 16), // Espacement entre les deux boutons
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action pour filtrer
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.black, width: 0.5),
                      ),
                    ),
                    child: Text('Filtre'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Espacement entre les boutons et le post
            Expanded(
              child: Container( // Envelopper ListView dans un Container
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200), // Définir une hauteur maximale pour le ListView
                child: ListView(
                  children: [
                    ForumPost(), // Utilisez ForumPost() au lieu de MessagePage()
                    SizedBox(height: 8), // Espacement vertical entre les ForumPost
                    ForumPost(),
                    SizedBox(height: 8),
                    ForumPost(),
                    SizedBox(height: 8),
                    // Ajoutez autant de ForumPost que nécessaire ici
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
