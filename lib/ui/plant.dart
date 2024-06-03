import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:flutter/material.dart';
import '../models/PlanteResume.dart';
import 'plantDiv.dart';

class PlantsPage extends StatefulWidget {
  const PlantsPage({super.key});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  late Future<List<PlanteResume>> plantesResume;
  PlanteService planteService = PlanteService();

  @override
  void initState(){
    plantesResume = planteService.fetchPlantesResume();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
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
          Expanded(
              child: FutureBuilder(
                future: plantesResume,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<PlanteResume> data = snapshot.data!;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          return PlantDiv(data[index]);
                        }
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(
                        child: Text(
                            'Impossible de récup"rer les données : ${snapshot.error}'
                        )
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                },
              )
          )
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
          content: Container(
            width: 400, // Largeur du formulaire
            height: 300, // Hauteur du formulaire
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12), // Espacement entre le titre et les champs de texte
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                    ),
                  ),
                  SizedBox(height: 12), // Espacement entre les champs de texte
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Lieu',
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: lastMaintenanceController,
                    decoration: InputDecoration(
                      labelText: 'Date de dernier entretien',
                      hintText: 'YYYY-MM-DD',
                    ),
                  ),
                  SizedBox(height: 12),
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
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFA2C48B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
