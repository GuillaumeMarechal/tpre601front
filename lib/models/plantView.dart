import 'package:flutter/material.dart';
import 'careSession.dart';

class PlantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Name'),
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
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFA2C48B),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRow(Icons.person, 'Propriétaire :'),
                    Divider(color: Colors.grey),
                    _buildRow(Icons.event, 'Date du semis :'),
                    Divider(color: Colors.grey),
                    _buildRow(Icons.place, 'Lieu de plantation :'),
                    Divider(color: Colors.grey),
                    _buildRow(Icons.history, 'Dernier entretien :'),
                  ],
                ),
              ),
              SizedBox(height: 10), // Séparation de 10 pixels
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Historique de séance d\'entretiens :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: Colors.grey),
                    CareSession(),
                    CareSession(),
                    CareSession(),
                    CareSession(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
