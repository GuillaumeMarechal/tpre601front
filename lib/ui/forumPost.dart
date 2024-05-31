import 'package:flutter/material.dart';

class ForumPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Définir l'action à effectuer lors du clic sur l'élément
        print('Post cliqué!');
        // Vous pouvez également naviguer vers une nouvelle page ou effectuer toute autre action ici.
      },
      child: Container(
        height: 150.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFA2C48B).withOpacity(0.4),
          borderRadius: BorderRadius.circular(8.0), // Radius des coins
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Titre du post',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0), // Espacement entre le titre et les tags
              Row(
                children: [
                  _buildTag('Tag1'),
                  SizedBox(width: 8.0), // Espacement entre les tags
                  _buildTag('Tag2'),
                  SizedBox(width: 8.0), // Espacement entre les tags
                  _buildTag('Tag3'),
                  // Ajoutez ici autant de tags que nécessaire
                ],
              ),
              SizedBox(height: 8.0), // Espacement entre les tags et le contenu
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'Contenu du post ici. Ce texte peut être long et nécessiter un défilement si nécessaire.',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        tag,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
