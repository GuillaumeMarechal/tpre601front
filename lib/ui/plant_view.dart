import 'package:arosaje/models/patch_plante_personnelle_conseils.dart';
import 'package:arosaje/models/plante_informations_entretien.dart';
import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:arosaje/util/globals.dart';
import 'package:flutter/material.dart';
import '../models/plante_information.dart';
import '../util/button.dart';
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

  void refresh(){
    setState(() {
      futPlanteInformations = planteService.fetchPlanteInformatios(widget.idPlante);
    });
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
              List<PlanteInformationsEntretien> entretiens = planteInformations.entretiens;
              entretiens.sort((elt1, elt2) {
                return elt2.dateEntretien.toInt() - elt1.dateEntretien.toInt();
              });
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
                            _buildRow(Icons.note, 'Quantite : ${planteInformations.quantite}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.event, 'Date du semis : ${planteInformations.dateCreation}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.place, 'Lieu de plantation : ${planteInformations.adresseApproximative}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.history, 'Dernier entretien : ${planteInformations.getDateDernierEntretien().toString()}'),
                            const Divider(color: Colors.grey),
                            _buildRow(Icons.note, 'Conseils : \n${planteInformations.conseils}'),
                            if(planteInformations.idUser == Globals.uid())
                              ElevatedButton(
                              onPressed: () {
                                TextEditingController controller = TextEditingController();
                                controller.text = planteInformations.conseils;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Modification des conseils"),
                                      content: TextFormField(
                                        controller: controller,
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        decoration: const InputDecoration(
                                          labelText: 'Conseils',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                            style:commonButtonStyle,
                                          child: const Text("Annuler")),
                                        TextButton(
                                          onPressed: () async {
                                            bool result = await planteService.patchPlantePersonnelleConseils(PatchPlantePersonnelleConseils(planteInformations.idPlantePerso, controller.text));
                                            if(result){
                                              Navigator.pop(context);
                                              setState(() {
                                                futPlanteInformations = planteService.fetchPlanteInformatios(widget.idPlante);
                                              });
                                            }
                                          },
                                            style:commonButtonStyle,
                                          child: const Text("Valider")
                                        )
                                      ],
                                    );
                                  }
                                );
                              },
                                  style: commonButtonStyle,
                              child: const Text("Modifier les conseils.")
                            ),
                            const Divider(color: Colors.grey),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                for(Image image in planteInformations.images)
                                  Container(
                                    height: 100,
                                    child: image,
                                  ),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                            if(planteInformations.idUser == Globals.uid())
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Suppression de la plante"),
                                        content: const Text("Etes-vous sur de vouloir retirer la plante ?\nCette action est definitive."),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                              style:commonButtonStyle,
                                            child: const Text("Annuler")
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await planteService.deletePlantePersonnelle(planteInformations.idPlantePerso);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                              style:commonButtonStyle,
                                            child: const Text("Valider")
                                          )
                                        ],
                                      );
                                    }
                                  );
                                },
                                  style: commonButtonStyle,
                                child: const Text("Retirer la plante.")
                            ),
                          ],
                        ),
                      ),
                      if(planteInformations.idUser == Globals.uid())
                        const SizedBox(height: 10), // Séparation de 10 pixels
                      if(planteInformations.idUser == Globals.uid())
                        Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: ElevatedButton(
                              onPressed: () async{
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController controller = TextEditingController();
                                      bool error = false;
                                      String errorMessage = "";
                                      return StatefulBuilder(
                                        builder: (context, setState){
                                          return AlertDialog(
                                            title: Text("Ajouter un entretien"),
                                            content:  SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  if(error)
                                                    Text(errorMessage),
                                                  TextFormField(
                                                    controller: controller,
                                                    readOnly: true,
                                                    onTap: () async {
                                                      FocusScope.of(context).requestFocus(FocusNode());
                                                      DateTime? picked = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(2000),
                                                        lastDate: DateTime(3000),
                                                      );
                                                      if(picked != null){
                                                        controller.text = "${picked.year}-${picked.month >= 10 ? picked.month : "0${picked.month}"}-${picked.day >= 10 ? picked.day : "0${picked.day}"}";
                                                      }
                                                    },
                                                    decoration: const InputDecoration(
                                                      labelText: 'Date de l\'entretien',
                                                      hintText: 'YYYY-MM-DD',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  style: commonButtonStyle,
                                                  child: Text("Annuler")
                                              ),
                                              TextButton(
                                                  onPressed: () async{
                                                    if(controller.text != ""){
                                                      bool ok = await planteService.ajouterEntretien(controller.text, widget.idPlante);
                                                      if(ok){
                                                        Navigator.pop(context);
                                                      }
                                                      else{
                                                        setState((){
                                                          error = true;
                                                          errorMessage = "Une erreur s'est produite";
                                                        });
                                                      }
                                                    }
                                                    else{
                                                      setState((){
                                                        error = true;
                                                        errorMessage = "La date est incorrecte";
                                                      });
                                                    }
                                                  },
                                                  style: commonButtonStyle,
                                                  child: Text("Valider")
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                );
                                refresh();
                              },
                              style: commonButtonStyle,
                              child: const Text("Programmer un entretien")
                          ),
                        )
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
                                itemCount: entretiens.length,
                                itemBuilder: (context, index) {
                                  return CareSession(entretiens[index], refresh);
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
          Flexible(
            child: Text(
                text,
                style: TextStyle(
                    color: Colors.black,
                    overflow: TextOverflow.clip
                )
            ),
          )
        ],
      ),
    );
  }
}
