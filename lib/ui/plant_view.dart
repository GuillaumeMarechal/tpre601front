import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:flutter/material.dart';
import '../models/plante_information.dart';
import 'careSession.dart';

class PlantPage extends StatefulWidget {
  final int idPlante;

  const PlantPage(this.idPlante, {super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  late Future<PlanteInformations> futPlanteInformations;
  PlanteService planteService = PlanteService();

  @override
  void initState(){
    super.initState();
    futPlanteInformations = planteService.fetchPlanteInformatios(widget.idPlante);
  }

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
      body: FutureBuilder(
          future: futPlanteInformations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PlanteInformations planteInformations = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
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
                            _buildRow(Icons.person, 'Propriétaire : ${planteInformations.username}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.event, 'Date du semis : ${planteInformations.dateCreation}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.place, 'Lieu de plantation : ${planteInformations.adresseApproximative}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.history, 'Dernier entretien : ${planteInformations.getDateDernierEntretien().toString()}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10), // Séparation de 10 pixels
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
                            const Text(
                              'Historique de séance d\'entretiens :',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: planteInformations.entretiens.length,
                                itemBuilder: (context, index) {
                                  return CareSession(planteInformations.entretiens[index]);
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Impossible de récup"rer les données : ${snapshot.error}'
                  )
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
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
