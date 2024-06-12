import 'package:arosaje/ui/add_plant.dart';
import 'package:arosaje/ui/plant_view.dart';
import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/globals.dart';
import '../models/plante_resume.dart';
import 'plant_div.dart';

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({super.key});

  @override
  State<MyPlantsPage> createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  TextEditingController searchController = TextEditingController();
  late Future<List<PlanteResume>> plantesResume;
  late Future<List<PlanteResume>>? plantesVisitesResume;
  PlanteService planteService = PlanteService();

  @override
  void initState(){
    super.initState();
    plantesResume = planteService.fetchPlantesResume(Globals.userId);
    if(Globals.botanist){
      plantesVisitesResume = planteService.fetchPlantesVisitesResume(Globals.userId);
    }
    else{
      plantesVisitesResume = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: searchController,
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
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  plantesResume = planteService.fetchPlantesResumeWithSearch(Globals.userId, searchController.text);
                  plantesVisitesResume = planteService.fetchPlantesVisitesResumeWithSearch(Globals.userId, searchController.text);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFA2C48B),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Rechercher'),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Column(
                  children: [
                    if(Globals.botanist)
                      const Text("Mes plantes"),
                    FutureBuilder(
                      future: plantesResume,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          List<PlanteResume> data = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index){
                              return MyPlantsDiv(data[index], refresh);
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
                        return const Center(child: CircularProgressIndicator(),);
                      },
                    ),
                    if(Globals.botanist)
                      const Text("Plantes déja visités"),
                    if(Globals.botanist)
                      FutureBuilder(
                        future: plantesVisitesResume,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            List<PlanteResume> data = snapshot.data!;
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index){
                                  return MyPlantsDiv(data[index], refresh);
                                }
                            );
                          }
                          else if(snapshot.hasError){
                            print(snapshot.error);
                            return Center(
                                child: Text(
                                    'Impossible de récup"rer les données : ${snapshot.error}'
                                )
                            );
                          }
                          return const Center(child: CircularProgressIndicator(),);
                        },
                      )
                  ]
              )
          )
        ),
        ElevatedButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPlant()),
            );
            setState(() {
              plantesResume = planteService.fetchPlantesResume(Globals.userId);
            });
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFA2C48B),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
              '+ Ajouter',
            style: TextStyle(fontSize: 26),
          ),
        ),
      ],
    );
  }

  refresh(){
    setState(() {
      plantesResume = planteService.fetchPlantesResume(Globals.userId);
    });
  }
}
