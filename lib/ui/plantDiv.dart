import 'package:arosaje/models/PlanteResume.dart';
import 'package:flutter/material.dart';
import 'plantView.dart';

class PlantDiv extends StatefulWidget {
  PlanteResume planteResume;

  PlantDiv(this.planteResume);

  @override
  _PlantDivState createState() => _PlantDivState();
}

class _PlantDivState extends State<PlantDiv> {
  bool isHovered = false;
  bool deleteHovered = false;
  bool editHovered = false;
  bool shareHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          //navigate vers plantPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlantPage(widget.planteResume.idPlantePerso)),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isHovered ? Color(0xFFA2C48B).withOpacity(0.5) : Color(0xFFA2C48B).withOpacity(0.3),
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
                          widget.planteResume.nomPlante,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        _buildTextWithIcon(Icons.person, 'Propriétaire : ${widget.planteResume.username}'),
                        _buildTextWithIcon(Icons.location_on, 'Lieu : ${widget.planteResume.adresseApproximative}'),
                        _buildTextWithIcon(Icons.event, 'Date du semis : ${widget.planteResume.dateCreation.toString()}'),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                deleteHovered = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                deleteHovered = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                print('Icône de poubelle cliquée');
                              },
                              child: Icon(Icons.delete, color: deleteHovered ? Colors.grey : null),
                            ),
                          ),
                          SizedBox(width: 8),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                editHovered = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                editHovered = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                print('Icône de crayon cliquée');
                              },
                              child: Icon(Icons.edit, color: editHovered ? Colors.grey : null),
                            ),
                          ),
                          SizedBox(width: 8),
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                shareHovered = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                shareHovered = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                print('Icône de partage cliquée');
                              },
                              child: Icon(Icons.share, color: shareHovered ? Colors.grey : null),
                            ),
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
