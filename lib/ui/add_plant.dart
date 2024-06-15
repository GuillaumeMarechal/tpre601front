import 'package:arosaje/models/add_plante_personnelle.dart';
import 'package:arosaje/models/correct_position.dart';
import 'package:arosaje/models/plante_nom_commun.dart';
import 'package:arosaje/ui/services/PlanteService.dart';
import 'package:arosaje/util/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_input/image_input.dart';
import 'package:camera/camera.dart';
import 'dart:io' show Platform;

import 'login.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({super.key});

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  String errorMessage = "";
  TextEditingController quantiteController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController sowingDateController = TextEditingController();
  TextEditingController tipsController = TextEditingController();
  bool correctSelectedPlante = false;
  PlanteNomCommun? selectedPlante;
  List<XFile> images = [];
  late Future<List<PlanteNomCommun>> plantesNomOptions;

  PlanteService planteService = PlanteService();

  @override
  void initState() {
    super.initState();
    plantesNomOptions = planteService.fetchPlantesNomCommun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'lib/assets/arosaje.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: Text(
              'Se connecter',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, viewportConstraints){
          if(Globals.logged){
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Text('Ajouter une plante'),
                          Visibility(
                              visible: errorMessage != "",
                              child: Text(errorMessage)
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 12),
                                FutureBuilder(
                                    future: plantesNomOptions,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        List<PlanteNomCommun> options = snapshot.data!;
                                        return Autocomplete<PlanteNomCommun>(
                                          displayStringForOption: (option) => option.nomCommun,
                                          optionsBuilder: (TextEditingValue textEditingValue) {
                                            if(selectedPlante == null || (selectedPlante != null && textEditingValue.text != selectedPlante!.nomCommun)){
                                              correctSelectedPlante = false;
                                            }
                                            if (textEditingValue.text == '') {
                                              return const Iterable<PlanteNomCommun>.empty();
                                            }
                                            return options.where((PlanteNomCommun option) {
                                              return option.nomCommun.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                            });
                                          },
                                          onSelected: (PlanteNomCommun selection){
                                            correctSelectedPlante = true;
                                            selectedPlante = selection;
                                          },
                                          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                            return TextField(
                                              decoration: const InputDecoration(
                                                labelText: 'Nom de la plante',
                                              ),
                                              // decoratteion: const InputDecoration(border: OutlineInputBorder()),
                                              controller: textEditingController,
                                              focusNode: focusNode,
                                              onSubmitted: (String value) {},
                                            );
                                          },
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

                                    }
                                ),
                                const SizedBox(height: 12), // Espacement entre le titre et les champs de texte
                                TextFormField(
                                  controller: quantiteController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Quantite de plantes',
                                  ),
                                ),
                                const SizedBox(height: 12), // Espacement entre les champs de texte
                                TextFormField(
                                  controller: locationController,
                                  decoration: const InputDecoration(
                                    labelText: 'Lieu',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: sowingDateController,
                                  readOnly: true,
                                  onTap: () async {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    );
                                    if(picked != null){
                                      sowingDateController.text = "${picked.year}-${picked.month >= 10 ? picked.month : "0${picked.month}"}-${picked.day >= 10 ? picked.day : "0${picked.day}"}";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Date de semis',
                                    hintText: 'YYYY-MM-DD',
                                  ),
                                ),
                                const SizedBox(height: 12), // Espacement entre les champs de texte
                                TextFormField(
                                  controller: tipsController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    labelText: 'Conseils',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ImageInput(
                                  allowEdit: true,
                                  allowMaxImage: 5,
                                  getImageSource: (){
                                    return showDialog<ImageSource>(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          children: [
                                            SimpleDialogOption(
                                              child: const Text("Camera"),
                                              onPressed: () {
                                                Navigator.of(context).pop(ImageSource.camera);
                                              },
                                            ),
                                            SimpleDialogOption(
                                                child: const Text("Gallery"),
                                                onPressed: () {
                                                  Navigator.of(context).pop(ImageSource.gallery);
                                                }),
                                          ],
                                        );
                                      },
                                    ).then((value) {
                                      return value ?? ImageSource.gallery;
                                    });
                                  },
                                  getPreferredCameraDevice: () {
                                    return showDialog<CameraDevice>(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          children: [
                                            for(CameraDevice camera in CameraDevice.values)
                                              SimpleDialogOption(
                                                child: Text(camera.name),
                                                onPressed: () {
                                                  Navigator.of(context).pop(camera);
                                                },
                                              ),
                                          ],
                                        );
                                      },
                                    ).then(
                                          (value) {
                                        return value ?? CameraDevice.rear;
                                      },
                                    );
                                  },
                                  images: images,
                                  onImageSelected: (image) {
                                    if (!images.contains(image)) {
                                      setState(() {
                                        images.add(image);
                                      });
                                    }
                                  },
                                  onImageRemoved: (image, index) {
                                    if (images.contains(image)) {
                                      setState(() {
                                        images.remove(image);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if(!correctSelectedPlante || selectedPlante == null){
                                setState(() {
                                  errorMessage = "Le nom de la plante doit etre correctement renseigné.";
                                });
                                return;
                              }
                              if(quantiteController.text == ""){
                                setState(() {
                                  errorMessage = "La quantité doit etre renseigné.";
                                });
                                return;
                              }
                              CorrectPosition correctPosition = await planteService.isCorrectPosition(locationController.text);
                              if(!correctPosition.correct){
                                setState(() {
                                  errorMessage = "Le lieu renseigné n'existe pas ou n'est pas assez precis.";
                                });
                                return;
                              }
                              if(sowingDateController.text == ""){
                                setState(() {
                                  errorMessage = "La date de semis doit etre renseigné.";
                                });
                                return;
                              }
                              if(images.isEmpty){
                                setState(() {
                                  errorMessage = "Au moins une image doit etre renseigné.";
                                });
                                return;
                              }
                              List<String> displayName = correctPosition.displayName!.split(",");
                              String locationDisplayName = "${displayName[0]},${displayName[1]},${displayName[2]},${displayName[3]},${displayName[4]}";
                              AddPlantePersonnelle plantePersonnelle = AddPlantePersonnelle(int.parse(quantiteController.text), locationDisplayName, correctPosition.latitude!, correctPosition.longitude!, tipsController.text, sowingDateController.text, selectedPlante!.idPlante, images);
                              bool success = await planteService.addPlantePersonnelle(plantePersonnelle);
                              if(success){
                                Navigator.of(context).pop();
                              }
                              else{
                                setState(() {
                                  errorMessage = "Une error s'est produite.";
                                });
                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFFA2C48B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Ajouter'),
                          ),
                        ],
                      ),
                    )
                )
            );
          }
          else{
            return const Text("Vous devez etre connecté pour ajouter une plante");
          }
        },
      )
    );
  }
}
