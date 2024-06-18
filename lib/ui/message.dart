import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final bool isReceived;
  final String message;

  const Message({Key? key, required this.isReceived, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(12.0),  // Augmenté le padding pour une meilleure apparence
        margin: isReceived
            ? EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0, right: 80.0)  // Marge à gauche pour les messages reçus
            : EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0, left: 80.0),  // Marge à droite pour les messages envoyés
        decoration: BoxDecoration(
          color: isReceived ? Colors.grey[300] : Colors.blue[300],  // Couleur différente pour les messages reçus et envoyés
          borderRadius: BorderRadius.circular(20.0),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,  // Limite la largeur du conteneur à 70% de la largeur de l'écran
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
