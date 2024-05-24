import 'package:flutter/material.dart';
import 'plantView.dart';

class PlantDiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate vers plantPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantPage()),
        );
        print('PlantDiv cliquée');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFA2C48B).withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tournesol',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      _buildTextWithIcon(Icons.person, 'Propriétaire : '),
                      _buildTextWithIcon(Icons.location_on, 'Lieu : '),
                      _buildTextWithIcon(Icons.calendar_today, 'Dernier entretien : '),
                      _buildTextWithIcon(Icons.event, 'Date du semis : '),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Icône de poubelle cliquée');
                          },
                          child: Icon(Icons.delete),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            print('Icône de crayon cliquée');
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            print('Icône de partage cliquée');
                          },
                          child: Icon(Icons.share),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextWithIcon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
