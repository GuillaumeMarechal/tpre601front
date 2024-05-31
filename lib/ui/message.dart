import 'package:flutter/material.dart';
import 'messageUser.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher des messages',
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
        Expanded(
          child: ListView(
            children: [
              MessageUser(),
              SizedBox(height: 4),
              MessageUser(),
              SizedBox(height: 4),
              MessageUser(),
              SizedBox(height: 4),
            ],
          ),
        ),
      ],
    );
  }
}
