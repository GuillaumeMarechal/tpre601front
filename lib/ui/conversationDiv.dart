import 'package:arosaje/ui/messageUserView.dart';
import 'package:flutter/material.dart';

class ConversationDiv extends StatelessWidget {
  final String id;
  final String pseudo;

  ConversationDiv({required this.id, required this.pseudo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('User ID: $id');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageUserView()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints(maxHeight: 75.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5.0),
            right: Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(2, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 50.0,
                height: 50.0,
                color: Colors.grey,
                child: Center(
                  child: Icon(Icons.person, color: Colors.white, size: 30.0),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pseudo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text('Dernier message : ...'),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              '23/05/2024',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
