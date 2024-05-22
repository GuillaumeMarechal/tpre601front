import 'package:flutter/material.dart';
import 'plantDiv.dart';

class PlantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher des plantes',
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
            SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                _showAddPlantDialog(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFA2C48B),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('+ Ajouter'),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          PlantDiv(),
          SizedBox(height: 8), // Espacement vertical entre les PlantDiv
          PlantDiv(),
          SizedBox(height: 8),
          PlantDiv(),
          SizedBox(height: 8),
          // Ajoutez autant de PlantDiv que nécessaire ici
        ],
      ),
    );
  }

  void _showAddPlantDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController locationController = TextEditingController();
        final TextEditingController lastMaintenanceController = TextEditingController();
        final TextEditingController sowingDateController = TextEditingController();

        return AlertDialog(
          title: Text('Ajouter une plante'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                  ),
                ),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Lieu',
                  ),
                ),
                TextField(
                  controller: lastMaintenanceController,
                  decoration: InputDecoration(
                    labelText: 'Date de dernier entretien',
                    hintText: 'YYYY-MM-DD',
                  ),
                ),
                TextField(
                  controller: sowingDateController,
                  decoration: InputDecoration(
                    labelText: 'Date de semis',
                    hintText: 'YYYY-MM-DD',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Ajouter'),
              onPressed: () {
                // Vous pouvez ici gérer les données du formulaire
                String name = nameController.text;
                String location = locationController.text;
                String lastMaintenance = lastMaintenanceController.text;
                String sowingDate = sowingDateController.text;

                // Exemple d'affichage des données
                print('Nom: $name');
                print('Lieu: $location');
                print('Date de dernier entretien: $lastMaintenance');
                print('Date de semis: $sowingDate');

                // Fermer le dialogue
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
