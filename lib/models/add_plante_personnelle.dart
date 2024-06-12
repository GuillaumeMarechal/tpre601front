import 'dart:convert';
import 'dart:typed_data';

import 'package:image_input/image_input.dart';

class AddPlantePersonnelle {
  int nombre;
  String adresseApproximative;
  String dateCreation;
  String latitude;
  String longitude;
  String conseils;
  int userIdUser;
  int planteIdPlante;
  List<XFile> images;

  AddPlantePersonnelle(this.nombre, this.adresseApproximative, this.latitude, this.longitude, this.conseils, this.dateCreation, this.userIdUser, this.planteIdPlante, this.images);

  Future<Map<String, dynamic>> toJson() async {
    List<String> imagesByte = [];
    for(var elt in this.images){
      var imageByte = await elt.readAsBytes();
      imagesByte.add(base64.encode(Uint8List.sublistView(imageByte)));
    }
    return {
      "nombre" : this.nombre,
      "adresseApproximative" : this.adresseApproximative,
      "dateCreation" : this.dateCreation,
      "latitude" : this.latitude,
      "longitude" : this.longitude,
      "conseils" : this.conseils,
      "userIdUser" : this.userIdUser,
      "planteIdPlante" : this.planteIdPlante,
      "images" : imagesByte,
    };
  }
}